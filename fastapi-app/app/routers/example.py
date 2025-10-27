"""Example router with simple demonstration endpoints.

Contains two read-only endpoints used by tests and documentation.
"""

from fastapi import APIRouter


router = APIRouter(prefix="/example", tags=["Example"])


@router.get("/")
def get_example():
    """Return a static message for the example route."""
    return {"message": "This is an example endpoint."}


@router.get("/{item_id}")
def get_item(item_id: int):
    """Return a simple item representation for the provided item_id.

    Args:
        item_id: Integer identifier for the example item.
    """
    return {"item_id": item_id, "description": f"Item number {item_id}"}
