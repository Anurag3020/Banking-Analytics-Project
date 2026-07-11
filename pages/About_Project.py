import streamlit as st

# --------------------------------------------------
# Page Configuration
# --------------------------------------------------

st.set_page_config(
    page_title="About Project",
    page_icon="📘",
    layout="wide"
)

# --------------------------------------------------
# Title
# --------------------------------------------------

st.title("📘 About the Banking Analytics Project")

st.markdown("""
This project demonstrates an end-to-end **Banking Analytics Solution** developed
using SQL, Python, Machine Learning, and Streamlit.

The objective is to analyze customer banking behavior, generate business insights,
and predict the likelihood of loan default using a trained Machine Learning model.
""")

st.divider()

# --------------------------------------------------
# Project Objective
# --------------------------------------------------

st.header("🎯 Project Objective")

st.info("""
Develop an end-to-end banking analytics solution that:

- Cleans and validates banking data
- Performs exploratory data analysis (EDA)
- Identifies customer and transaction patterns
- Builds a machine learning model for loan default prediction
- Provides business recommendations through an interactive web application
""")

st.divider()

# --------------------------------------------------
# Dataset Overview
# --------------------------------------------------

st.header("🗂 Dataset Overview")

col1, col2 = st.columns(2)

with col1:
    st.metric("Customers", "5,369")
    st.metric("Accounts", "4,500")
    st.metric("Loans", "682")

with col2:
    st.metric("Transactions", "1,048,575")
    st.metric("Districts", "77")
    st.metric("Loan Default Rate", "11.1%")

st.divider()

# --------------------------------------------------
# Project Workflow
# --------------------------------------------------

st.header("📈 Project Workflow")

st.markdown("""
```text
Raw Banking Data
        │
        ▼
SQL Data Validation
        │
        ▼
Data Cleaning
        │
        ▼
Exploratory Data Analysis (EDA)
        │
        ▼
Feature Engineering
        │
        ▼
Machine Learning Model
        │
        ▼
Loan Default Prediction
        │
        ▼
Interactive Streamlit Dashboard

""")

st.divider()

# --------------------------------------------------
# Technology Stack
# --------------------------------------------------

st.header("🛠 Technology Stack")

col1, col2 = st.columns(2)

with col1:
    st.markdown("""
### Database

- SQL Server

### Programming

- Python
- Pandas
- NumPy
- Scikit-Learn
""")
with col2:
    st.markdown("""
### Visualization

- Matplotlib
- Power BI

### Deployment

- Streamlit
- GitHub
""")
st.divider()

#--------------------------------------------------
#Key Features
#--------------------------------------------------

st.header("⭐ Key Features")

st.success("""
✔ SQL Data Validation

✔ Data Cleaning

✔ Exploratory Data Analysis (EDA)

✔ Interactive Dashboard

✔ Loan Default Prediction

✔ Business Recommendation System

✔ Machine Learning Integration

✔ Streamlit Web Application
""")

st.divider()

# --------------------------------------------------
# Business Impact
# --------------------------------------------------

st.header("💼 Business Impact")

st.markdown("""
The solution enables banks to:

Reduce loan default risk through predictive analytics.
Understand customer demographics and banking behavior.
Identify high-risk applicants before loan approval.
Improve decision-making using data-driven insights.
Monitor business performance through interactive dashboards.
""")

st.divider()

st.caption(
"Developed by Anurag | Banking Analytics Project | Data Analytics Portfolio"
)