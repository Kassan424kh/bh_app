import datetime
import json
import os

from flask_restful import Resource, reqparse, abort
from jwt import encode

from api_server.db.database import Database
from api_server.db.ldapServerConnection import authUser

cwd = os.getcwd()

class Login(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('email', required=True, type=str, location="headers")
        parser.add_argument('password', required=True, type=str, location="headers")

        email = parser.parse_args().get('email')
        password = parser.parse_args().get('password')

        user = {}
        try:
            ldap_login_check = authUser(email, password).get("loggedIn")

            if ldap_login_check:
                user_data_from_ldap = authUser(email, password)

                user = Database.get_user(email=email)
                if user is None: # Create user if no found any in the DB
                    Database.create_user(
                        first_and_last_name=user_data_from_ldap.get("name"),
                        email=email,
                        birthday="",
                        roll=0
                    )
                    user = Database.get_user(email=email)

            # failed login to ldap server
            else:
                abort(401, message='Login faild.')
        except ():
            abort(401, message='Login faild.')

        encoded_access_token = ""
        if len(user.keys()) > 0 and user.get("email", "") != "":
            with open('{0}/api_server/config.json'.format(cwd), 'rb') as f:
                app_configs= json.load(f)
                exp = datetime.datetime.utcnow() + datetime.timedelta(days=app_configs.get("ACTIVATION_EXPIRE_DAYS"))
                user_token_data = {"email": user.get("email"), 'exp': exp}
                encoded_access_token = encode(user_token_data, app_configs.get("ACCESS_TOKEN_KEY"), "HS256")
        if encoded_access_token == "":
            abort(401, message="Can not create token")

        return {"access-token": encoded_access_token}, 201, {'Access-Control-Allow-Origin': '*'}
