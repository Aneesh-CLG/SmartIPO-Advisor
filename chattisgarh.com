import requests
from bs4 import BeautifulSoup
import pandas as pd

# Chittorgarh IPO performance tracker URL
url = "https://www.chittorgarh.com/report/ipo-performance-tracker/57/"
headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
}

# Fetch the page
response = requests.get(url, headers=headers)
if response.status_code != 200:
    print("Failed to load page. Status code:", response.status_code)
    exit()

# Parse the page
soup = BeautifulSoup(response.text, "html.parser")

# Find the IPO performance table
table = soup.find("table")
rows = table.find_all("tr")

# Extract headers
headers = [th.text.strip() for th in rows[0].find_all("th")]

# Extract data rows
data = []
for row in rows[1:]:
    cols = row.find_all("td")
    if len(cols) == len(headers):
        data.append([col.text.strip().replace('\n', '') for col in cols])

# Create a DataFrame
df = pd.DataFrame(data, columns=headers)

# Optional: convert price columns to numeric
for col in ['Issue Price (Rs)', 'Listing Price (Rs)', 'Current Price (Rs)', 'Gain at List (%)', 'Current Gain (%)']:
    if col in df.columns:
        df[col] = df[col].str.replace(",", "").str.replace("%", "").astype(str)
        df[col] = pd.to_numeric(df[col], errors='coerce')

# Save to CSV
df.to_csv("chittorgarh_ipo_data.csv", index=False)
print("IPO data saved to 'chittorgarh_ipo_data.csv'")
