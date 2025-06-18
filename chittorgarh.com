from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager
import pandas as pd
import time

# Setup headless Chrome
options = Options()
options.add_argument("--headless")
options.add_argument("--disable-gpu")
options.add_argument("--window-size=1920,1080")
options.add_argument("--no-sandbox")

# Automatically download and set up ChromeDriver
service = Service(ChromeDriverManager().install())
driver = webdriver.Chrome(service=service, options=options)

# Go to Chittorgarh IPO performance page
url = "https://www.chittorgarh.com/report/ipo-performance-tracker/57/"
driver.get(url)
time.sleep(3)

# Extract table
table = driver.find_element(By.TAG_NAME, "table")
rows = table.find_elements(By.TAG_NAME, "tr")

# Headers
headers = [th.text.strip() for th in rows[0].find_elements(By.TAG_NAME, "th")]

# Data
data = []
for row in rows[1:]:
    cols = row.find_elements(By.TAG_NAME, "td")
    if len(cols) == len(headers):
        data.append([col.text.strip() for col in cols])

# Save
df = pd.DataFrame(data, columns=headers)
df.to_csv("ipo_data_chittorgarh.csv", index=False)

print("Data saved to ipo_data_chittorgarh.csv")
driver.quit()
