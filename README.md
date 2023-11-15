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

## Authors

Contributors names and contact info

* Emily Velez
* Calvin Chan
* Dorothy He
* Tobi Alagbe




