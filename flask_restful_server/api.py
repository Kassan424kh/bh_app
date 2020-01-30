import json
import ssl

import jwt
from flask import Flask, request, jsonify
from flask_restful import Resource, Api, reqparse, abort
from flask_cors import CORS
from ldap3 import Tls
from flask_ldap3_login import LDAP3LoginManager
from flask_mysqldb import MySQL
import functools
from bson import json_util

# DateFormat should be in YYYY-MM-DD HH:MM:SS

with open('config.json') as json_data_file:
    ldap_login_data = json.load(json_data_file)

tls = Tls(validate=ssl.CERT_REQUIRED, version=ssl.PROTOCOL_TLSv1,
          ca_certs_file='./ca.pem')

config = dict()

# LDAP configurations
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
    tls_ctx=tls,
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


class Database:
    # User Functions
    def get_user(id=-1, email="", password=""):

        if id == -1 and email == "" and password == "":
            print("Your should insert id, email or password to search after user!")
            return
        elif email == "" and password != "":
            print("Your should insert the email to get user data!")
            return

        id_query = ""
        email_query = ""
        password_query = ""

        if id != -1:
            id_query = "`u_id` = '{}'".format(id)
        else:
            id_query = "False"
        if email != "":
            email_query = "`email` = '{}'".format(email)
        else:
            email_query = "True"
        if password != "":
            password_query = "AND `u_password` = '{}'".format(password)
        else:
            password_query = "AND True"

        user = Database.one_request(
            "SELECT * FROM users WHERE {0} OR {1} {2};".format(id_query, email_query, password_query))

        return user

    def create_user(first_and_last_name, email, birthday, password, roll):
        new_created_user_id = Database.insert_into_or_update_or_delete(
            "INSERT INTO `users` (`u_id`, `first_and_last_name`, `email`, `birthday`, `u_password`, `roll`) VALUES (NULL, '{0}', '{1}', '{2}', '{3}', '{4}');".format(
                first_and_last_name, email, birthday, password, roll))
        return new_created_user_id

    def update_user_password(u_id, new_password):
        updated_user_id = Database.insert_into_or_update_or_delete(
            "UPDATE `users` SET `u_password` = '{0}' WHERE `users`.`u_id` = {1};".format(new_password, u_id))
        return updated_user_id

    # Reports Functions
    def get_reports(u_id, start_date="", end_date="", get_all=False):
        list_of_reports = []
        if get_all:
            list_of_reports = Database.list_requests("SELECT * FROM `reports` WHERE `u_id` = {}".format(u_id))
        elif not get_all and start_date != "" or end_date != "":
            if start_date == end_date:
                date = start_date
                list_of_reports = Database.list_requests(
                    """
                        SELECT * FROM `reports` 
                        WHERE 
                            `u_id` = {0} AND 
                            DATE(`date`) = '{1}';
                    """.format(u_id, date))
            else:
                list_of_reports = Database.list_requests(
                    """
                        SELECT * FROM `reports` 
                        WHERE 
                            `u_id` = {0} AND 
                            (DATE(`start_date`) BETWEEN '{1}' AND '{2}' OR
                            DATE(`start_date`) BETWEEN '{1}' AND '{2}');
                    """.format(u_id, start_date, end_date))
        else:
            print("Please select start and end date, to get your reports")
        return list_of_reports

    def get_report(r_id):
        report = None
        if r_id is not None:
            report = Database.one_request("SELECT * FROM `reports` WHERE `r_id` = {}".format(r_id))
        else:
            print("Please set r_id to get report.")
        return report

    def set_report(u_id, hours, text, date="NULL", start_date="NULL", end_date="NULL"):
        if date == "NULL" and start_date == "NULL" and end_date == "NULL":
            abort(400, message="please set date, to create the new report")

        if date == "NULL" and start_date != "NULL" and end_date == "NULL":
            print("please set end_date")
            abort(400, message="please set end_date, to create the new report")
        elif date == "NULL" and start_date == "NULL" and end_date != "NULL":
            print("please set start_date")
            abort(400, message="please set start_date, to create the new report")

        new_report_id = Database.insert_into_or_update_or_delete(
            "INSERT INTO `reports` (`r_id`, `u_id`, `date`, `start_date`, `end_date`, `hours`, `text`, `deleted`) VALUES (NULL, '{0}', '{1}', '{2}', '{3}', '{4}', '{5}', '0');".format(
                u_id, date, start_date, end_date, hours, text))
        return new_report_id

    def update_report(r_id, new_data_as_dict={}):
        if len(new_data_as_dict.keys()) == 0:
            print("Cann't update report, while you haven't set any data")
            return
        for key, value in new_data_as_dict.items():
            if value != "":
                Database.insert_into_or_update_or_delete(
                    "UPDATE `reports` SET `{1}` = '{2}' WHERE `reports`.`r_id` = {0};".format(r_id, key, value))
        return r_id

    def delete_report(r_id, delete_forever=False):
        message = ""

        is_report_deleted_forever = Database.get_report(r_id) is not None
        if is_report_deleted_forever:
            if not delete_forever:
                Database.insert_into_or_update_or_delete(
                    "UPDATE `reports` SET `deleted` = TRUE WHERE `reports`.`r_id` = {0};".format(r_id))
                message = "Report is deleted"
            else:
                Database.insert_into_or_update_or_delete(
                    query="DELETE FROM `reports` WHERE `r_id` = {0};".format(r_id),
                    type="deleting"
                )
                message = "Report is deleted forever"
        else:
            abort(404, message="Report is undefined")
        return {"message": message}

    # Default DB Functions
    def one_request(query):
        cur = mysql.connection.cursor()
        cur.execute(query)
        request = cur.fetchone()
        cur.close()
        return request

    def list_requests(query):
        cur = mysql.connection.cursor()
        cur.execute(query)
        requests = cur.fetchall()
        cur.close()
        return requests

    def insert_into_or_update_or_delete(query, type=""):
        cur = mysql.connection.cursor()
        cur.execute(query)
        new_inserted_data_id = mysql.connection.insert_id()
        mysql.connection.commit()
        if type == "deleting":
            new_inserted_data_id = -1
        cur.close()
        return new_inserted_data_id


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
            # else ldap find user
            if bool(str(ldap_manager.authenticate(email, password).status) == "AuthenticationResponseStatus.success"):
                user_data_from_ldap = json.loads(
                    json.dumps(dict(ldap_manager.authenticate(email, password).user_info), default=json_util.default))

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
                        user = Database.get_user(email= email, password=_encryptedPassword)
                        if user is not None:
                            is_user_logged_in = True
                else:
                    Database.create_user(
                        first_and_last_name=user_data_from_ldap.get("displayName"),
                        email=email,
                        birthday="",
                        password=_encryptedPassword,
                        roll=0
                    )
                    user = Database.get_user(email= email, password=_encryptedPassword)
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
            data["reports"] = Database.get_reports(u_id=user.get("u_id", -1), get_all=True)

        return method(self, data)

    return wrapper


class GetReport(Resource):
    @login_required
    def get(self, data):
        parser = reqparse.RequestParser()
        parser.add_argument('reportId', required=True, type=int)

        args = parser.parse_args()
        return Database.get_report(args.get("reportId")), 201


class DeleteReport(Resource):
    @login_required
    def get(self, data):
        parser = reqparse.RequestParser()
        parser.add_argument('reportId', required=True, type=int)
        parser.add_argument('deleteForever', type=bool, default=False)

        args = parser.parse_args()
        return Database.delete_report(
            r_id=args.get("reportId"),
            delete_forever=args.get("deleteForever", False)
        ), 201


class CreateNewReport(Resource):
    @login_required
    def get(self, data):
        parser = reqparse.RequestParser()
        parser.add_argument('hours', required=True, type=str)
        parser.add_argument('text', required=True, type=str)
        parser.add_argument('date', type=str, default="NULL")
        parser.add_argument('startDate', type=str, default="NULL")
        parser.add_argument('endDate', type=str, default="NULL")

        args = parser.parse_args()
        r_id = Database.set_report(
            u_id=data["userData"].get("userId"),
            hours=args.get("hours"),
            text=args.get("text"),
            date=args.get("date"),
            start_date=args.get("startDate"),
            end_date=args.get("endDate"),
        )
        return Database.get_report(r_id), 201


class UpdateReport(Resource):
    @login_required
    def get(self, data):
        parser = reqparse.RequestParser()
        parser.add_argument('reportId', required=True, type=int)
        parser.add_argument('hours', type=str, default="")
        parser.add_argument('text', type=str, default="")
        parser.add_argument('date', type=str, default="")
        parser.add_argument('startDate', type=str, default="")
        parser.add_argument('endDate', type=str, default="")

        args = parser.parse_args()
        r_id = Database.update_report(
            r_id=args.get("reportId"),
            new_data_as_dict={
                "hours": args.get("hours"),
                "text": args.get("text"),
                "date": args.get("date"),
                "start_date": args.get("startDate"),
                "end_date": args.get("endDate"),
            })
        return Database.get_report(r_id), 201


class UserData(Resource):
    parser = reqparse.RequestParser()

    @login_required
    def get(self, data):
        return data


api.add_resource(UserData, "/")
api.add_resource(GetReport, "/get-reports")
api.add_resource(CreateNewReport, "/create-new-report")
api.add_resource(UpdateReport, "/update-report")
api.add_resource(DeleteReport, "/delete-report")

if __name__ == '__main__':
    app.run(port=5000, host="0.0.0.0")
