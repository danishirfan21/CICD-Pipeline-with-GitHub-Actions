<#
.SYNOPSIS
  Developer helper script to setup environment and run common tasks.

.DESCRIPTION
  Provides simple commands to create a virtual environment, install
  dependencies, run tests, run formatting and linting, and build the
  Docker image for the project. Designed for PowerShell (Windows).

.USAGE
  # From repository root (fastapi-app):
  .\scripts\dev.ps1 setup       # create venv and install deps
  .\scripts\dev.ps1 test        # run pytest with coverage
  .\scripts\dev.ps1 lint        # run pylint (exit-zero)
  .\scripts\dev.ps1 format      # run black to format
  .\scripts\dev.ps1 format-check# check black formatting
  .\scripts\dev.ps1 docker      # build docker image (requires Docker)
  .\scripts\dev.ps1 all         # run format, lint, test
#>

param(
    [string]$task = 'all'
)

# Resolve project root (fastapi-app)
$scriptPath = $MyInvocation.MyCommand.Path
$scriptDir = Split-Path -Parent $scriptPath
$projectRoot = Split-Path -Parent $scriptDir
Set-Location $projectRoot

function Activate-Venv {
    if (Test-Path .venv) {
        Write-Host "Activating venv..."
        . .\.venv\Scripts\Activate.ps1
    } else {
        Write-Host "Virtual environment not found. Run 'dev.ps1 setup' first." -ForegroundColor Yellow
    }
}

switch ($task.ToLower()) {
    'setup' {
        Write-Host "Creating virtual environment and installing dependencies..."
        python -m venv .venv
        . .\.venv\Scripts\Activate.ps1
        python -m pip install --upgrade pip
        pip install -r requirements.txt
        break
    }
    'test' {
        Activate-Venv
        Write-Host "Running tests with coverage..."
        pytest --maxfail=1 --disable-warnings -q --cov=app --cov-report=term-missing --cov-report=xml
        break
    }
    'lint' {
        Activate-Venv
        Write-Host "Running pylint (exit-zero)..."
        pylint app --exit-zero
        break
    }
    'format' {
        Activate-Venv
        Write-Host "Formatting with black..."
        black .
        break
    }
    'format-check' {
        Activate-Venv
        Write-Host "Checking format with black..."
        black --check .
        break
    }
    'docker' {
        Write-Host "Building docker image (requires Docker installed)..."
        docker build -t fastapi-app:local ..
        break
    }
    'all' {
        Activate-Venv
        Write-Host "Running format, lint, and tests..."
        black .
        pylint app --exit-zero
        pytest --maxfail=1 --disable-warnings -q --cov=app --cov-report=term-missing --cov-report=xml
        break
    }
    default {
        Write-Host "Unknown task '$task'. Valid: setup,test,lint,format,format-check,docker,all"
        break
    }
}
