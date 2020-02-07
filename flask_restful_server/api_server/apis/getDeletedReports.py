from flask_restful import Resource

from ..components.checkLogin import login_required
from ..db.database import Database


class GetDeletedReports(Resource):
    @login_required
    def get(self, data):
        reports = Database.get_reports(
            u_id=data["userData"].get("userId"),
            get_all=True,
            are_deleted=True
        )
        return reports, 201
