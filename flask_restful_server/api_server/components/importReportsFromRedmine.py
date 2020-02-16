import requests


def importReportsFromRedmineApiServerToDB():
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
                print(len(list_of_found_reports))

    return list_of_found_reports


importReportsFromRedmineApiServerToDB()
