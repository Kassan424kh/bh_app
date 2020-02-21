from flask import session
from flask_restful import Resource, reqparse

from ..components.checkLogin import login_required

class UserData(Resource):
    parser = reqparse.RequestParser()
    @login_required
    def get(self, data):
        session["test"] = "asdfasdf"
        print(session["test"])
        return data, 201, {'Access-Control-Allow-Origin': '*'}
