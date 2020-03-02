import functools
import json
import os

import jwt
from jwt import decode
from flask import request
from flask_restful import abort
from ..db.database import Database

cwd = os.getcwd()

# LOGIN TESTER
def login_required(method):
    @functools.wraps(method)
    def wrapper(self):
        access_token = request.headers.get('access-token', '')
        if access_token  == "":
            abort(401, message='Please login again')
        with open('{}/api_server/config.json'.format(cwd), 'r') as f:
            app_configs = json.load(f)
            try:
                decoded_user_data = decode(access_token, app_configs.get("ACCESS_TOKEN_KEY"), "HS256")
            except jwt.DecodeError:
                abort(401, message='Token is not valid.')
            except jwt.ExpiredSignatureError:
                abort(406, message='Token is expired.')
        get_user_from_db = Database.get_user(email=decoded_user_data.get("email"))
        user = get_user_from_db if get_user_from_db is not None else {}

        user_data = {}
        data = {"loginStatus": True}
        if len(user.keys()) > 0:
            user_data["userId"] = user.get("u_id", -1)
            user_data["firstAndLastName"] = user.get("first_and_last_name", "No Name")
            user_data["email"] = user.get("email", "No email")
            user_data["birthday"] = user.get("birthday", "No Birthday")
            user_data["isAdmin"] = user.get("roll", -1) != -1 and user.get("roll", -1) == 2
            user_data["isPM"] = user.get("roll", -1) != -1 and user.get("roll", -1) == 1

            data["userData"] = user_data
            if not user.get("is_new_user") and Database.get_trainees_data(user_data["userId"]) is not None:
                data["userData"]["training_data"] = Database.get_trainees_data(user_data["userId"])
            else:
                data["userData"]["training_data"] = {}
            data["reports"] = Database.get_reports(u_id=user.get("u_id", -1), get_all=True)

        return method(self, data)

    return wrapper
