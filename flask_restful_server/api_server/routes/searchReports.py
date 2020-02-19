from flask_restful import Resource, reqparse

from ..components.checkLogin import login_required
from ..db.database import Database


class SearchReports(Resource):
    @login_required
    def get(self, data):
        parser = reqparse.RequestParser()
        parser.add_argument('searchedText', required=True, type=str)

        args = parser.parse_args()

        print("user_id:", data["userData"].get("userId"), "Searched after:", args.get("searchedText"))

        list_of_found_reports = Database.search_reports(
            u_id=data["userData"].get("userId"),
            searched_texts=args.get("searchedText"),
        )

        return list_of_found_reports, 201
