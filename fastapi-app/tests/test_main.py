import pytest
from httpx import AsyncClient, ASGITransport
from app.main import app

@pytest.mark.asyncio
async def test_root_endpoint():
    async with AsyncClient(transport=ASGITransport(app=app), base_url="http://testserver") as client:
        response = await client.get("/")
        assert response.status_code == 200
        assert "message" in response.json()

@pytest.mark.asyncio
async def test_example_endpoint():
    async with AsyncClient(transport=ASGITransport(app=app), base_url="http://testserver") as client:
        response = await client.get("/example/")
        assert response.status_code == 200
        assert response.json()["message"] == "This is an example endpoint."

@pytest.mark.asyncio
async def test_example_item():
    async with AsyncClient(transport=ASGITransport(app=app), base_url="http://testserver") as client:
        response = await client.get("/example/123")
        assert response.status_code == 200
        data = response.json()
        assert data["item_id"] == 123
        assert "Item number" in data["description"]
