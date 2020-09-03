import os
from datetime import date
from calendar import monthrange

from jinja2 import Environment, FileSystemLoader

ROOT_DIR = os.path.dirname(os.path.abspath(__file__)) + '/'


def main():
    today = date.today()
    month = monthrange(today.year, today.month)
    dow = month[0] + 1 if month[0] != 6 else 0
    days = []
    week = [{'today': False, 'day': 0} for i in range(dow)]
    for i in range(42):
        week.append({'today': True if i + 1 == today.day else False, 'day': i + 1 if i + 1 <= month[1] else 0})
        dow += 1
        if dow == 7:
            days.append(week)
            week = []
            dow = 0
    data = {'days': days}
    template = Environment(loader=FileSystemLoader(ROOT_DIR)).get_template('index.tpl')
    with open(f'{ROOT_DIR}index.html', 'w') as f:
        f.write(template.render(data))


if __name__ == '__main__':
    main()
