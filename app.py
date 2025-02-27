import psycopg2
conn = psycopg2.connect(database="library", user="postgres", password="Qwerty1234", host="localhost", port="5432")
cur = conn.cursor()
from flask import Flask, render_template, request, redirect, url_for
app = Flask(__name__)

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
        author_first_name = request.form.get("First Name")
        author_last_name = request.form.get("Last Name")
        sql = """SELECT title, STRING_AGG(CONCAT(a.first_name, ' ', a.last_name), ', ') AS authors
    FROM BOOK b
    JOIN BOOK_AUTHOR ba ON b.book_id = ba.book_id
    JOIN AUTHOR a ON a.author_id = ba.author_id
    WHERE a.first_name ILIKE %s AND a.last_name ILIKE %s 
    GROUP BY b.title""" #we use ILIKE instead of LIKE to not be case sensitive (the program can now take 'george orwell' and 'George Orwell')
        try:
            cur.execute(sql,(author_first_name, author_last_name))
            rows = cur.fetchall()
            print(rows)
        except Exception as e:
            print("Author not found.") #MODIFY THIS!!!
    return render_template("books_by_author.html", books=rows)

if __name__ == "__main__":
    app.run(debug=True)