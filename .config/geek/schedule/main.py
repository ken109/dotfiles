from __future__ import print_function

import sys
import os
from datetime import datetime, timedelta, date, timezone
import pickle
import os.path
from googleapiclient.discovery import build
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request

from jinja2 import Environment, FileSystemLoader

SCOPES = ['https://www.googleapis.com/auth/calendar']
ROOT_DIR = os.path.dirname(os.path.abspath(__file__)) + '/'


def get_credential():
    creds = None
    if os.path.exists(ROOT_DIR + 'token.pickle'):
        with open(ROOT_DIR + 'token.pickle', 'rb') as token:
            creds = pickle.load(token)
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(
                ROOT_DIR + 'credentials.json', SCOPES)
            creds = flow.run_local_server(port=0)
        with open(ROOT_DIR + 'token.pickle', 'wb') as token:
            pickle.dump(creds, token)
    return creds


def get_calendars(service):
    calendars_result = service.calendarList().list().execute()
    return calendars_result.get('items', [])


def get_events(service, calendarId):
    start = (date.today() + timedelta(days=0 + int(sys.argv[1]))).isoformat() + 'T00:00:00+09:00'
    end = (date.today() + timedelta(days=1 + int(sys.argv[1]))).isoformat() + 'T00:00:00+09:00'
    return service.events() \
        .list(calendarId=calendarId, timeMin=start,
              singleEvents=True, orderBy='startTime', timeMax=end) \
        .execute() \
        .get('items', [])


def main():
    service = build('calendar', 'v3', credentials=get_credential())
    colors = service.colors().get().execute()['calendar']
    events = []
    for calendar in get_calendars(service):
        if 'selected' in calendar.keys() and calendar['selected']:
            for event in get_events(service, calendar['id']):
                start = datetime.fromisoformat(event['start'].get('dateTime', event['start'].get('date')))
                end = datetime.fromisoformat(event['end'].get('dateTime', event['end'].get('date')))
                if start + timedelta(days=1) == end or end - start > timedelta(days=1):
                    date_format = '終日'
                else:
                    date_format = f"{start.strftime('%H:%M')} - {end.strftime('%H:%M')}"
                events.append({
                    'color': colors[calendar['colorId']]['background'],
                    'date': date_format,
                    'start': start.strftime('%H:%M'),
                    'end': False if end.tzname() is None else end < datetime.now(timezone(timedelta(hours=+9), 'JST')),
                    'summary': event['summary']
                })

    events = sorted(events, key=lambda e: e['start'])
    data = {'events': events, 'date': '今日' if sys.argv[1] == '0' else '明日'}
    template = Environment(loader=FileSystemLoader(ROOT_DIR)).get_template('schedule.tpl')
    with open(f'{ROOT_DIR}schedule{sys.argv[1]}.html', 'w') as f:
        f.write(template.render(data))


if __name__ == '__main__':
    main()
