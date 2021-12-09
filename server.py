from flask import Flask

app = Flask(__name__)


@app.route('/')
def hello():
    return '<h1>Hello World!</h1>'


@app.route('/user')
def user():
    return '<h1>User Page</h1>'
