from json import loads
from flask_restful import Resource, reqparse, abort

from ..components.checkLogin import login_required
from ..db.database import Database


class DeleteReports(Resource):
    @login_required
    def get(self, data):
        parser = reqparse.RequestParser()
        parser.add_argument('reportIds', required=True, type=str)
        parser.add_argument('permanently', type=bool, default=False)
        args = parser.parse_args()

        list_of_report_ids = loads(args.get("reportIds", []))

        if not all(isinstance(x, (int, int)) for x in list_of_report_ids):
            abort(400, message="You should add a list of reportIds")
        elif len(list_of_report_ids) == 0:
            abort(400, message="There is no selected reports")

        for rId in list_of_report_ids:
            if Database.get_report(r_id=rId) is None:
                abort(400, message="Selected report is undefined!!!\nplease update your list and then try again.")

        for rId in list_of_report_ids:
            Database.delete_report(
                r_id=rId,
                permanently=args.get("permanently", False)
            )

        return {"message": "Report{0} {1} deleted".format(("" if (len(list_of_report_ids) == 0) else "s"),
                                                          ("is" if (len(list_of_report_ids) == 1) else "are"))}, 201
