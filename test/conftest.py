"""
This module contains shared fixtures.
"""
import json

import pytest


@pytest.fixture(scope="session")
def launch_arguments(request):
    return {"slowMo": 100}
#

