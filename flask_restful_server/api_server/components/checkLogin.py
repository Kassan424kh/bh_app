import functools

import jwt
from flask import request
from flask_restful import abort

from ..db.database import Database
from ..db.ldapServerConnection import authUser


# LOGIN TESTER
def login_required(method):
    @functools.wraps(method)
    def wrapper(self):
        email = request.headers.get('email', '')
        password = request.headers.get('password', '')

        _password = {"email": email, "password": password}
        _encryptedPassword = jwt.encode(_password, "password", "HS256").decode('UTF-8')

        user = {}
        is_user_logged_in = False
        try:
            ldap_login_check = authUser(email, password).get("loggedIn")

            if ldap_login_check:
                user_data_from_ldap = authUser(email, password)

                find_user_after_his_email = Database.get_user(email=email)
                user = Database.get_user(email=email, password=_encryptedPassword)
                if find_user_after_his_email is not None:
                    if user is not None:
                        is_user_logged_in = True
                    else:
                        Database.update_user_password(
                            u_id=find_user_after_his_email.get("u_id"),
                            new_password=_encryptedPassword
                        )
                        user = Database.get_user(email=email, password=_encryptedPassword)
                        if user is not None:
                            is_user_logged_in = True
                else:
                    Database.create_user(
                        first_and_last_name=user_data_from_ldap.get("name"),
                        email=email,
                        birthday="",
                        password=_encryptedPassword,
                        roll=0
                    )
                    user = Database.get_user(email=email, password=_encryptedPassword)
                    if user is not None:
                        is_user_logged_in = True

            # else ldap cann't find user
            else:
                user = Database.get_user(email=email, password=_encryptedPassword)
                if user is not None:
                    is_user_logged_in = True
        except ():
            user = Database.get_user(email=email, password=_encryptedPassword)
            if user is not None:
                is_user_logged_in = True

        login_status = {"isLoggedIn": is_user_logged_in}

        if not login_status["isLoggedIn"]:
            abort(400, message='Login faild.')

        user_data = {}
        if login_status["isLoggedIn"]:
            user_data["userId"] = user.get("u_id", -1)
            user_data["firstAndLastName"] = user.get("first_and_last_name", "No Name")
            user_data["email"] = user.get("email", "No email")
            user_data["birthday"] = user.get("birthday", "No Birthday")
            user_data["isAdmin"] = user.get("roll", -1) != -1 and user.get("roll", -1) == 2
            user_data["isPM"] = user.get("roll", -1) != -1 and user.get("roll", -1) == 1

        data = {"loginStatus": login_status}
        if login_status.get("isLoggedIn", False):
            data["userData"] = user_data
            if not user.get("is_new_user") and Database.get_trainees_data(user_data["userId"]) is not None:
                data["userData"]["training_data"] = Database.get_trainees_data(user_data["userId"])
            else:
                data["userData"]["training_data"] = {}
            data["reports"] = Database.get_reports(u_id=user.get("u_id", -1), get_all=True)

        return method(self, data)

    return wrapper
