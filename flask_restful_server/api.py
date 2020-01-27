import json
import ssl

import jwt
from flask import Flask, request
from flask_restful import Resource, Api, reqparse
from flask_cors import CORS
from ldap3 import Tls
from flask_ldap3_login import LDAP3LoginManager
from flask_mysqldb import MySQL
import functools

with open('config.json') as json_data_file:
    ldap_login_data = json.load(json_data_file)

tls = Tls(validate=ssl.CERT_REQUIRED, version=ssl.PROTOCOL_TLSv1,
          ca_certs_file='./ca.pem')

config = dict()

# LDAB configurations
config['LDAP_HOST'] = 'ldaps://dc02.intern.satzmedia.de'
config['LDAP_PORT'] = 636
config['LDAP_USE_SSL'] = True
config['LDAP_USER_LOGIN_ATTR'] = 'mail'
config['LDAP_BIND_USER_DN'] = ldap_login_data.get("LDAP_BIND_USER_DN", "")
config['LDAP_BIND_USER_PASSWORD'] = ldap_login_data.get(
    "LDAP_BIND_USER_PASSWORD", "")
config['LDAP_BASE_DN'] = 'dc=intern,dc=satzmedia,dc=de'
config['LDAP_USER_DN'] = 'cn=users'
config['LDAP_ADD_SERVER'] = False

ldap_manager = LDAP3LoginManager()
ldap_manager.init_config(config)

ldap_manager.add_server(
    config.get('LDAP_HOST'),
    config.get('LDAP_PORT'),
    config.get('LDAP_USE_SSL'),
    tls_ctx=tls
)

app = Flask(__name__)
api = Api(app)
CORS(app)

# Config MySQL
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = '1234'
app.config['MYSQL_DB'] = 'reports_app'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'

# init MYSQL
mysql = MySQL(app)


def login_required(method):
    @functools.wraps(method)
    def wrapper(self):
        email = request.headers.get('username', '')
        password = request.headers.get('password', '')

        _password = {"email": email, "password": password}
        _encryptedPassword = jwt.encode(_password, "password", "HS256").decode('UTF-8')

        cur = mysql.connection.cursor()

        cur.execute("SELECT * FROM users WHERE `email` = %s AND `u_password` = %s;", (email, _encryptedPassword))

        user = cur.fetchone()
        print(user["roll"])

        # Cursor close
        cur.close()

        # abort(400, message='Login faild.')
        isLoggedin = True,  # TODO: Uncomment this ldap_manager.authenticate(email, password)
        isNewUser = len(user) == 0
        isAdmin = user.get("roll", -1) != -1 and user.get("roll", -1) == 2
        isPM = user.get("roll", -1) != -1 and user.get("roll", -1) == 1

        status = {}

        status["isLoggedin"] = isLoggedin
        status["isNewUser"] = isNewUser
        status["isAdmin"] = isAdmin
        status["isPM"] = isPM

        return method(self, status)

    return wrapper


class GetUsers(Resource):
    parser = reqparse.RequestParser()
    parser.add_argument('userEmail')

    @login_required
    def get(self, status):
        return status


api.add_resource(GetUsers, "/")

if __name__ == '__main__':
    app.run(port=5000, host="0.0.0.0")
