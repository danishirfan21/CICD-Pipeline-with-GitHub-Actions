"""pytest conftest to ensure project root is on sys.path during collection.

Some CI environments or unusual workspace paths can cause the top-level
package (`app`) not to be importable by pytest. This file inserts the
project root into sys.path before tests are imported.
"""
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT))
