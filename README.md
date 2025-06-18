# 🚀 SmartIPO Advisor

**SmartIPO Advisor** is a Machine Learning-powered IPO analysis tool that predicts whether a new IPO will be successful, and offers **data-driven insights** and **benchmark comparisons** to guide better IPO decisions.

Built using `Gradio`, `scikit-learn`, and `joblib`, this tool combines **ML prediction** with real-world IPO benchmarks from 2019–2025 to offer both technical and intuitive guidance to founders, analysts, and investors.

---

## 📊 Features

- ✅ Predict IPO success based on:
  - Issue Price
  - Listing Day Gain (%)
  - Current Price
- 📈 Calculates:
  - Listing Day Close Price
  - Total Profit/Loss
- 🧠 Shows benchmark comparisons based on real successful IPOs
- 💡 Personalized insights (what’s missing and what’s working)
- 🔐 Trained with Random Forest + Scaler
- 🌐 Fully interactive web app (Gradio)

---

## 🛠️ Tech Stack

- Python
- Scikit-learn
- Gradio
- Joblib
- Pandas, NumPy

---

## 💾 Files in This Repository

.
├── ipo_predictor.py # Main Gradio App
├── rf_model.pkl # Trained Random Forest model
├── scaler.pkl # Scaler for model input
├── requirements.txt # Python dependencies
├── README.md # This file


---

## 📈 Ideal Benchmarks Used (Based on 2019–2025 Successful IPOs)

| Feature               | Ideal Value (Median / Mean) |
|-----------------------|-----------------------------|
| Issue Price           | ₹45.5 – ₹52                 |
| Listing Day Gain      | ≥ 2.5%                      |
| Current Price         | ≥ 10% above Issue Price     |
| Listing Day Close     | ≥ Issue Price               |
| Profit/Loss Overall   | ≥ 20%                       |

These were derived from cleaned historical IPO data covering 2019 to 2025.

---

## ⚙️ How to Run the App Locally

### 1. Clone the repository
```bash
git clone https://github.com/yourusername/smartipo-advisor.git
cd smartipo-advisor

pip install -r requirements.txt

python ipo_predictor.py
