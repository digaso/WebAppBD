import db
from flask import Flask, abort, render_template
import logging
logging.basicConfig(level=logging.DEBUG,
                    format=' %(asctime)s - %(levelname)s - %(message)s')

app = Flask(__name__)


def mapList(values):
    from dotenv import dotenv_values
    db_name = dotenv_values(".env")['DB']
    tables = []
    for x in range(0, len(values)):
        tables.append(values[x]['Tables_in_' + db_name])
    return tables


@ app.route('/')
def hello():
    return render_template('index.html', message='Hello There!')


@ app.route('/user')
def userpage():
    return render_template('index.html', message='Hello User!')


@ app.route('/tables')
def tablespage():
    values = {}
    res = db.execute('show Tables')
    values = res.fetchall()
    tables = mapList(values)

    return render_template('tables.html', title='Tables', tables=tables)
