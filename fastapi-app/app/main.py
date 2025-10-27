from fastapi import FastAPI
from app.routers import example

app = FastAPI(title="FastAPI CI/CD Example")

# Include routes from routers/example.py
app.include_router(example.router)

@app.get("/")
def read_root():
    return {"message": "Welcome to the FastAPI CI/CD Example!"}
