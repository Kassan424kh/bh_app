# DateFormat should be in YYYY-MM-DD HH:MM:SS
from flask import Flask
from flask_cors import CORS
from flask_restful import Api

app = Flask(__name__)
api = Api(app)
CORS(app)

from api_server.routes.addDataToNewUser import AddDataToNewUser
from api_server.routes.createNewReport import CreateNewReport
from api_server.routes.deleteReport import DeleteReport
from api_server.routes.deleteReports import DeleteReports
from api_server.routes.revertReports import RevertReports
from api_server.routes.getDeletedReports import GetDeletedReports
from api_server.routes.getReports import GetReports
from api_server.routes.searchReports import SearchReports
from api_server.routes.updateReport import UpdateReport
from api_server.routes.userData import UserData
from api_server.routes.importFromRedmine import ImportFromReports

api.add_resource(UserData, "/")
api.add_resource(AddDataToNewUser, "/add-data-to-new-user")
api.add_resource(GetReports, "/get-reports")
api.add_resource(GetDeletedReports, "/get-deleted-reports")
api.add_resource(SearchReports, "/search")
api.add_resource(CreateNewReport, "/create-new-report")
api.add_resource(UpdateReport, "/update-report")
api.add_resource(DeleteReport, "/delete-report")
api.add_resource(DeleteReports, "/delete-reports")
api.add_resource(RevertReports, "/revert-reports")
api.add_resource(ImportFromReports, "/import-from-redmine")

if __name__ == '__main__':
    app.run(port=6666, host="0.0.0.0")
