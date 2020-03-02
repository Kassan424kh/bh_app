from flask_restful import Resource, reqparse

from ..components.checkLogin import login_required
from ..db.database import Database


class AddDataToNewUser(Resource):
    parser = reqparse.RequestParser()

    @login_required
    def get(self, data):
        parser = reqparse.RequestParser()
        parser.add_argument('birthday', required=True, type=str)
        parser.add_argument('is_trainees', required=True, type=bool)
        parser.add_argument('typeTraining', type=str, default="")
        parser.add_argument('startTrainingDate', type=str, default="")
        parser.add_argument('endTrainingDate', type=str, default="")

        args = parser.parse_args()
        Database.add_data_to_new_user(
            u_id=data.get("userData").get("userId"),
            birthday=args.get("birthday"),
            is_trainees=args.get("is_trainees"),
            typeTraining=args.get("typeTraining"),
            startTrainingDate=args.get("startTrainingDate"),
            endTrainingDate=args.get("endTrainingDate"),
        )

        return Database.get_trainees_data(data.get("userData").get("userId")) is not None
