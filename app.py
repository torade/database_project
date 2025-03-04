import psycopg2
import re

conn = psycopg2.connect(database="library", user="postgres", password="Qwerty1234", host="localhost", port="5432")
cur = conn.cursor()
from flask import Flask, flash, render_template, request, redirect, url_for
app = Flask(__name__)
app.secret_key = "superSecretKey" 
# Home page
@app.route("/")
def home():
    return render_template("index.html")

#Q1
# get all books (title, authors, publisher, publication year, genre)
@app.route("/display_books")
def display_books():
    sql = """SELECT b.title, STRING_AGG(CONCAT(a.first_name, ' ', a.last_name), ', ') AS authors, publisher, publication_year, g.genre_name
FROM BOOK b
JOIN GENRE g ON g.genre_id = b.genre_id
JOIN BOOK_AUTHOR ba ON b.book_id = ba.book_id
JOIN AUTHOR a ON ba.author_id = a.author_id
GROUP BY b.book_id, b.title, b.publisher, b.publication_year, g.genre_name
ORDER BY b.title;
"""
    cur.execute(sql)
    rows = cur.fetchall()
    return render_template("all_books.html", books=rows)


#Q2
#Get book title for books written by specific author
@app.route("/books_by_author", methods=["GET","POST"])
def display_books_by_author():
    rows=[]
    if request.method == "POST":
        author_first_name = request.form.get("first_name").strip()
        author_last_name = request.form.get("last_name").strip()
        print(f"Searching for books by {author_first_name} {author_last_name}")
        sql = """SELECT title, STRING_AGG(CONCAT(a.first_name, ' ', a.last_name), ', ') AS authors
    FROM BOOK b
    JOIN BOOK_AUTHOR ba ON b.book_id = ba.book_id
    JOIN AUTHOR a ON a.author_id = ba.author_id
    WHERE a.first_name ILIKE %s AND a.last_name ILIKE %s 
    GROUP BY b.title""" #we use ILIKE instead of LIKE to not be case sensitive (the program can now take 'george orwell' and 'George Orwell')
        print(f"SQL Query: {sql}")
        print(f"Parameters: ({author_first_name}, {author_last_name})")
        try:
            cur.execute(sql,(author_first_name, author_last_name))
            rows = cur.fetchall()
            print(rows)
        except Exception as e:
            print(f"No books found for {author_first_name} {author_last_name}.") #MODIFY THIS!!!
    return render_template("books_by_author.html", books=rows)
#Q3: get books by genre
@app.route("/books_by_genre", methods=["GET", "POST"])
def display_books_by_genre():
    genres = []
    books = []

    cur.execute("SELECT genre_id, genre_name FROM GENRE ORDER BY genre_name;")
    genres = cur.fetchall()

    if request.method == "POST":
        genre_id = request.form.get("genre_id")
        if genre_id:
            sql = """SELECT b.title, STRING_AGG(CONCAT(a.first_name, ' ', a.last_name), ', ') AS authors, 
                            b.publisher, b.publication_year 
                     FROM BOOK b
                     JOIN BOOK_AUTHOR ba ON b.book_id = ba.book_id
                     JOIN AUTHOR a ON ba.author_id = a.author_id
                     WHERE b.genre_id = %s
                     GROUP BY b.book_id, b.title, b.publisher, b.publication_year
                     ORDER BY b.title;
            """
            cur.execute(sql, (genre_id,))
            books = cur.fetchall()

    return render_template("books_by_genre.html", genres=genres, books=books)

#Q4
# add user
@app.route("/add_user", methods=["GET", "POST"])
def add_user():
    if request.method == "POST":
        first_name = request.form["first_name"].strip()
        last_name = request.form["last_name"].strip()
        email = request.form["email"].strip()
        phone = request.form["phone"].strip()

        sql_injection_pattern = r"[;'\"]"  
           
        if re.search(sql_injection_pattern, first_name):
            flash("Invalid input in FIRST NAME! Please avoid special characters.", "error")
            return redirect(url_for("add_user"))

        if re.search(sql_injection_pattern, last_name):
            flash("Invalid input in LAST NAME! Please avoid special characters.", "error")
            return redirect(url_for("add_user"))

        if re.search(sql_injection_pattern, phone):
            flash("Invalid input in PHONE NUMBER! Please avoid special characters.", "error")
            return redirect(url_for("add_user"))


        if not first_name or not last_name or not email or not phone:
            flash("All fields are required!", "error")
            return redirect(url_for("add_user"))
        try:
            sql = """INSERT INTO users (first_name, last_name, email, phone) VALUES (%s, %s, %s, %s)"""
            cur.execute(sql, (first_name, last_name, email, phone))
            conn.commit()
            flash("User added successfully!", "success")
        except Exception as e:
            conn.rollback()
            flash("Error adding user: " + str(e), "error")

        return redirect(url_for("add_user"))

    return render_template("add_user.html")

#Q5
#Display users
@app.route("/display_users")
def display_users():
    try:
        cur.execute("SELECT user_id, first_name, last_name, email, phone FROM users ORDER BY user_id;")
        users = cur.fetchall()  # Fetch all users from the database
    except Exception as e:
        users = []
        flash(f"Error fetching users: {str(e)}", "error")

    return render_template("display_users.html", users=users)

#Q6
#Borrow a book
@app.route("/borrow_book", methods=["GET", "POST"])
def borrow_book():
    if request.method == "POST":
        user_id = request.form.get("user_id")  
        book_title = request.form.get("book_title")

        if not user_id or not book_title:
            flash("User ID and Book title are required!", "error")
            return redirect(url_for("borrow_book"))

        # Check if the book is already borrowed
        try:
            with conn.cursor() as cur:
                # Get book_id from the title
                book_title = "%"+book_title+"%"
                cur.execute("SELECT book_id FROM BOOK WHERE title ILIKE %s;", (book_title,)) #changed it to retrieve books even if the input is lower_case/incomplete (e.g.: "harry potter" works for retrieving "Harry Potter and the Philosopher's Stone")
                book = cur.fetchone()

                if not book:
                    flash("Invalid Book Title! Please enter an existing book.", "danger")
                    return redirect(url_for("borrow_book"))

                book_id = book[0]  

                # Check if book is already borrowed
                cur.execute("SELECT loan_id FROM LOAN WHERE book_id = %s AND return_date IS NULL;", (book_id,))
                existing_loan = cur.fetchone()
                if existing_loan:
                    flash("This book is already borrowed!", "danger")
                else:
                    cur.execute("INSERT INTO LOAN (book_id, user_id, borrow_date) VALUES (%s, %s, CURRENT_DATE);", (book_id, user_id))
                    conn.commit()
                    flash("Book borrowed successfully!", "success")
        except Exception as e:
            conn.rollback()
            flash(f"Error processing loan: {str(e)}", "error")

        return redirect(url_for("borrow_book"))

    # Fetch users and books
    try: 
        with conn.cursor() as cur:
            cur.execute("SELECT user_id, first_name, last_name FROM USERS ORDER BY first_name;")
            users = cur.fetchall()

            cur.execute("""
                SELECT b.book_id, b.title 
                FROM BOOK b 
                WHERE NOT EXISTS (
                    SELECT 1 FROM LOAN l WHERE l.book_id = b.book_id AND l.return_date IS NULL
                )
                ORDER BY b.title;
            """)
            books = cur.fetchall()
    except Exception as e:
        conn.rollback()  
        flash(f"Error fetching data: {str(e)}", "error")
        users = []
        books = []

    return render_template("borrow_book.html", users=users, books=books)


#Q7
#display user information and book information for overdue loans / late returns (each book should be borrowed for max. 1 week/7 days)
@app.route("/overdue")
def overdue():
    try:
        cur.execute("""SELECT u.user_id,u.first_name, u.last_name, u.email, u.phone, b.title,borrow_date, return_date, (borrow_date +  INTERVAL '7 days') AS expected_return_date
FROM LOAN l
JOIN USERS u ON l.user_id = u.user_id
JOIN BOOK b ON l.book_id = b.book_id
WHERE (return_date IS NULL AND borrow_date <= CURRENT_DATE - INTERVAL '7 days')
OR (return_date IS NOT NULL AND borrow_date <= return_date - INTERVAL '7 days')""")
        info = cur.fetchall()
    except Exception as e:
        info = []
        flash(f"Error fetching users: {str(e)}", "error")

    return render_template("overdue.html", overdue_info=info)


if __name__ == "__main__":
    app.run(debug=True)