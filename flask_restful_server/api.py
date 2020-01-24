import json
import ssl
from io import StringIO
from json import dumps, loads, load, dump
from flask import Flask, render_template, Response, request, make_response
from flask_restful import Resource, Api, reqparse, abort
from datetime import datetime as dt, timedelta as td, date as d
from flask_cors import CORS
from urllib.request import urlopen, Request
from ldap3 import Server, Connection, ALL, Tls
from flask_ldap3_login import LDAP3LoginManager
from flask_mysqldb import MySQL
from bson import json_util
import datetime
import functools
import jwt
from enum import Enum
from werkzeug.security import generate_password_hash, check_password_hash

with open('config.json') as json_data_file:
    ldap_login_data = json.load(json_data_file)

tls = Tls(validate=ssl.CERT_REQUIRED, version=ssl.PROTOCOL_TLSv1,
          ca_certs_file='./ca.pem')

config = dict()

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


AuthenticationResponseStatus = Enum(
    'AuthenticationResponseStatus', 'fail success')

def login_required(method):
    @functools.wraps(method)
    def wrapper(self):
        username = request.headers.get('username', '')
        password = request.headers.get('password', '')

        cur = mysql.connection.cursor()
        # Get group by group
        cur.execute("SELECT * FROM users WHERE `u_name` LIKE %s AND `u_password` LIKE %s;", (username, password))

        users = cur.fetchall()

        # Cursor close
        cur.close()

        #abort(400, message='Login faild.')
        manager = ldap_manager.authenticate(username, password)
        isLoggedin = str(manager.status) == "AuthenticationResponseStatus.success"
        return method(self,  isLoggedin)
    return wrapper



class GetUsers(Resource):
    parser = reqparse.RequestParser()
    parser.add_argument('userEmail')

    @login_required

    def get(self, isLoggedin):
        message = ""
        if (isLoggedin):
            message= "you are logged in"
        else: 
            message= "you are not logged in"
        return message

api.add_resource(GetUsers, "/")




if __name__ == '__main__':
    app.run(port=5000, host="0.0.0.0")
