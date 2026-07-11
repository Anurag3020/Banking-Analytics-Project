import streamlit as st
import pandas as pd
import joblib

# --------------------------------------------------
# Page Configuration
# --------------------------------------------------

st.set_page_config(
    page_title="Loan Prediction",
    page_icon="🏦",
    layout="wide"
)

st.title("🏦 Loan Default Prediction System")
st.markdown("Select a Loan ID to evaluate the customer's loan risk.")

st.divider()

# --------------------------------------------------
# Load Dataset & Model
# --------------------------------------------------

df = pd.read_csv("app_data/model_dataset.csv")

model = joblib.load("loan_default_model.pkl")
scaler = joblib.load("scaler.pkl")

# --------------------------------------------------
# Loan Selection
# --------------------------------------------------

loan_id = st.selectbox(
    "Select Loan ID",
    sorted(df["loan_id"].unique())
)

selected = df[df["loan_id"] == loan_id].iloc[0]

st.divider()

# --------------------------------------------------
# Display Customer Information
# --------------------------------------------------

left, right = st.columns(2)

with left:

    st.subheader("👤 Customer Information")

    st.metric("Client ID", selected["client_id"])
    st.metric("Age", selected["age"])
    st.metric("Gender", selected["gender"])
    st.metric("Has Card", "Yes" if selected["has_card"] == 1 else "No")

    st.metric("Average Salary", f"{selected['avg_salary']:,.0f}")
    st.metric("Unemployment Rate", f"{selected['unemployment_rate']:.2f}%")

with right:

    st.subheader("💰 Loan Information")

    st.metric("Loan Amount", f"{selected['amount']:,.0f}")
    st.metric("Duration", f"{selected['duration']} Months")

    st.metric("Average Balance", f"{selected['avg_balance']:,.0f}")
    st.metric("Maximum Balance", f"{selected['max_balance']:,.0f}")

    st.metric("Total Transactions", int(selected["total_transactions"]))

    st.metric(
        "Average Transaction",
        f"{selected['avg_transaction_amount']:,.2f}"
    )

    st.metric(
        "Credit Withdrawal Ratio",
        round(selected["credit_withdrawal_ratio"], 3)
    )

st.divider()

st.info("✅ Customer information loaded successfully.")

# --------------------------------------------------
# Prediction Button
# --------------------------------------------------

if st.button("🔍 Predict Loan Risk", use_container_width=True):

    # Prepare Features
    features = [[
        selected["amount"],
        selected["duration"],
        selected["avg_balance"],
        selected["max_balance"],
        selected["total_transactions"],
        selected["avg_transaction_amount"],
        selected["credit_withdrawal_ratio"],
        selected["age"],
        selected["avg_salary"],
        selected["unemployment_rate"],
        selected["has_card"]
    ]]

    # Scale Features
    features_scaled = scaler.transform(features)

    # Prediction
    prediction = model.predict(features_scaled)[0]

    # Probability
    probability = model.predict_proba(features_scaled)[0][1]

    prob = probability * 100

    st.divider()

    # --------------------------------------------------
    # Prediction Result
    # --------------------------------------------------

    st.subheader("📊 Prediction Result")

    if prediction == 0:
        st.success("🟢 Prediction: Good Loan")
    else:
        st.error("🔴 Prediction: Bad Loan")

    st.metric(
        "Default Probability",
        f"{prob:.2f}%"
    )

    if prob < 30:
        st.success("🟢 Risk Level: LOW")
        recommendation = "✅ Approve Loan"

    elif prob < 70:
        st.warning("🟡 Risk Level: MEDIUM")
        recommendation = "⚠️ Manual Review Required"

    else:
        st.error("🔴 Risk Level: HIGH")
        recommendation = "❌ Reject Loan"

    st.info(f"### 💼 Business Recommendation\n{recommendation}")