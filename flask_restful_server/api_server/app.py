# DateFormat should be in YYYY-MM-DD HH:MM:SS
from flask import Flask
from flask_cors import CORS
from flask_restful import Api

app = Flask(__name__)
api = Api(app)
CORS(app)

from api_server.apis.addDataToNewUser import AddDataToNewUser
from api_server.apis.createNewReport import CreateNewReport
from api_server.apis.deleteReport import DeleteReport
from api_server.apis.getDeletedReports import GetDeletedReports
from api_server.apis.getReports import GetReports
from api_server.apis.searchReports import SearchReports
from api_server.apis.updateReport import UpdateReport
from api_server.apis.userData import UserData

api.add_resource(UserData, "/")
api.add_resource(AddDataToNewUser, "/add-data-to-new-user")
api.add_resource(GetReports, "/get-reports")
api.add_resource(GetDeletedReports, "/get-deleted-reports")
api.add_resource(SearchReports, "/search")
api.add_resource(CreateNewReport, "/create-new-report")
api.add_resource(UpdateReport, "/update-report")
api.add_resource(DeleteReport, "/delete-report")

if __name__ == '__main__':
    app.run(port=5000, host="0.0.0.0")
