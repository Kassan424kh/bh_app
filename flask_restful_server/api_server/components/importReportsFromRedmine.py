import requests
from flask_restful import abort

# from ..db.database import Database

# example of the object coming from Redmine api
'''
"time_entries": [
    ...,
    {
      "id": 242310,
      "project": {
        "id": 2,
        "name": "5_Satzmedia"
      },
      "issue": {
        "id": 40504
      },
      "user": {
        "id": 333,
        "name": "Test Test"
      },
      "activity": {
        "id": 25,
        "name": "Einarbeitung"
      },
      "hours": 7.0,
      "comments": "fixed ldap server connection, use now ldap3 to authentication users, fixed rendering loop on the frontend and fixed changing animation between nullImages and showingReports",
      "spent_on": "2020-02-17",
      "created_on": "2020-02-17T17:41:32Z",
      "updated_on": "2020-02-17T17:41:32Z"
    },
    ...,
]
'''


def importReportsFromRedmineApiServerToDB() -> dict:
    key = "b869c19ea7f3d761eb7b8ce5f0bf0ddec59ced5a"
    user_data = requests.get(url='https://projects.satzmedia.de/users/current.json?key={0}'.format(key))
    list_of_found_reports = []
    if user_data.status_code == 200:
        user_id = user_data.json().get("user", {}).get("id", -1)
        if user_id != -1:
            count_of_found_reports = requests.get(
                url="https://projects.satzmedia.de/time_entries.json?key={0}&limit=20&offset=40&user_id={1}".format(
                    key,
                    user_id
                )
            ).json().get("total_count", 0)
            if count_of_found_reports > 0:
                count_of_found_reports = int(count_of_found_reports / 100) + 1
                for i in range(count_of_found_reports):
                    offset = (count_of_found_reports * 100) - ((count_of_found_reports - i) * 100)
                    list_of_found_reports.extend(requests.get(
                        url="https://projects.satzmedia.de/time_entries.json?key={0}&limit=100&offset={1}&user_id={2}".format(
                            key,
                            offset,
                            user_id
                        )
                    ).json().get("time_entries", []))

                # set duplicated reports together
                checked_reports = []
                seen = []

                def checkListContaination(o) -> bool:
                    return seen.__contains__(first_report) or checked_reports.__contains__(first_report)

                for first_report in list_of_found_reports:
                    if not checkListContaination(first_report):
                        textOfDuplicatedReportsInTheSameDay = first_report["comments"]
                        for second_report in list_of_found_reports:
                            if not checkListContaination(second_report) and second_report != first_report:
                                if first_report.get("spent_on") == second_report.get("spent_on"):
                                    textOfDuplicatedReportsInTheSameDay += "\n" + second_report["comments"]
                                    seen.append(second_report)

                        first_report["comments"] = textOfDuplicatedReportsInTheSameDay

                        seen.append(first_report)
                        checked_reports.append(first_report)

    return checked_reports


importReportsFromRedmineApiServerToDB()
