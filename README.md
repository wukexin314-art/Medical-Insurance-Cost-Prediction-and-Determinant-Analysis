# Medical Insurance Cost Prediction & Determinant Analysis (R)

This project analyzes **medical insurance charges for 1,338 individuals** to (1) identify the **key drivers** of cost variation and (2) build an **interpretable predictive model** using statistical learning in **R**.

---

## Project Goals

### Prediction
- Build a regression-based model to predict individual medical insurance charges (`charges`).

### Determinant / Driver Analysis
- Quantify which factors are most strongly associated with higher costs.
- Provide interpretable insights that can be communicated to non-technical audiences.

---

## Dataset

The dataset is included in this repository:

- `insurance.csv`

### Variables (common schema)
- `age`: age of the primary beneficiary  
- `sex`: gender  
- `bmi`: body mass index  
- `children`: number of dependents  
- `smoker`: smoking status  
- `region`: residential area  
- `charges`: individual medical costs billed by health insurance (**target**)  

> Note: This dataset is widely used in ML/statistics tutorials and is commonly attributed to the “Insurance” dataset from the book *Machine Learning with R* (with Kaggle mirrors).

---

## Repository Structure

─ insurance.csv # dataset
─ project.R # main analysis + modeling pipeline (R)
─ project.Rproj # RStudio project file
─ report.pdf # final write-up / results summary
─ README.md
─ .RData # workspace snapshot (optional)
─ .Rhistory # local history (optional)

---

## Methods Overview

The analysis workflow in `project.R` follows an end-to-end modeling pipeline:

1. **Data loading & sanity checks**
2. **Exploratory Data Analysis (EDA)**
   - distributions, group comparisons, and relationships with `charges`
3. **Data preprocessing**
   - encoding categorical variables (e.g., `sex`, `smoker`, `region`)
   - handling skewness / transformations when needed
4. **Modeling**
   - interpretable regression models (e.g., linear regression)
   - optional regularization / model selection for stability (if included)
5. **Model evaluation**
   - train/test evaluation and error metrics
6. **Interpretation**
   - effect sizes, significance, and practical takeaways

For full results and figures, see **`report.pdf`**.

---

## Quick Start

### Option A — Run in RStudio (Recommended)

1. Clone the repository:
   ```bash
   git clone https://github.com/wukexin314-art/Medical-Insurance-Cost-Prediction-and-Determinant-Analysis.git
   cd Medical-Insurance-Cost-Prediction-and-Determinant-Analysis
   ```

2. Open project.Rproj in RStudio

3. Run the analysis:
   ```r
   source("project.R")
   ```

---

## Requirements

- R (>= 4.0 recommended)

- RStudio (optional)

Common packages used in this kind of workflow:

- tidyverse, ggplot2, dplyr, readr

- caret / tidymodels

- MASS, glmnet, car, broom

---

## Reproducibility

- Code: project.R

- Final report: report.pdf

- Data: insurance.csv

Suggested extensions:

- add interaction terms (e.g., smoker × bmi)

- log / Box-Cox transformation for charges

- cross-validation and regularization (Ridge/Lasso/Elastic Net)

---

## Notes

- .RData and .Rhistory are included for development convenience, but they are not required to run the analysis.

- For clean reproducibility, running from project.R is recommended.

---

## License

Released for educational and research use.
If you plan to reuse or redistribute, please cite the dataset source and this repository.

---

## Author

Cathie Wu
Repository: Medical-Insurance-Cost-Prediction-and-Determinant-Analysis
