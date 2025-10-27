"""Application entrypoint for the FastAPI CI/CD example.

This module defines the FastAPI application instance and mounts the
example router. It exposes a single root endpoint used by tests and
health checks.
"""

from fastapi import FastAPI
from app.routers import example


app = FastAPI(title="FastAPI CI/CD Example")

# Include routes from routers/example.py
app.include_router(example.router)


@app.get("/")
def read_root():
    """Root endpoint returning a welcome message.

    Used by tests to verify the application is wired correctly.
    """
    return {"message": "Welcome to the FastAPI CI/CD Example!"}
