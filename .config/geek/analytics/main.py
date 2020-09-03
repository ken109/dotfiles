from googleapiclient.discovery import build
from oauth2client.service_account import ServiceAccountCredentials

import os
import json
from datetime import date, timedelta

from jinja2 import Environment, FileSystemLoader

ROOT_DIR = os.path.dirname(os.path.abspath(__file__)) + '/'
SCOPES = ['https://www.googleapis.com/auth/analytics.readonly']
KEY_FILE_LOCATION = ROOT_DIR + 'ken109-private-188f6bd6599e.json'
VIEW_ID = '219289165'
DATE_RANGE = 10


def initialize_analytics_reporting():
    credentials = ServiceAccountCredentials.from_json_keyfile_name(KEY_FILE_LOCATION, SCOPES)
    return build('analyticsreporting', 'v4', credentials=credentials)


def get_report(analytics):
    return analytics.reports().batchGet(
        body={
            'reportRequests': [{
                'viewId': VIEW_ID,
                'dateRanges': [{'startDate': str(DATE_RANGE - 1) + 'daysAgo', 'endDate': 'today'}],
                'dimensions': [{'name': 'ga:date'}],
                'metrics': [{'expression': 'ga:users'}],
            }]
        }
    ).execute()


def print_response(response):
    reports = []
    for report in response['reports'][0]['data']['rows']:
        day = report['dimensions'][0]
        day = date.fromisoformat(f'{day[0:4]}-{day[4:6]}-{day[6:8]}')
        reports.append({'day': day, 'value': int(report['metrics'][0]['values'][0])})

    day = date.today() - timedelta(days=DATE_RANGE - 1)
    while True:
        if not any(report['day'] == day for report in reports):
            reports.append({'day': day, 'value': 0})
        if day == date.today():
            break
        day = day + timedelta(days=1)

    reports = sorted(reports, key=lambda v: v['day'])
    days = []
    values = []
    for report in reports:
        days.append(report['day'].strftime('%-m/%-d'))
        values.append(report['value'])

    data = {'json': json.dumps({'days': days, 'values': values, 'max': max(values)})}
    template = Environment(loader=FileSystemLoader(ROOT_DIR)).get_template('index.tpl')
    with open(f'{ROOT_DIR}index.html', 'w') as f:
        f.write(template.render(data))


def main():
    analytics = initialize_analytics_reporting()
    response = get_report(analytics)
    print_response(response)


if __name__ == '__main__':
    main()
