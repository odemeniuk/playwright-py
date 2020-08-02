#!/usr/bin/env bash
echo "-> Installing dependencies"
pipenv update
pipenv run python -m playwright install

echo "-> Removing old Allure results"
#rm -r allure-report
rm -r allure-results/ || echo "No results"

echo "-> Start tests"
pipenv run pytest test --alluredir allure-results
echo "-> Test finished"

echo "-> Generating report"
allure serve
#allure generate allure-results --clean -o allure-report
echo "-> Execute 'allure serve' in the command line"

