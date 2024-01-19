The Project is built using Flask framework, make sure python is installed in your computer
Further, please ensure all the following dependency is installed:
-Flask
-flask-login
-flask-mysql

please ensure database is create and set up using the provided sql file
please go into __ini__.py and change the 4 config that fits your database
app.config['MYSQL_DATABASE_USER']
app.config['MYSQL_HOST']
app.config['MYSQL_PASSWORD']
app.config['MYSQL_DATABASE_DB']
then simply excute main.py will start the flask server on your pc

We provided login for both Admin and Reader
Admin:
Yuze, ywang349
Reader:
Jenny, J12345