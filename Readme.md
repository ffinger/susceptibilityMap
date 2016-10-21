# Estimation of the percentage of population susceptible

Code estimates the percentage of susceptible people in each Haitian department based on the case data published by the Ministry of Health (MSPP) between October 2010 and September 2016 (Port-au-Prince is considered separate from Ouest and consists of the communes 'Carrefour', 'Cite Soleil','Delmas','Kenscoff','Petion-Ville','Port-au-Prince','Tabarre').

The code could easily be adapted to smaller administrative units if the case data for those units was available.

## Data
Case data has been downloaded from the MSPP website over the years and extracted from the pdf files. The data consists of number of newly reported cases ("cas vus") per day.

## Population
The population per department has been taken from the PAHO website (http://ais.paho.org/phip/viz/ed_haiticoleracases.asp) on 21.10.2016. The source of the data is "Data source: Direction des Statistiques Démographiques et Sociales (DSDS), Institut Haïtien de Statistique et d'Informatique (IHSI), mars 2015 http://www.ihsi.ht/produit_demo_soc.htm"

## Equations

The set of equations have been modified from [Bertuzzo et al (2014)](http://link.springer.com/article/10.1007/s00477-014-0906-3). It is assumed that the reported cases in every department correspond to the newly infected <img src="http://latex.codecogs.com/svg.latex?\frac{dC}{dt}" border="0"/>. The system of equation can thus be reduced to one for the number of infected and one for the number of recovered, the number of susceptibles can be computed using the estimates of the total population:

<img src="http://latex.codecogs.com/svg.latex?\frac{dR}{dt}=-(\rho+\mu)R+\gamma\,I+\frac{(1-\sigma)}{\sigma}\frac{dC}{dt}" border="0"/>

<img src="http://latex.codecogs.com/svg.latex?\frac{dI}{dt}=\frac{dC}{dt}-(\gamma+\mu+\alpha)\,I" border="0"/>

<img src="http://latex.codecogs.com/svg.latex?S=H-R-I" border="0"/>

Parameters <img src="http://latex.codecogs.com/svg.latex?\gamma" border="0"/>, <img src="http://latex.codecogs.com/svg.latex?\mu" border="0"/> and <img src="http://latex.codecogs.com/svg.latex?\alpha" border="0"/> have been taken from the same study.

The average duration of acquired immunity <img src="http://latex.codecogs.com/svg.latex?1/\rho" border="0"/> and the proportion of infections leading to symptoms <img src="http://latex.codecogs.com/svg.latex?\sigma" border="0"/> are unknown and have to be explored. **It is assumed that asymptomatically infected have the same immunity duration as symptomatically infected**.

## Exploration of the number of susceptibles at the end of September 2016 (before hurricane Matthew hit Haiti)

The matlab code run.m explores the number of susceptibles at the end of September 2016 (last data point by MSSP on 25.09.2016) depending on the mean duration of acquired immunity and the proportion of symptomatic infections.

![alt text](result.png)

The figure above shows the estimated proportion of susceptibles in each department (and Port-au-Prince) on the 25th September 2016 depending on the mean duration of acquired immunity (x-direction, in years) and the proportion of symptomatic (and thus reported) infections (y-direction). According to this estimate, significant proportions of immune people can only be present in certain areas of Haiti if the mean duration of immunity is quite high and if the proportion of symptomatically infected is low (e.g. many non-reported asymptomatic cases present who still acquired immunity). **Note that for those estimates a key assumption is that the average immunity duration for asymptomatics is as long as for symptomatics**.