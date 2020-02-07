from flask_restful import Resource, reqparse

from ..components.checkLogin import login_required
from ..db.database import Database


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
        parser.add_argument('yearOfTraining', type=str, default="")

        args = parser.parse_args()
        r_id = Database.update_report(
            r_id=args.get("reportId"),
            new_data_as_dict={
                "hours": args.get("hours"),
                "text": args.get("text"),
                "date": args.get("date"),
                "start_date": args.get("startDate"),
                "end_date": args.get("endDate"),
                "year_of_training": args.get("yearOfTraining"),
            })
        return Database.get_report(r_id), 201
