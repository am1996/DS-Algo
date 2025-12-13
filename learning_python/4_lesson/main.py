from fastapi import FastAPI
from pydantic import BaseModel
from sqlalchemy import create_engine, text

engine = create_engine("sqlite:///db.sqlite")

with engine.connect() as conn:
  conn.execute(
      text(
          "CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, name TEXT, age INTEGER, is_active BOOLEAN, balance FLOAT)"
      ))
  conn.commit()


class User(BaseModel):
  id: int
  name: str
  age: int
  is_active: bool
  balance: float


app = FastAPI()


@app.get("/")
async def root():
  return {"message": "Hello World"}


@app.post("/users")
def create_user(user: User):
  with engine.connect() as conn:
    conn.execute(
        text(
            "INSERT INTO users (id, name, age, is_active, balance) VALUES (:id, :name, :age, :is_active, :balance)"
        ), user.dict())
    return user
