import json
import ssl
from io import StringIO
from json import dumps, loads, load, dump
from flask import Flask, render_template, Response, request, make_response
from flask_restful import Resource, Api, reqparse
from datetime import datetime as dt, timedelta as td, date as d
from flask_cors import CORS
from urllib.request import urlopen, Request
from ldap3 import Server, Connection, ALL, Tls
from flask_ldap3_login import LDAP3LoginManager

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

config['LDAP_BIND_USER_PASSWORD'] = ldap_login_data.get("LDAP_BIND_USER_PASSWORD", "")

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

response = ldap_manager.authenticate('UserEmail', 'Password')
print(response.status)

# app = Flask(__name__)
# api = Api(app)
# CORS(app)


# class GebetsZeiten(Resource):

#     parser = reqparse.RequestParser()
#     parser.add_argument('lat', required=True)
#     parser.add_argument('lng', required=True)
#     parser.add_argument('language', required=False)
#     parser.add_argument('today', required=False)

#     def get(self):
#         args = self.parser.parse_args()
#         return timesConverterToDartDateTimeFormat(args.get('lat', False), args.get('lng', False), args.get('language', None), args.get('today', None))

# api.add_resource(GebetsZeiten, "/")


# class PrivacyPolicy(Resource):
#     def __init__(self):
#         pass
#     def get(self):
#         headers = {'Content-Type': 'text/html'}
#         return make_response(render_template('privacy_policy.html', title='Home', user='user'), 200, headers)

# api.add_resource(PrivacyPolicy, "/privacy-policy")

#api.add_resource(TermsAndConditions, "/terms-and-conditions")

# if __name__ == '__main__':
#     app.run(port=5000, host="0.0.0.0")
