from fastapi import FastAPI
from pydantic import BaseModel
from sqlalchemy import create_engine

engine = create_engine("sqlite:///db.sqlite")

with engine.connect() as conn:
  conn.execute(
      "CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT, age INTEGER, is_active BOOLEAN, balance FLOAT)"
  )
  conn.commit()


class User(BaseModel):
  id: int
  name: str
  age: int
  is_active: bool
  balance: float


app = FastAPI()


@app.get("/")
def root():
  return {"message": "Hello World"}


@app.post("/users")
def create_user(user: User):
  return user
