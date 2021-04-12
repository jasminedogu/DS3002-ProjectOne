df <- read.csv("world-happiness-report.csv") #reading in the data
df <- df %>%  #changing column names 
  rename(
    Year = year,
    Ladder = Life.Ladder, 
    GDP = Log.GDP.per.capita, 
    Social = Social.support, 
    Life_Expectancy = Healthy.life.expectancy.at.birth,
    Freedom = Freedom.to.make.life.choices,
    Corruption = Perceptions.of.corruption,
    Positive_Affect = Positive.affect,
    Negative_Affect = Negative.affect
  )
#manipulating dataset by creating a "Continent" Column from Pre-existing "Country" column 
df<- df %>%
  mutate(Continent = countrycode(Country, 'country.name', 'continent')) %>%   
  group_by(Continent)

df <- na.omit(df)  #removing NA's
colnames(df)
#write.csv(df,"~/Documents/data/DS3002-ProjectOne/world-happiness-report-cleaned.csv", row.names=FALSE)
