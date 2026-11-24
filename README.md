# Olist Customer Experience: Do Late Deliveries Drive Bad Reviews?

Analysis of about 96,000 orders from Olist, a Brazilian e-commerce marketplace. Late delivery turns out to be the main driver of bad reviews, and the problem is concentrated in a few regions.

## Dashboard

[![Olist review dashboard](images/dashboard.png)](https://public.tableau.com/app/profile/chhunheang.chhorn/viz/Olist-Review-Tableau/Main-DB)

[View the interactive dashboard on Tableau Public](https://public.tableau.com/app/profile/chhunheang.chhorn/viz/Olist-Review-Tableau/Main-DB)

## Key findings

1. Late orders get bad reviews 7 times more often. 62.4% of late orders get a 1-2 star review vs 9.2% of on-time orders, and the average score drops from 4.29 to 2.27. The difference is statistically significant (z = 122.8, p < 0.001).
2. Even a small delay hurts. Bad reviews go from about 12% on the estimated day to 32% at 1-3 days late, and about 80% after a week. The gap shows up in every major category (1.75 to 2.25 stars lower across 17 categories), so it is not explained by product mix.
3. Late deliveries are concentrated by region. 6.7% of orders arrive late overall, but MA reaches 17.2% and CE 13.7%. RJ is close to the sellers in São Paulo and still has a 12% late rate, almost triple SP (4.4%). Its delivery times are not long (12 days median), so the estimates there are probably too optimistic.

## Recommendations

1. Set more realistic delivery estimates for RJ and the North and Northeast. Customers judge the order against the promised date, so a better estimate reduces late orders without making shipping faster.
2. Contact customers before an order becomes late. Since reviews already drop at 1-3 days late, at-risk orders should get an update or a small credit before the customer writes a review.
3. Work on retention separately. Only 2.98% of customers place a second order. A late first order lowers this a little (2.51% vs 3.01%, p = 0.026), but almost nobody comes back either way. Office furniture scores low even when it arrives on time (3.77), so its product quality and listings should be checked too.

## Data cleaning

Started with 99,441 orders and kept 95,560 (96.1%). Each removed order has one reason:

| Reason                                         | Orders removed |
| ---------------------------------------------- | -------------: |
| Not delivered                                  |          2,963 |
| No delivery date                               |              8 |
| Outside analysis period (Jan 2017 to Aug 2018) |            267 |
| No review                                      |            643 |
| Total                                          |          3,881 |

Other decisions:

- Some orders have more than one review with different scores, so only the latest review is kept.
- `customer_unique_id` is used for customers, because `customer_id` changes with every order.
- Items, revenue and freight are summed per order before joining, so each order stays one row.

## Tools

- SQL (DuckDB) with JupySQL
- Python: pandas, matplotlib, statsmodels
- Tableau

## Notebooks

- [01_data_quality_checks.ipynb](notebooks/01_data_quality_checks.ipynb): checks the raw tables and sets the cleaning rules
- [02_data_cleaning.ipynb](notebooks/02_data_cleaning.ipynb): builds the clean tables
- [03_eda.ipynb](notebooks/03_eda.ipynb): answers various business questions and exports the Tableau dataset

## How to run it

1. Clone the repo and install the packages:
   ```bash
   git clone https://github.com/harry-chhorn/olist-customer-experience.git
   cd olist-customer-experience
   pip install -r requirements.txt
   ```
2. Download the [Olist dataset from Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce/data) and put the CSV files in `data/raw/`.
3. Build the database:
   ```bash
   python load_data.py
   ```
4. Run the notebooks in order (01, 02, 03). Notebook 03 creates `data/processed/tableau_orders.csv` for Tableau.

Note: DuckDB allows only one connection at a time, so shut down each notebook's kernel before running the next one.

## Data source

[Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce/data), CC BY-NC-SA 4.0.
