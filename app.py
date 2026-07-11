import streamlit as st

# --------------------------------------------------
# Page Configuration
# --------------------------------------------------
st.set_page_config(
    page_title="Banking Analytics Solution",
    page_icon="🏦",
    layout="wide",
    initial_sidebar_state="expanded"
)

# --------------------------------------------------
# Header
# --------------------------------------------------

st.title("🏦 Banking Analytics Solution")
st.subheader("Czechoslovakia Bank")
st.markdown("---")

st.markdown(
"""
### 📌 Project Overview

This project demonstrates a complete **Banking Analytics Solution**
covering SQL data validation, exploratory data analysis,
interactive dashboards and machine learning for loan default prediction.
"""
)

# --------------------------------------------------
# KPI Cards
# --------------------------------------------------

st.markdown("## 📊 Key Business Metrics")

col1, col2, col3 = st.columns(3)

with col1:
    st.metric("👥 Customers", "5,369")

with col2:
    st.metric("🏦 Accounts", "4,500")

with col3:
    st.metric("💰 Loans", "682")

col4, col5, col6 = st.columns(3)

with col4:
    st.metric("💳 Transactions", "1,048,575")

with col5:
    st.metric("🌍 Districts", "77")

with col6:
    st.metric("⚠ Loan Default Rate", "11.1%")

st.divider()

# --------------------------------------------------
# Two Column Layout
# --------------------------------------------------

left, right = st.columns(2)

with left:

    st.subheader("🎯 Project Objectives")

    st.success("""
✔ SQL Data Validation

✔ Data Cleaning

✔ Exploratory Data Analysis

✔ Machine Learning

✔ Loan Default Prediction

✔ Power BI Dashboard

✔ Streamlit Deployment
""")

with right:

    st.subheader("🛠 Technology Stack")

    st.info("""
**Database**

• SQL Server

**Programming**

• Python

• Pandas

• NumPy

• Scikit-Learn

**Visualization**

• Power BI

• Matplotlib

**Deployment**

• Streamlit

• GitHub
""")

st.divider()

# --------------------------------------------------
# Workflow
# --------------------------------------------------

st.subheader("📈 Project Workflow")

st.markdown("""
➡️ **Raw Banking Data**

⬇️

🧹 **SQL Validation & Cleaning**

⬇️

📊 **Exploratory Data Analysis**

⬇️

⚙️ **Feature Engineering**

⬇️

🤖 **Machine Learning Model**

⬇️

🎯 **Loan Default Prediction**

⬇️

📈 **Business Dashboard**
""")

st.divider()

st.caption(
    "Developed by Anurag | Banking Analytics Project | Data Analytics Internship"
)
