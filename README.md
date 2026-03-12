# 🧾 SanoyFresco Sales Analytics

![SQL](https://img.shields.io/badge/SQL-Analytics-blue?style=for-the-badge)
![Data Analytics](https://img.shields.io/badge/Data-Analytics-green?style=for-the-badge)
![Data Engineering](https://img.shields.io/badge/Data-Engineering-orange?style=for-the-badge)
![Business Intelligence](https://img.shields.io/badge/Business-Intelligence-purple?style=for-the-badge)
![GitHub](https://img.shields.io/badge/GitHub-Project-black?style=for-the-badge&logo=github)

## 📊 Project Overview

**SanoyFresco Sales Analytics** is a data analytics project focused on analyzing transactional sales data to generate business insights.

The project explores sales performance, customer behavior, and product trends using **SQL-based analytics** over a transactional dataset.

The goal is to simulate a **real-world analytics workflow**, where raw business data is transformed into meaningful insights that support strategic decision-making.

This project demonstrates practical skills in:

- SQL Data Analysis
- Business Intelligence
- Sales Analytics
- Data Exploration
- Analytical Query Design

---

# 🎯 Objectives

The main goals of this project are:

- Analyze **business revenue trends**
- Identify **top-performing products**
- Understand **customer purchasing behavior**
- Evaluate **department and section performance**
- Calculate **key sales metrics**

These insights can help businesses:

- optimize product strategies
- understand customer value
- improve operational decisions

---

# 🧠 Key Business Questions

The analysis answers several key business questions:

### Revenue Analysis
- What is the **total revenue generated** by the business?
- What are the **monthly revenue trends**?

### Sales Performance
- Which **departments generate the most revenue**?
- How are **sales distributed across store sections**?

### Product Analysis
- What are the **top 10 most sold products**?
- Which products generate the **highest revenue**?

### Customer Analysis
- Who are the **top customers by spending**?
- What is the **average purchase value per customer**?

### Order Metrics
- How many **total orders** have been made?
- What is the **average order value**?

---

# 🗂 Dataset

The dataset represents transactional sales data from a retail system.

The main table analyzed is: 
'''tickets'''

It includes fields such as:

| Column | Description |
|------|-------------|
| id_pedido | Order identifier |
| id_cliente | Customer identifier |
| nombre_producto | Product name |
| id_departamento | Department identifier |
| id_seccion | Section identifier |
| cantidad | Quantity sold |
| precio_total | Total price of the transaction |
| fecha | Transaction date |

This structure allows performing multiple types of analysis including **product performance, revenue tracking, and customer segmentation**.

---

# 🛠 Technologies Used

This project uses:

- **SQL**
- **SQL Server**
- **Git & GitHub**
- **Data Analysis Techniques**

Concepts applied:

- Aggregations (`SUM`, `AVG`, `COUNT`)
- Data grouping (`GROUP BY`)
- Ranking queries (`TOP`)
- Subqueries
- Revenue analysis
- Customer metrics

---

# 📈 Example Insights

The analysis can generate insights such as:

- Monthly sales trends
- Best-selling products
- Most valuable customers
- Department revenue distribution
- Average order value

These metrics are commonly used in **business intelligence dashboards and retail analytics systems**.

---

# 📂 Repository Structure

'''
sanoyfresco-sales-analytics
│
├── datasets/ # Dataset used for the analysis
├── sql/ # SQL scripts with analytical queries
│
├── docs/ # Project documentation
│
├── README.md # Project documentation
└── LICENSE
'''

---

# 🚀 How to Use

1️⃣ Clone the repository

```bash
git clone https://github.com/leandrogallo-dev/sanoyfresco-sales-analytics.git
