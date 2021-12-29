from flask.wrappers import Request
import db
from flask import Flask, abort, render_template, url_for, request
import logging
from dotenv import dotenv_values
logging.basicConfig(level=logging.DEBUG,
                    format=' %(asctime)s - %(levelname)s - %(message)s')

app = Flask(__name__)
CONFIG = dotenv_values(".env")


def getReferencedTable(data):
    referencedTables = {}
    for item in data:
        print("ASSSSSSSSSSS", item)
        referencedTables[item['COLUMN_NAME']] = (item['REFERENCED_TABLE_NAME'])
    print(referencedTables, data)
    return referencedTables


def getForeignKeysData(table, foreign_keys):
    if len(foreign_keys) > 0:
        str = "' ,'".join(foreign_keys)
        sql = "SELECT  COLUMN_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME FROM  INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE REFERENCED_TABLE_SCHEMA = '" + CONFIG['DB']+"' AND TABLE_NAME = '" + \
            table + "' AND COLUMN_NAME IN ( '" + str + "')"
        print(sql)
        res = db.execute(sql)
        foreign_keys_data = res.fetchall()
        print('foreign keys', str)
        return getReferencedTable(foreign_keys_data)
    return 0


def getForeignKeys(table):
    keys = []
    values = getFields(table)
    for x in range(0, len(values)):
        if values[x]['Key'] == 'MUL' or values[x]['Key'] == 'UNI':
            keys.append(values[x]['Field'])
    return keys


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
    foreign_keys = getForeignKeys(table)
    foreign_keys_data = getForeignKeysData(table, foreign_keys)
    primary_keys = getPrimaryKeys(table)
    data = getData(table)
    obj = data[0]
    fields = list(obj.keys())
    return render_template('table.html', table=table, data=data, fields=fields, primary_keys=primary_keys, foreign_keys=foreign_keys, foreign_keys_data=foreign_keys_data)


@app.route('/tables/<table>/data/<id>')
def tableDataId(table, id):
    fields = {}
    fields = getFields(table)
    data = {}
    data = getDatabyId(table, fields, id)

    return render_template('item.html', table=table, data=data, fields=fields)


@app.route('/tables/<table>/data/search', methods=['POST'])
def handleSearch(table):
    foreign_keys = getForeignKeys(table)
    foreign_keys_data = getForeignKeysData(table, foreign_keys)
    fields = getFields(table)
    fieldSearch = request.form['fieldSearch']
    valueSearch = request.form['valueSearch']
    keys = getPrimaryKeys(table)
    fieldType = list(
        filter(lambda field: field['Field'] == fieldSearch, fields))[0]['Type']
    if fieldType == 'int':
        res = db.execute('select * from ' + table +
                         ' where ' + fieldSearch + ' = ' + valueSearch)
    else:
        res = db.execute('select * from ' + table +
                         ' where ' + fieldSearch + ' = %s;', valueSearch)
    data = res.fetchall()
    if(len(data) > 0):
        fields = list(data[0].keys())
    return render_template('searchPage.html', table=table, data=data, fields=fields, foreign_keys=foreign_keys, foreign_keys_data=foreign_keys_data)
