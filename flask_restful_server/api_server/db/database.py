from flask_mysqldb import MySQL
from flask_restful import abort

from api_server.app import app

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
    def get_user(id=-1, email="", password="") -> dict:

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

    def create_user(first_and_last_name, email, birthday, password, roll) -> int:
        new_created_user_id = Database.insert_into_or_update_or_delete(
            "INSERT INTO `users` (`u_id`, `first_and_last_name`, `email`, `birthday`, `u_password`, `roll`) VALUES (NULL, '{0}', '{1}', '{2}', '{3}', '{4}');".format(
                first_and_last_name, email, birthday, password, roll))
        return new_created_user_id

    def update_user_password(u_id, new_password) -> int:
        updated_user_id = Database.insert_into_or_update_or_delete(
            "UPDATE `users` SET `u_password` = '{0}' WHERE `users`.`u_id` = {1};".format(new_password, u_id))
        return updated_user_id

    def add_data_to_new_user(u_id, birthday, typeTraining, startTrainingDate, endTrainingDate, roll=0,
                             is_trainees=False) -> int:

        user = Database.get_user(u_id)

        if is_trainees:
            Database.set_user_as_trainees(
                u_id=user.get("u_id"),
                typeTraining=typeTraining,
                startTrainingDate=startTrainingDate,
                endTrainingDate=endTrainingDate
            )

        Database.insert_into_or_update_or_delete(
            query="UPDATE `users` SET `birthday` = '{1}', `is_new_user` = '{2}', `roll` = '{3}' WHERE `users`.`u_id` = {0};".format(
                user.get("u_id"),
                birthday,
                False,
                roll
            )
        )

        return u_id

    # Trainees Functions
    def get_trainees_data(u_id) -> dict:
        trainees_data = Database.one_request(
            "SELECT * FROM trainees WHERE u_id = {0};".format(u_id))

        return trainees_data

    def set_user_as_trainees(u_id, typeTraining, startTrainingDate, endTrainingDate) -> dict:
        user = Database.get_user(u_id)
        if typeTraining == "" or startTrainingDate == "" or endTrainingDate == "":
            abort(400, message="Training data not complete")
        if Database.get_trainees_data(user.get("u_id")) is None and user.get("is_new_user"):
            Database.insert_into_or_update_or_delete(
                query="INSERT INTO `trainees` (`t_id`, `u_id`, `type_training`, `start_date`, `end_date`) VALUES (NULL, '{0}', '{1}', '{2}', '{3}');".format(
                    user.get("u_id"), typeTraining, startTrainingDate, endTrainingDate
                )
            )

        return Database.get_trainees_data(u_id=user.get("u_id"))

    def update_user_training_data(u_id, typeTraining="", startTrainingDate="", endTrainingDate="") -> dict:
        user = Database.get_user(u_id)

        new_training_data = {
            "type_training": typeTraining,
            "start_date": startTrainingDate,
            "end_date": endTrainingDate
        }

        if typeTraining == "" or startTrainingDate == "" or endTrainingDate == "":
            abort(400, message="Training data not complete")
        if Database.get_trainees_data(user.get("u_id")) is not None:
            for key, value in new_training_data.items():
                if value != "":
                    Database.insert_into_or_update_or_delete(
                        query="UPDATE `trainees` SET `{1}` = '{2}' WHERE `trainees`.`u_id` = {0};".format(
                            user.get("u_id"),
                            key,
                            value,
                        )
                    )

        return Database.get_trainees_data(u_id=user.get("u_id"))

    # Reports Functions
    def get_reports(u_id, start_date="", end_date="", get_all=False, are_deleted=False) -> list:
        list_of_reports = []
        if get_all:
            list_of_reports = Database.list_requests(
                "SELECT * FROM `reports` WHERE `u_id` = {0} AND deleted = {1};".format(u_id, are_deleted))
        elif not get_all and start_date != "" or end_date != "":
            if start_date == end_date:
                date = start_date
                list_of_reports = Database.list_requests(
                    """
                        SELECT * FROM `reports` 
                        WHERE 
                            `u_id` = {0} AND 
                            DATE(`date`) = '{1}'
                             AND deleted = {2};
                    """.format(u_id, date, are_deleted))
            else:
                list_of_reports = Database.list_requests(
                    """
                        SELECT * FROM `reports` 
                        WHERE 
                            `u_id` = {0} AND 
                            (DATE(`start_date`) BETWEEN '{1}' AND '{2}' OR
                            DATE(`start_date`) BETWEEN '{1}' AND '{2}')
                             AND deleted = {3};
                    """.format(u_id, start_date, end_date, are_deleted))
        else:
            print("Please select start and end date, to get your reports")
        return list_of_reports

    def search_reports(u_id, searched_texts="") -> list:
        list_of_reports = []
        if u_id is not None:
            list_of_reports = Database.list_requests(
                "SELECT * FROM reports WHERE MATCH(text) AGAINST ('{1}' IN NATURAL LANGUAGE MODE) AND `u_id` = {0}".format(
                    u_id, searched_texts))
        return list_of_reports

    def get_report(r_id) -> dict:
        report = None
        if r_id is not None:
            report = Database.one_request("SELECT * FROM `reports` WHERE `r_id` = {}".format(r_id))
        else:
            print("Please set r_id to get report.")
        return report

    def set_report(u_id, hours, text, year_of_training, date="NULL", start_date="NULL", end_date="NULL") -> id:
        if date == "NULL" and start_date == "NULL" and end_date == "NULL":
            abort(400, message="please set date, to create the new report")

        if date == "NULL" and start_date != "NULL" and end_date == "NULL":
            print("please set end_date")
            abort(400, message="please set end_date, to create the new report")
        elif date == "NULL" and start_date == "NULL" and end_date != "NULL":
            print("please set start_date")
            abort(400, message="please set start_date, to create the new report")

        new_report_id = Database.insert_into_or_update_or_delete(
            "INSERT INTO `reports` (`r_id`, `u_id`, `date`, `start_date`, `end_date`, `hours`, `text`, `deleted`, `year_of_training`) VALUES (NULL, '{0}', '{1}', '{2}', '{3}', '{4}', '{5}', '0', {6});".format(
                u_id, date, start_date, end_date, str(float(hours)), text, year_of_training))
        return new_report_id

    def update_report(r_id, new_data_as_dict={}) -> int:
        if len(new_data_as_dict.keys()) == 0:
            print("Cann't update report, while you haven't set any data")
            return
        for key, value in new_data_as_dict.items():
            if value != "":
                Database.insert_into_or_update_or_delete(
                    "UPDATE `reports` SET `{1}` = '{2}' WHERE `reports`.`r_id` = {0};".format(r_id, key, value))
        return r_id

    def delete_report(r_id, delete_forever=False) -> dict:
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
    def one_request(query) -> dict:
        cur = mysql.connection.cursor()
        cur.execute(query)
        request = cur.fetchone()
        cur.close()
        return request

    def list_requests(query) -> list:
        cur = mysql.connection.cursor()
        cur.execute(query)
        requests = cur.fetchall()
        cur.close()
        return requests

    def insert_into_or_update_or_delete(query, type="") -> int:
        cur = mysql.connection.cursor()
        cur.execute(query)
        new_inserted_data_id = mysql.connection.insert_id()
        mysql.connection.commit()
        if type == "deleting":
            new_inserted_data_id = -1
        cur.close()
        return new_inserted_data_id
