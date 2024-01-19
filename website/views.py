from flask import Blueprint, render_template, request, redirect, url_for
from flask_login import login_required, current_user, logout_user
from datetime import datetime
from . import db
from . import users

views = Blueprint('views', __name__)

@views.route('/dashboard')
@login_required
def dashboard():
    connection = db.connect()
    cursor = connection.cursor()

    cursor.execute(f"SELECT * FROM BorrowedBookInfo")
    fetch = cursor.fetchmany(10)
    cursor.close()
    return render_template('dashboard.html', user=current_user, fetch=fetch)


@views.route('/addbooks', methods=['GET', 'POST'])
@login_required
def addbooks():
    msg = ''
    connection = db.connect()
    cursor = connection.cursor()
    if request.method == 'POST':
        bookbarcode = request.form.get('bookbarcode')
        press = request.form.get('press')
        Edition = request.form.get('edition')
        genre = request.form.get('genre')
        publicationdate = request.form.get('publicationdate')
        language = request.form.get('language')
        author = request.form.get('author')
        description = request.form.get('discription')
        #print(bookbarcode, press, Edition, genre, publicationdate, language, author, description)
        try:
            cursor.execute(f"INSERT INTO BooksInfo (BookBarcode, GenreName, Author, Description, Press, DatePublication, Language, Edition) VALUES\
                           ('{bookbarcode}', '{genre}', '{author}', '{description}', '{press}', '{publicationdate}', '{language}', '{Edition}')")
            connection.commit()
            cursor.execute(f'INSERT INTO Author (Author, BBookID) \
                           VALUES ("{author}", LAST_INSERT_ID())')
            connection.commit()
        except Exception as e:
            msg = 'Error has occured'
    cursor.execute("SELECT * FROM BooksInfo INNER JOIN BookStatistics ON BooksInfo.BookID = BookStatistics.BBookID")
    fetch = cursor.fetchall()
    cursor.close()
    return render_template('addbooks.html', user=current_user, msg=msg, fetch=fetch)


@views.route('/addusers', methods=['GET', 'POST'])
@login_required
def addusers():
    msg = ''
    connection = db.connect()
    cursor = connection.cursor()
    if request.method == 'POST':
        readerName = request.form.get('readername')
        readerPassword = request.form.get('readerpassword')
        readerGender = request.form.get('gender')

        try:
            cursor.execute(f"INSERT INTO READER (ReaderName, ReaderPassword, Gender, RegistrationDate)\
                            VALUES ('{readerName}', '{readerPassword}', '{readerGender}', '{datetime.now()}')")
            connection.commit()
            msg = 'sucessfully inserted'
        except Exception as e:
            msg = 'an erro has occured when inserting, please try again'
    cursor.execute("SELECT * FROM Reader")
    fetch = cursor.fetchall()
    cursor.close()
    return render_template('addusers.html', user=current_user, msg=msg, fetch=fetch)

@views.route('/userdash', methods=['GET', 'POST'])
@login_required
def userdash():
    msg = ''
    connection = db.connect()
    cursor = connection.cursor()
    if request.method == 'POST':
        readerid = current_user.get_id()
        bookbarcode = request.form.get('bookbarcode')
        expirytime = request.form.get('expiredate')
        operatorid = request.form.get('operatorid')
        renew = request.form.get('renew')
        try:
            cursor.execute(f'SELECT BookID FROM BooksInfo WHERE BookBarcode = "{bookbarcode}"')
            fetch = cursor.fetchone()
            print(fetch)
            cursor.execute(f'INSERT INTO BorrowedBookInfo (BBookID, BookBarcode, startTime, ExpiryTime, RenewAllowance, OperatorID, ReaderID)\
                           VALUES ({fetch[0]}, "{bookbarcode}", "{datetime.now().date()}", "{expirytime}", {renew}, {operatorid}, {readerid})')
            connection.commit()
        except Exception as e:
            msg = 'Something went wrong' + str(e)
    
    cursor.execute(f'SELECT * FROM BorrowedBookInfo WHERE ReaderID = {current_user.get_id()}')
    fetch = cursor.fetchall()
    cursor.close()
    return render_template('userdash.html', user=current_user, msg=msg, fetch=fetch)


@views.route('/signout')
@login_required
def signout():
    users.clear()
    logout_user()
    return redirect(url_for('auth.login'))