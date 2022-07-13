from fastapi import FastAPI, HTTPException, status
from pydantic import BaseModel
import psycopg2
import config

app = FastAPI()

class Book(BaseModel):
    id: int
    title: str
    author: str
    genres: list
    pages: int


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
def add_book(new_book: Book):
    for book in books:
        if new_book.title == book.title:
            raise HTTPException(status_code=status.HTTP_306_RESERVED)
    books.append(new_book)
    raise HTTPException(status_code=status.HTTP_201_CREATED)


@app.delete("/book")
def delete_book(title: str):
    for i in range(len(books)):
        if title == books[i].title:
            del books[i]
            raise HTTPException(status_code=status.HTTP_200_OK)
    raise HTTPException(status_code=status.HTTP_404_NOT_FOUND)
