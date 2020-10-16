import numpy as np
import scipy.io
import csv

# Create the data set for L1 matchs
files = ['F1', 'F1-2016', 'F1-2015']


game = []
match = []
result = []
prediction = []
cotes = []

ids = []
attributs = ['HomeTeam', 'AwayTeam', 'FTR', 'BWH', 'BWD', 'BWA']
for f in files:
	matchs = []
	with open(f + '.csv', 'r') as csvfile:
		matchData = csv.reader(csvfile, delimiter=' ', quotechar='|')
		for row in matchData:

			match = row[0].split(',')
			matchs.append(match)

	ids = [matchs[0].index(attributs[i]) for i in range(len(attributs))]
	n = len(matchs)

	for i in range(1, n):

		game.append(matchs[i][ids[0]] + ' vs ' + matchs[i][ids[1]])
		win = 0 if matchs[i][ids[2]] == 'H' else 2 if matchs[i][ids[2]] == 'A' else 1
		result.append(win)
		cote = [float(matchs[i][ids[3]]), float(matchs[i][ids[4]]), float(matchs[i][ids[5]]) ]
		cotes.append(cote)
		prediction.append(1 if np.argmin(cote) == win else 0)




scipy.io.savemat('bwin.mat', mdict={'game': game, 'result': result, 'prediction': prediction, 'cotes': cotes})
