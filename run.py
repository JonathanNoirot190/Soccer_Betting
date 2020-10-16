import numpy as np
import scipy.io
import csv
import datetime
import requests
from lxml import html

now = datetime.datetime.now();

now = now.strftime("%Y-%m-%d")

url_bet = 'https://sports.bwin.fr/fr/sports#dateFilter=';
url_bet += str(now);
url_bet += '&sportId=4';

my_params = {'tr': 'tr', 
             'class': 'marketboard-options-row marketboard-options-row--3-way'}


page = requests.get(url_bet).text
doc = html.fromstring(page)
data = doc.cssselect("tr")
print(data.text_content())
             
#response = requests.get(url_bet, params = my_params)
#results = response.json()

#print(results)

# elem = html.findAll('tr', {'class': 'marketboard-options-row marketboard-options-row--3-way'})

