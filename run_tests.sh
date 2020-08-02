#!/usr/bin/env bash
echo "-> Installing dependencies"
pipenv clean
pipenv install
pipenv update
python -m playwright install

echo "-> Removing old Allure results"
rm -r allure-results/* || echo "No results"

echo "-> Start tests"
pytest --headful --alluredir allure-results
echo "-> Test finished"

echo "-> Generating report"
allure generate allure-results --clean -o allure-report
echo "-> Execute 'allure serve' in the command line"