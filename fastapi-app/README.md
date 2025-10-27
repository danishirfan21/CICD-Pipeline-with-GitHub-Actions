# fastapi-app

[//]: # (Replace OWNER and REPO below with your GitHub owner and repository name)

<!-- Badges -->
[![CI](https://github.com/danishirfan21/CICD-Pipeline-with-GitHub-Actions/actions/workflows/ci.yml/badge.svg)](https://github.com/danishirfan21/CICD-Pipeline-with-GitHub-Actions/actions/workflows/ci.yml)
[![Python](https://img.shields.io/badge/python-3.11%2B-blue)](https://www.python.org/)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)

> Minimal FastAPI example used for CI/CD demos, local development, and technical interviews.

This repository contains a small, well-tested FastAPI application that demonstrates a typical project structure, tests, linters, and a GitHub Actions CI pipeline. It's intentionally lightweight so it can be used as a sample app for hiring/recruiting, demonstrations, and CI experiments.

## Highlights

- FastAPI-based HTTP API
- Dockerfile included for container builds
- Tests with pytest and coverage
- `black` and `pylint` configured for formatting and linting
- GitHub Actions workflow for build, test, lint, and SonarQube scan

## Tech stack

- Python 3.11+ (project file uses 3.11 in CI)
- FastAPI
- Uvicorn for local development server
- pytest + pytest-cov for tests and coverage
- httpx for test client
- Black and Pylint for formatting & linting

## Quick contract (inputs / outputs)

- Input: HTTP requests to the API endpoints documented below.
- Output: JSON responses with status codes indicating success/error.
- Error modes: invalid input → 422; not found → 404; server error → 500.

## Endpoints

- `GET /` — basic health / welcome message
  - Response: `{ "message": "Welcome to the FastAPI CI/CD Example!" }`
- `GET /example/` — example endpoint
  - Response: `{ "message": "This is an example endpoint." }`
- `GET /example/{item_id}` — example item endpoint
  - Path param: `item_id` (int)
  - Response: `{ "item_id": <int>, "description": "Item number <int>" }`

See `app/routers/example.py` for implementation and additional details.

## Quick start (local)

These commands assume you're on Windows PowerShell. Adjust as needed for other shells/OSes.

1. Change into the project folder

```powershell
cd 'D:\CICD Pipeline with GitHub Actions\fastapi-app'
```

2. Create a venv and install dependencies (recommended)

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
pip install -r requirements.txt
```

3. Run the app locally (Uvicorn)

```powershell
uvicorn app.main:app --reload --host 127.0.0.1 --port 8000
```

4. Try the endpoints

```powershell
Invoke-RestMethod -Method GET -Uri http://127.0.0.1:8000/
Invoke-RestMethod -Method GET -Uri http://127.0.0.1:8000/example/
Invoke-RestMethod -Method GET -Uri http://127.0.0.1:8000/example/123
```

## Tests & coverage

Run the test suite and view coverage output:

```powershell
pytest --cov=app --cov-report=term-missing --cov-report=xml
# optional: open HTML report if generated
# python -m webbrowser htmlcov/index.html
```

If `--cov` flags give `unrecognized arguments`, ensure `pytest-cov` is installed in the active environment (`pip install pytest-cov`) or use the project's `requirements.txt`.

## Linting & formatting

Format with Black:

```powershell
black .
```

Run Pylint:

```powershell
pylint app
```

## Docker

Build and run the image locally:

```powershell
docker build -t fastapi-app:local .
docker run --rm -p 8000:8000 fastapi-app:local
```

## CI / CD

This project includes a GitHub Actions workflow at `.github/workflows/ci.yml` that:

- Checks out the code
- Sets up Python 3.11
- Installs requirements
- Runs Black and Pylint
- Runs pytest with coverage
- (separately) builds & pushes a Docker image
- Runs SonarQube analysis (if SONAR_TOKEN and SONAR_HOST_URL are set)

Notes for CI maintainers:
- If your repository root contains multiple projects, update the workflow to use `working-directory: fastapi-app` for the test and install steps, or change the pip install path to `fastapi-app/requirements.txt`.

## Development notes & edge cases

- The test suite includes a `tests/conftest.py` that ensures the `app` package is importable during pytest collection. This is helpful in CI and developer machines with different working directories.
- Edge cases to consider for future work: missing authentication, input validation at scale, and rate limiting.

## How I validated this project

- Ran `pytest` locally and verified all tests pass.
- Ensured coverage reporting works when `pytest-cov` is installed.

## Contributing

Contributions are welcome. Small suggestions:

- Open an issue to discuss larger changes
- Create small PRs with a clear title and linked issue
- Add tests for new behavior and run `black` before opening PRs

## License

This project is provided under the MIT License. See `LICENSE` for details.

---

If you'd like, I can also:
- add a filled-in GitHub Actions badge (I need the repo owner/name),
- generate a small `README` section for API examples with curl snippets, or
- add a short `Makefile`/PowerShell script to standardize common dev tasks.
