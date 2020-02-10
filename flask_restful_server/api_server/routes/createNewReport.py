from flask_restful import Resource, reqparse

from ..components.checkLogin import login_required
from ..db.database import Database


class CreateNewReport(Resource):
    @login_required
    def get(self, data):
        parser = reqparse.RequestParser()
        parser.add_argument('hours', required=True, type=str)
        parser.add_argument('text', required=True, type=str)
        parser.add_argument('yearOfTraining', type=str, required=True)
        parser.add_argument('date', type=str, default="NULL")
        parser.add_argument('startDate', type=str, default="NULL")
        parser.add_argument('endDate', type=str, default="NULL")

        args = parser.parse_args()
        r_id = Database.set_report(
            u_id=data["userData"].get("userId"),
            hours=args.get("hours"),
            year_of_training=args.get("yearOfTraining"),
            text=args.get("text"),
            date=args.get("date"),
            start_date=args.get("startDate"),
            end_date=args.get("endDate"),
        )
        return Database.get_report(r_id), 201
