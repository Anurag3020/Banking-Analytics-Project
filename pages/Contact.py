import streamlit as st

# --------------------------------------------------
# Page Configuration
# --------------------------------------------------

st.set_page_config(
    page_title="Contact",
    page_icon="📬",
    layout="wide"
)

# --------------------------------------------------
# Title
# --------------------------------------------------

st.title("📬 Contact")

st.markdown("""
Thank you for exploring my **Banking Analytics Project**.

If you'd like to discuss this project, data analytics opportunities, or collaborate on future work, feel free to get in touch.
""")

st.divider()

# --------------------------------------------------
# Contact Information
# --------------------------------------------------

left, right = st.columns(2)

with left:

    st.subheader("👤 Contact Information")

    st.write("**Name:** Anurag")

    st.write("**Email:**")
    st.code("anuragprajapati431@gmail.com")

    st.write("**LinkedIn:**")
    st.markdown(
        "[www.linkedin.com/in/anuragprajapati-analytics](https://www.linkedin.com/in/anuragprajapati-analytics)"
    )

    st.write("**GitHub:**")
    st.markdown(
        "[github.com/Anurag3020/Banking-Analytics-Project](https://github.com/Anurag3020/Banking-Analytics-Project)"
    )

with right:

    st.subheader("🛠 Technical Skills")

    st.success("""
- SQL Server
- Python
- Pandas
- NumPy
- Scikit-Learn
- Streamlit
- Power BI
- Microsoft Excel
- Data Cleaning
- Exploratory Data Analysis (EDA)
- Machine Learning
- Data Visualization
""")

st.divider()



st.caption(
    "© 2026 Anurag | Banking Analytics Portfolio Project"
)