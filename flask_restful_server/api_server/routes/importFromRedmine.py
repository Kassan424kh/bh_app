from flask_restful import Resource, reqparse, abort

from ..components.checkLogin import login_required
from ..components.importReportsFromRedmine import importReportsFromRedmineApiServerToDB


class ImportFromReports(Resource):
    @login_required
    def get(self, data):
        parser = reqparse.RequestParser()
        parser.add_argument('key', required=True, type=str)
        args = parser.parse_args()

        message = ""
        lenghtOfFoundReport = importReportsFromRedmineApiServerToDB(
            key= args.get("key", ""),
            u_id=data["userData"].get("userId"),
        )

        if (lenghtOfFoundReport == 0): message = "Reports are up to date"
        else: message = "{0} were new set".format(lenghtOfFoundReport)

        return {"message": message}, 201
