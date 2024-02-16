
# Letterboxd Movie Review Project

In-depth analysis of Letterboxd movie review data as part of the final project for the Data Analytics course at BrainStation.

## Description

The objective of this project is to assist movie industry professionals, content creators, and platform administrators in understanding user sentiment, engagement, and trends. By performing analysis through various perspectives, we can help inform the decision-making process and increase the quality and success of movies on the platform. 

This project utilizes movie review data from Letterboxd and is obtained through [Kaggle](https://www.kaggle.com/datasets/joyshil0599/movie-reviews-dataset-10k-scraped-data). 

Having cleaned the `letterboxd-reviews.csv` file using Excel and MySQL, we performed a sentiment analysis using a Lexicon-based approach NLP technique in Python through the NLTK Vader sentiment analyzer ([https://github.com/cjhutto/vaderSentiment](https://github.com/cjhutto/vaderSentiment)). With the sentiment scores we performed an engagement analysis, time analysis, and genre analysis in order to understand user engagements on the platform over the years. 

## Requirements

* MySQL
* Python 3.9.7
* NLTK package for Python ([http://nltk.org/](http://nltk.org/))

## Executing program

* Use the following command in Jupyter Notebook to download the NLTK package before running the cells in the notebook provided.
```
pip install nltk
```
## What we did

We covered 4 different forms of analysis on a Movie Reviews dataset from the popular movie review platform Letterboxd. These were the 4 areas covered:
1. Sentiment Analysis
2. Engagement Analysis
3. Time Analysis
4. Genre Analysis

# Sentiment and Genre Analysis

### Analyzing sentiment across different genres and years
- 2022 had the highest number of reviews in our dataset, indicating a potential surge in user activity
- Drama has the highest number of reviews overall
- In 2022, the horror genre stands out with the most positive sentiment scores

<div align="center">
    <img width="615" alt="Screenshot 2024-02-16 at 10 44 20 AM" src="https://github.com/emilyvelez/LetterboxdProject/assets/132703304/96d235fc-e419-41fd-92a0-468880541f91">
</div>

### Sentiment Distribution

- Extreme sentiment scores (coloured) are  associated with more comments (numbered)
- Drama is viewed as the most negative in 2022 and horror is the most positive
- Action and sci-fi generally have positive reviews and draws comments 

<div align="center">
<img width="668" alt="Screenshot 2024-02-16 at 10 47 26 AM" src="https://github.com/emilyvelez/LetterboxdProject/assets/132703304/0d77a64d-347d-4008-b66e-dec0589f2d58">
</div>

# Engagement Analysis

### Sentiment Impact on Engagement
<div align="center">
  <img width="453" alt="Screenshot 2024-02-16 at 10 49 28 AM" src="https://github.com/emilyvelez/LetterboxdProject/assets/132703304/2a868b1e-4d34-46c5-bcbe-949023f39517">
</div>

### Movie Recency Impact On Engagement
  <div align = "center">
  <img width="489" alt="Screenshot 2024-02-16 at 10 51 09 AM" src="https://github.com/emilyvelez/LetterboxdProject/assets/132703304/29519edd-3d3b-44af-bae5-dd6b4508005b">
  </div>

# Time Analysis

### Overview
- The Romance genre has the highest amount of positive sentiments.
- Drama is the movie with reviews that have the highest engagement.
<div align = "center">
<img width="728" alt="Screenshot 2024-02-16 at 10 55 00 AM" src="https://github.com/emilyvelez/LetterboxdProject/assets/132703304/66bad09a-b99e-421e-936b-86c76c59d7c4">
</div>

## Authors
Contributors names and contact info

* Emily Velez
* Calvin Chan
* Dorothy He
* Tobi Alagbe




