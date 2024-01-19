from flask import Blueprint, render_template, request, redirect, url_for
from flask_login import login_user, login_required, logout_user, current_user
from flaskext.mysql import MySQL
from .model import Users
from . import db
from . import users
auth = Blueprint('auth', __name__)

@auth.route('/', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        Name = request.form.get('username')
        Password = request.form.get('password')
        cursor = db.connect().cursor()
        cursor.execute(f'SELECT * FROM Operator WHERE Name = "{Name}" AND Password = "{Password}"')
        fetchdata = cursor.fetchone()
        if fetchdata != None:
            user = Users(fetchdata[0], fetchdata[1], fetchdata[2], True)
            users.append(user)
            login_user(user, remember=True)
            return redirect(url_for('views.dashboard'))
        else:
            cursor.execute(f'SELECT * FROM Reader WHERE ReaderName = "{Name}" AND ReaderPassword = "{Password}"')
            fetchdata = cursor.fetchone()
            if fetchdata != None:
                user = Users(fetchdata[0], fetchdata[1], fetchdata[2], False)
                users.append(user)
                login_user(user, remember=True)
                return redirect(url_for('views.userdash'))
        cursor.close()
    return render_template('main.html', user=current_user)
