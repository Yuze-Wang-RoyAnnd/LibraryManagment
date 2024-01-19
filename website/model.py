from flask_login import UserMixin
from . import db


class Users(UserMixin):
    def __init__(self, id:str, name:str, password:str, access):
        self.name = name
        self.password = password
        self.id = id
        self.access = access

    def is_authenticated(self):
        return True
    
    def is_active(self):
        return True
    
    def is_anonymous(self):
        return False

    def get_id(self):
        return self.id
    
    def is_admin(self):
        return self.access

    def to_string(self):
        print(self.name)
        print(self.access)
