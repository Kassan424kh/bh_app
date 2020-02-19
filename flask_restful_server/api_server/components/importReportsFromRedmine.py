import requests
import datetime
from flask_restful import abort
from ..db.database import Database

def importReportsFromRedmineApiServerToDB(key, u_id) -> int:
    if key == "":
        abort(400, message="Please set api-key")
    user_data = requests.get(url='https://projects.satzmedia.de/users/current.json?key={0}'.format(key))
    list_of_found_reports = []
    list_of_not_duplicated_reports = []
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
                seen = []
                def checkListContaination(o) -> bool:
                    return seen.__contains__(o) or list_of_not_duplicated_reports.__contains__(o)
                for first_report in list_of_found_reports:
                    if not checkListContaination(first_report):
                        textOfDuplicatedReportsInTheSameDay = first_report["comments"]
                        hoursOfDuplicatedReportsInTheSameDay = float(first_report["hours"])
                        for second_report in list_of_found_reports:
                            if not checkListContaination(second_report) and second_report != first_report:
                                if first_report.get("spent_on") == second_report.get("spent_on"):
                                    if (second_report["comments"] not in textOfDuplicatedReportsInTheSameDay):
                                        textOfDuplicatedReportsInTheSameDay += "\n" + second_report["comments"]
                                    hoursOfDuplicatedReportsInTheSameDay += float(second_report["hours"])
                                    seen.append(second_report)
                        first_report["comments"] = textOfDuplicatedReportsInTheSameDay
                        first_report["hours"] = str(hoursOfDuplicatedReportsInTheSameDay)
                        seen.append(first_report)
                        list_of_not_duplicated_reports.append(first_report)
                if len(list_of_not_duplicated_reports) == 0:
                    abort(400, message="Don't found any Reports")
                indexOfSetReports = 0
                for report in list_of_not_duplicated_reports:
                    foundDuplicationBetweenThisAndInDBReport = len(
                        Database.get_reports(
                            u_id=u_id,
                            start_date=report.get("spent_on"),
                            end_date=report.get("spent_on")
                        )
                    ) == 0
                    if foundDuplicationBetweenThisAndInDBReport:
                        Database.set_report(
                            u_id= u_id,
                            hours=report.get("hours"),
                            date=report.get("spent_on"),
                            text=report.get("comments").replace("'", "\""),
                            year_of_training= "0"
                        )
                        indexOfSetReports += 1
                    else:
                        pass
        else:
            abort(400, message="Can not found any user after this key")
    else:
        abort(400, message="Api-key is false")
    return indexOfSetReports
