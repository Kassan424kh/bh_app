from flask_restful import Resource

from ..components.checkLogin import login_required
from ..db.database import Database


class GetReports(Resource):
    @login_required
    def get(self, data):
        reports = Database.get_reports(
            u_id=data["userData"].get("userId"),
            get_all=True
        )
        print("I was here")
        return reports, 201
