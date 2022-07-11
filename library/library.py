from email.policy import HTTP
from fastapi import FastAPI, HTTPException, status
from pydantic import BaseModel

app = FastAPI()

class Book(BaseModel):
    title: str
    genre: str
    author: str
    pages: int

books: Book = list()

@app.get("/")
def home():
    return {"books": books}


@app.get("/book")
def get_book(title: str):
    for book in books:
        if book.title == title:
            return {
                "book": {
                    "title": book.title,
                    "genre": book.genre,
                    "author": book.genre,
                    "pages": book.pages
                }
            }
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
