import streamlit as st

st.set_page_config(page_title="Dashboard", layout="wide")

st.title("📊 Banking Analytics Dashboard")

st.markdown("---")

# Customer Analytics
st.header("👥 Customer Analytics")
st.image("images/customer_demographics.png", use_container_width=True)

st.markdown("---")

# Account Analytics
st.header("🏦 Account Analytics")
st.image("images/account_analysis.png", use_container_width=True)

st.markdown("---")

# Transaction Analytics
st.header("💳 Transaction Analytics")
st.image("images/transaction_analysis.png", use_container_width=True)

st.markdown("---")

# Loan Analytics
st.header("💰 Loan Analytics")
st.image("images/loan_analysis.png", use_container_width=True)

st.markdown("---")

# District Analysis
st.header("📍 District Analysis")
st.image("images/district_analysis.png", use_container_width=True)

st.markdown("---")

# Model Performance
st.header("🤖 Machine Learning")

col1, col2 = st.columns(2)

with col1:
    st.image("images/feature_importance.png", use_container_width=True)

with col2:
    st.image("images/roc_curve.png", use_container_width=True)

st.markdown("---")

st.header("📈 Model Evaluation")
st.image("images/confusion_matrices.png", use_container_width=True)

st.markdown("---")

st.header("📊 Additional Insights")

col1, col2 = st.columns(2)

with col1:
    st.image("images/account_opening_trend.png", use_container_width=True)

with col2:
    st.image("images/loan_origination_trend.png", use_container_width=True)

st.image("images/products_per_client.png", use_container_width=True)