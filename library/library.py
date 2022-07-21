from typing import Optional
from fastapi import FastAPI, HTTPException, status
from pydantic import BaseModel
import psycopg2
import config

app = FastAPI()

class Book(BaseModel):
    id: Optional[int]
    title: str
    author: str
    genres: list
    pages: int


class Library(BaseModel):
    name: str
    address: str


try:
    connection = psycopg2.connect(
        host=config.host,
        user=config.user,
        password=config.password,
        database=config.db_name
    )
    connection.autocommit = True
    cursor = connection.cursor()
except Exception as e:
    print("[ERROR]", e)


@app.get("/")
def home():
    cursor.execute("""SELECT DISTINCT b.id, b.title, a.author_name, b.pages, g.genre from books b
                JOIN authors a ON a.id = b.author_id
                JOIN book_genre bg ON bg.book_id = b.id
                JOIN genres g ON g.id = bg.genre_id ORDER BY b.id""")
    data = cursor.fetchall()
    books = {}
    for row in data:
        id = row[0]
        if id in books:
            books[id].genres.append(row[4])
        else:
            books[id] = Book(
                id = id,
                title = row[1],
                author = row[2],
                pages = row[3],
                genres = [row[4]]
            )
    return {"books": books}


@app.get("/book")
def get_book(title: str):
    try:
        cursor.execute("""SELECT DISTINCT b.id, b.title, a.author_name, b.pages, g.genre from books b
                    JOIN authors a ON a.id = b.author_id
                    JOIN book_genre bg ON bg.book_id = b.id
                    JOIN genres g ON g.id = bg.genre_id
                    WHERE b.title = %s""",
                    (title,))
        data = cursor.fetchall()
        book = Book(
            id = data[0][0],
            title = data[0][1],
            author = data[0][2],
            pages = data[0][3],
            genres = []
        )
        for row in data:
            book.genres.append(row[4])
        return {
            book.id: {
                "title": book.title,
                "author": book.author,
                "genre": book.genres,
                "pages": book.pages
            }
        }
    except Exception as e:
        print("[ERROR]", e)
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND)


@app.post("/book")
def add_book(book: Book):
    # check if book is already in DB
    cursor.execute("SELECT 1 FROM books WHERE title = %s AND author_id = (SELECT id FROM authors WHERE author_name = %s)", (book.title, book.author))
    # not in DB
    if not cursor.fetchone():
        # unknown author - id 1
        if not book.author.strip():
            author_id = 1
        else:
            cursor.execute("SELECT id FROM authors WHERE author_name = %s", (book.author,))
            try:
                author_id = cursor.fetchone()[0]
            except:
                raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="unknown author")
        cursor.execute("INSERT INTO books (title, author_id, pages) VALUES (%s, %s, %s)", (book.title, author_id, book.pages))
        cursor.execute("SELECT max(id) FROM books")
        book.id = cursor.fetchone()[0]
        for genre in book.genres:
            try:
                cursor.execute("INSERT INTO book_genre (book_id, genre_id) VALUES (%s, (SELECT id FROM genres WHERE genre = %s))", (book.id, genre))
            except Exception as e:
                print("[ERROR]", e)
        raise HTTPException(status_code=status.HTTP_201_CREATED, detail="book added")
    # book is already in DB
    else:
        raise HTTPException(status_code=status.HTTP_306_RESERVED, detail="This book is already in DataBase")


@app.delete("/book")
def delete_book(title: str, author: str):
    cursor.execute("DELETE FROM books WHERE title = %s AND author_id = (SELECT id FROM authors WHERE author_name = %s)", (title, author))
    raise HTTPException(status_code=status.HTTP_200_OK, detail="book deleted")


@app.get("/authors")
def get_authors():
    cursor.execute("SELECT * FROM authors")
    authors = {}
    for row in cursor.fetchall():
        authors[row[0]] = row[1]
    return authors


@app.post("/author")
def add_author(author_name: str):
    # check if author is already in DB
    cursor.execute("SELECT 1 FROM authors WHERE author_name = %s", (author_name,))
    # no
    if not cursor.fetchone():
        cursor.execute("INSERT INTO authors (author_name) VALUES (%s)", (author_name,))
        raise HTTPException(status_code=status.HTTP_200_OK, detail="added author")
    # yes
    else:
        raise HTTPException(status_code=status.HTTP_306_RESERVED, detail="author is already in DB")


@app.delete("/author")
def delete_author(author_name: str):
    # delete author
    cursor.execute("DELETE FROM authors WHERE author_name = %s", (author_name,))
    raise HTTPException(status_code=status.HTTP_200_OK)


@app.get("/libs")
def get_libs():
    # fetching libraries
    cursor.execute("SELECT id, name, address FROM libraries")
    libs = {}
    for row in cursor.fetchall():
        libs[row[0]] = {
            "name": row[1],
            "address": row[2]
        }
    return libs
