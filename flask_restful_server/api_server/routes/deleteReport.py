from flask_restful import Resource, reqparse

from ..components.checkLogin import login_required
from ..db.database import Database


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
