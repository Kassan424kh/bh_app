from json import loads
from flask_restful import Resource, reqparse, abort

from ..components.checkLogin import login_required
from ..db.database import Database


class DeleteReports(Resource):
    @login_required
    def get(self, data):
        parser = reqparse.RequestParser()
        parser.add_argument('reportIds', required=True, type=str)
        parser.add_argument('deleteForever', type=bool, default=False)
        args = parser.parse_args()

        list_of_report_ids = loads(args.get("reportIds", []))
        if not all(isinstance(x, (int, int)) for x in list_of_report_ids):
            abort(400, message="you should add a list of reportIds")

        for rId in list_of_report_ids:
            Database.delete_report(
                r_id=rId,
                delete_forever=args.get("deleteForever", False)
            )

        return {"message": "reports are deleted"}, 201
