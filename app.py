from flask.wrappers import Request
import db
from flask import Flask, abort, render_template, url_for
import logging
logging.basicConfig(level=logging.DEBUG,
                    format=' %(asctime)s - %(levelname)s - %(message)s')

app = Flask(__name__)


def getPrimaryKeys(table):
    keys = []
    values = getFields(table)
    for x in range(0, len(values)):
        if values[x]['Key'] == 'PRI':
            keys.append(values[x]['Field'])
    return keys


def getFields(table):
    values = {}
    res = db.execute('describe ' + table)
    values = res.fetchall()
    return values


def getData(table):
    res = db.execute('select * from ' + table)
    return res.fetchall()


def getDatabyId(table, fields, id):
    keys = getPrimaryKeys(table)
    res = db.execute('select * from ' + table +
                     ' where ' + keys[0] + ' = ' + id)
    return res.fetchall()


def getTable(table, id):
    res = db.execute('select * from ' + table)
    return res.fetchall()


def getTables(values):
    from dotenv import dotenv_values
    db_name = dotenv_values(".env")['DB']
    tables = []
    for x in range(0, len(values)):
        tables.append(values[x]['Tables_in_' + db_name])
    return tables


@ app.route('/')
@ app.route('/tables')
def tablespage():
    values = {}
    res = db.execute('show Tables')
    values = res.fetchall()
    tables = getTables(values)

    return render_template('tables.html', title='Tables', tables=tables)


@ app.route('/tables/<table>')
def tableInfo(table):
    fields = {}
    fields = getFields(table)
    obj = fields[0]
    keys = list(obj.keys())

    return render_template('tableInfo.html', table=table, fields=fields, keys=keys)


@app.route('/tables/<table>/data')
def tableData(table):
    data = {}
    data = getData(table)
    obj = data[0]
    fields = list(obj.keys())
    keys = getPrimaryKeys(table)
    return render_template('table.html', table=table, data=data, fields=fields, keys=keys)


@app.route('/tables/<table>/data/<id>')
def tableDataId(table, id):
    fields = {}
    fields = getFields(table)
    data = {}
    data = getDatabyId(table, fields, id)

    return render_template('item.html', table=table, data=data, fields=fields)
