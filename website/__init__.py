from flask import Flask
from os import path
from flask_login import LoginManager
from flaskext.mysql import MySQL

users = []
db = MySQL()

def create_app():
    app = Flask(__name__)
    app.config['SECRET_KEY'] = 'asjkdlIL123HNMSQO'
    app.config['MYSQL_DATABASE_USER'] = 'root'
    app.config['MYSQL_HOST'] = 'localhost'
    app.config['MYSQL_PASSWORD'] = ''
    app.config['MYSQL_DATABASE_DB'] = 'milestone3'
    db.init_app(app)
    login_manager = LoginManager()
    login_manager.login_view = 'auth.login'
    login_manager.init_app(app)

    from .views import views
    from .auth import auth

    app.register_blueprint(views, url_prefix='/')
    app.register_blueprint(auth, url_prefix='/')

    from .model import Users

    @login_manager.user_loader
    def load_user(id):
        for user in users:
            if id == user.get_id():
                user.to_string()
                return user
        return None
    return app
