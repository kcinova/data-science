# SpaceX Falcon 9 First Stage Landing Prediction 🚀

![Status](https://img.shields.io/badge/Status-Completed-brightgreen) ![Python](https://img.shields.io/badge/Python-3.8-blue) ![Jupyter Notebook](https://img.shields.io/badge/Jupyter%20Notebook-99.9%25-orange) ![Pandas](https://img.shields.io/badge/pandas-1.3.2-blue) ![License](https://img.shields.io/badge/License-MIT-yellow) 

This repository contains a project developed as part of the **Applied Data Science Capstone** course by IBM, focusing on predicting the success of SpaceX Falcon 9 rocket's first stage landing.

## Table of Contents
1. [Introduction](#introduction)
2. [About the Course](#about-the-course)
3. [Project Structure](#project-structure)
4. [Data Collection and Preparation](#data-collection-and-preparation)
5. [Exploratory Data Analysis (EDA)](#exploratory-data-analysis-eda)
6. [Model Development](#model-development)
7. [Results and Findings](#results-and-findings)
8. [How to Use](#how-to-use)
9. [License](#license)
10. [Authors](#authors)
11. [Acknowledgements](#acknowledgements)

## Introduction

In this project, we predict whether the first stage of the SpaceX Falcon 9 will successfully land, enabling the estimation of launch costs. This prediction is critical for competing companies seeking to bid against SpaceX for launch contracts.

## About the Course

This project is part of the **Applied Data Science Capstone** course by IBM, which is the final course in the IBM Data Science Professional Certificate. The course provides practical experience in applying data science methodologies and machine learning techniques.

## Project Structure

### Data

- **`dataset_part_1.csv`**: Initial dataset collected.
- **`dataset_part_2.csv`**: Processed and cleaned dataset.
- **`dataset_part_3.csv`**: Final dataset used for machine learning.
- **`my_data1.db`**: SQLite database for data storage and manipulation.
- **`spacex_web_scraped.csv`**: Data obtained via web scraping.

### Notebooks

- **`1-spacex-data-collection-api.ipynb`**: Data collection via API.
- **`2-spacex-webscraping.ipynb`**: Data scraping from web sources.
- **`3-spacex-data-wrangling.ipynb`**: Data cleaning and wrangling processes.
- **`4-spacex-eda-sql-sqlite.ipynb`**: EDA using SQL and SQLite.
- **`5-spacex-eda-dataviz.ipynb`**: Data visualization and exploration.
- **`6-spacex-machine-learning-prediction.jupyterlite.ipynb`**: Machine learning model development and evaluation.

## Data Collection and Preparation

We collected data using RESTful APIs and web scraping. The data was cleaned and processed, resulting in multiple datasets stored in CSV files and a SQLite database for efficient querying and manipulation.

- [Collecting the Data via API](https://github.com/kcinova/data-science/blob/main/spaceX-landing-prediction-capstone/code/1-spacex-data-collection-api.ipynb)
- [Collecting the Data via Web Scraping](https://github.com/kcinova/data-science/blob/main/spaceX-landing-prediction-capstone/code/2-spacex-webscraping.ipynb)
- [Data Wrangling](https://github.com/kcinova/data-science/blob/main/spaceX-landing-prediction-capstone/code/3-spacex-data-wrangling.ipynb)

## Exploratory Data Analysis (EDA)

Performed extensive EDA using SQL and various visualization tools. Insights were gathered about the launch outcomes, launch sites, and other key features.

## Model Development

We developed and compared several machine learning models, including:

- **Logistic Regression**
- **Support Vector Machine (SVM)**
- **Decision Tree**
- **K-Nearest Neighbors (KNN)**

## Results and Findings

The evaluation metrics for the models included accuracy, precision, recall, and F1 score. The best model based on the evaluation metrics was identified. SVM, and KNN showed similar performance metrics.

### Best Model: **Logistic Regression**
- **Accuracy**: 0.8333
- **Precision**: 0.8000
- **Recall**: 1.0000
- **F1 Score**: 0.8889

## Model Performance Comparison

For an interactive comparison of model performance, [click here](https://github.com/kcinova/data-science/raw/main/spaceX-landing-prediction-capstone/model_performance_comparison.html).

![Model Performance](https://github.com/kcinova/data-science/raw/main/spaceX-landing-prediction-capstone/model_performance_comparison.png)

## How to Use

1. **Clone the Repository:**

    ```bash
    git clone https://github.com/kcinova/data-science
    cd data-science/spaceX-landing-prediction-capstone
    ```

2. **Setup the Environment:**
   Ensure you have the required dependencies installed. You can create a virtual environment and install the dependencies using:

    ```bash
    pip install -r requirements.txt
    ```

3. **Explore the Notebooks:**
   The project is organized into Jupyter notebooks that guide you through different aspects of the project:
   - Start with `1-spacex-data-collection-api.ipynb` for data collection.
   - Follow through the subsequent notebooks for data wrangling, EDA, and model development.

4. **Run the Notebooks:**
   You can run the notebooks using Jupyter Notebook or JupyterLab. Navigate to the directory and start Jupyter:

    ```bash
    jupyter notebook
    ```

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/kcinova/data-science/blob/main/spaceX-landing-prediction-capstone/LICENSE) file for details.

## Authors

[Kristina Cinova](https://www.linkedin.com/in/kristinacinova/)

## Acknowledgements

- © Copyright IBM Corporation
- This project was completed as part of the Applied Data Science Capstone by IBM on Coursera.
- The project is a practical application of data science methodologies taught in the IBM Data Science Professional Certificate program.
- Special thanks to the Coursera.
