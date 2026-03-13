# 🛒 Market Basket Analysis – SanoyFresco Sales Data

![Market Basket Analysis](https://github.com/leandrogallo-dev/img-url-repository/blob/main/mba.png?raw=true)

## 📖 Overview

**Market Basket Analysis (MBA)** is a data mining technique used to discover relationships between products frequently purchased together.

It is widely used in **retail analytics** to identify patterns in customer purchasing behavior. These insights allow businesses to:

- Improve **product placement**
- Design **cross-selling strategies**
- Create **bundle offers**
- Optimize **recommendation systems**

A classic example is the well-known pattern:

> Customers who buy **bread** often also buy **butter**.

By analyzing thousands of transactions, we can automatically discover similar purchasing patterns.

---

# 🎯 Objective of this Script

The Python script performs **Market Basket Analysis** using the **sales transaction dataset** stored in SQL Server.

The goal is to identify **product associations** by calculating:

- **Support**
- **Confidence**
- **Lift**

These metrics help determine how strong the relationship between products is.

---

# ⚙️ Technologies Used

- **Python**
- **Pandas**
- **SQLAlchemy**
- **PyODBC**
- **SQL Server**
- **itertools (combinatorics)**

---

# 🧠 Association Rule Metrics

## Support

Measures how often a product appears in transactions.
Support(A) = Transactions containing A / Total Transactions

Example:

If milk appears in **20% of all purchases**, then:
Support = 0.20

---

## Confidence

Measures how often product **B** is purchased when **A** is purchased.
Confidence(A → B) = Transactions(A ∩ B) / Transactions(A)


Example:

If customers who buy **coffee** also buy **sugar** 40% of the time:
Confidence = 0.40


---

## Lift

Measures the strength of the relationship between two products.
Lift(A → B) = Support(A ∩ B) / (Support(A) × Support(B))


Interpretation:

| Lift Value | Meaning |
|------------|--------|
| > 1 | Positive association |
| = 1 | No relationship |
| < 1 | Negative association |
