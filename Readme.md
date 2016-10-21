# Estimation of the percentage of population susceptible

Code estimates the percentage of susceptible people in each Haitian department based on the case data published by the Ministery of Health (MSPP) between October 2010 and September 2016 (Port-au-Prince is considered separate from Ouest and consists of the communes 'Carrefour', 'Cite Soleil','Delmas','Kenscoff','Petion-Ville','Port-au-Prince','Tabarre').

The code could easily be adapted to smaller administrative units if the case data for those units was available.

## Data
Case data has been downloaded from the MSPP website over the years and extracted from the pdfs. The data consists of number of newly reported cases ("cas vus") per day.

## Population
The population per department has been taken from the PAHO website (http://ais.paho.org/phip/viz/ed_haiticoleracases.asp) on 21.10.2016. The source of the data is "Data source: Direction des Statistiques Démographiques et Sociales (DSDS), Institut Haïtien de Statistique et d'Informatique (IHSI), mars 2015 http://www.ihsi.ht/produit_demo_soc.htm"

## Equations

<img src="http://latex.codecogs.com/svg.latex?\frac{dR}{dt}=- (\rho + \mu)R+\gamma I + \frac{(1-\sigma)}{\sigma} \frac{dC}{dt}" border="0"/>

<img src="http://latex.codecogs.com/svg.latex?\frac{dI}{dt}=\frac{dC}{dt} - (\gamma + \mu + \alpha) I" border="0"/>

<img src="http://latex.codecogs.com/svg.latex?S=H-R-I" border="0"/>