from playwright.sync_api import Page


def test_dallas(page: Page):
    page.goto("https://www.google.com")
    page.type("input[name=q]", "Dallas Mavericks")
    page.click("input[type=submit]")
    text_value = page.waitForSelector("text=Dallas Mavericks")
    assert text_value