### -- Introduction and refreshers for R
### -- By - Matt Boone (2015) & Auriel Fournier (2015)
### -- Modified by Auriel Fournier for 2016 NAOC Workshop


### -- https://github.com/aurielfournier/AOSSCO17  

#######################################
### -- Necessary packages
#######################################

library(gapminder)
library(dplyr)
library(tidyr)
library(ggplot2)

###################
### -- Loading In The Data
####################

data(gapminder)
head(gapminder)   

# Explain What Pipes are %>% 

# Explain the verbs of dplyr

#########################
### -- Filtering
#########################

gdat <- gapminder %>%
        filter(continent=='Europe',
               year==1987)

a = 100
a <- 100

gapminder %>%
  filter(continent=='Europe',
         year==1987) %>% 
        select(country,lifeExp,gdpPercap)

# the "|" means 'or' in R
gapminder %>%
      filter(continent=="Europe"|continent=="Asia") %>%
      # comments here 
      distinct(continent)

# the "&" means "and" in R
gapminder %>%
          filter(year>=1987&year<=2002) %>% distinct(year)

#########################
### -- Match %in%   
#########################

sub_countries <- c("Afghanistan","Australia", "Zambia")


gapminder %>%
          filter(country %in% sub_countries) %>% distinct(country)

gdat <- gapminder %>%
  filter(country %in% sub_countries)

distinct(gdat, country)


#########################
### -- GROUPING
#########################

gapminder %>%
  group_by(continent) %>%
  summarize(nova = mean(lifeExp),
            median = median(lifeExp))


gdat <- gapminder %>% 
  group_by(continent, year) %>%
  summarize(mean=mean(lifeExp))

#########################################
### -- CHALLENGE
#########################################

# What is the median life expenctancy 
# and population for each country in Asia 

new_data <- gapminder %>% 
  filter(continent == "Asia") %>% #distinct(continent)
  group_by(country) %>%
  summarise(medianL = median(lifeExp),
            medianP = median(pop),
            count = n())


#note to self talk about Kiwi vs Us spelling
# note to self talk about n()
#########################
## MUTATE
#########################

colors <- c("red","green")

(mgap <- gapminder %>%  
  mutate(country_continent = paste0(country,"_",continent),
         gdp = gdpPercap/pop,
         favorite_color = 'green',
         yearfactor = factor(year)) %>%
   select(year, country_continent, gdp, favorite_color, yearfactor))

# or

gapminder %>%
  mutate(example = ifelse(country == "Afghanistan","Yes","No"),
         n1980s = ifelse(year>=1980&year<=1989,"Yes","No")) %>%
  select(example, n1980s)

########################
## Separate
########################

mgap %>% 
  separate(country_continent, 
           sep="_", 
           into=c("country",
                  "continent"),
           remove=FALSE) 

# or

mgap %>% 
  separate(year, sep=c(-4,-3), 
           into=c("century","y1","y2")) %>%
  mutate(century=as.numeric(century),
         year = as.numeric(y1))

########################
## Joins
########################

# for no reason other than the awesomeness of star wars (bc a bird conference isn't nerdy enough) 
# we are going to join our data set with another dataset 
# indicating whether or not the original star wars had been released yet in that year

star_wars_dat <- data.frame(year=c(unique(gapminder$year)[2:10],2012), 
                            star_wars_released=c("No","No","No","No","YES","YES","YES","YES","YES","YES"))

# you will notice this does not include 1952, 2002 and 2007
full_join(gapminder, star_wars_dat, by="year") %>% distinct(year)

# we have everything, and NAs are inserted for years where things don't exist

right_join(gapminder, star_wars_dat, by="year") %>% distinct(year)

# notice taht 1952, 2002, 2007 are missing, bc they don't exist in new_dat

left_join(gapminder, star_wars_dat, by="year") %>% distinct(year)

# notice that 2012 is missing, bc it doesn't exist in gapminder

inner_join(gapminder, star_wars_dat, by="year") %>% distinct(year)

# only things that are in common


g1 <- gapminder %>% select(country, year)

g2 <- gapminder %>% select(lifeExp, continent)


gg <- cbind(g1, g2)
gg <- bind_cols(g1, g2)

rbind()
bind_rows()


#####################################
## CHALLENGE
#####################################

# Calculate the average life expectancy in 2002 
# of 2 randomly selected countries for each continent. 
# Then arrange the continent names in reverse order. \
# Hint: Use the dplyr functions arrange() and sample_n(), 
# they have similar syntax to other dplyr functions.
# ?arrange ?sample_n for help

gapminder %>%
  filter(year==2002) %>%
  group_by(continent) %>%
  sample_n(2) %>%
  #assign("countries_selected",.) %>%
  group_by(country, continent) %>%
  summarize(mean=mean(lifeExp)) %>%
  arrange(., desc(continent))

part1 <- gapminder %>%
  filter(year==2002) %>%
  group_by(continent) %>%
  sample_n(2)

part2 <- part1 %>% summarize(mean=mean(lifeExp)) %>%
  arrange(., desc(continent))

########################
## Dates and Times
########################

#########dates and times#############################

# We're first going to need to tackle dates. R can handle dates, and it can be quite powerful, but a bit annoying.
# The base functions for this are as.Date, as.POSIXct, as.POSIXlt
# The syntax for these is essentially the same, feed it a date, and tell it the format

Sys.time()

## Good Resource on what letters = what in format
# https://stat.ethz.ch/R-manual/R-devel/library/base/html/strptime.html

(dt<-as.Date(Sys.time(),format='%Y-%m-%d'))
(ct<-as.POSIXct(Sys.time(),format='%Y-%m-%d %H%M%D'))
(lt<-as.POSIXlt(Sys.time(),format='%Y-%m-%d %H%M%D'))

# whats great is we can now do math on time

dt-10   ##since day is the lowest measurement it counts in days
ct-10   ##however counts in seconds
lt-10   ##does the same thing

# as.POSIXlt is really useful because it allows you to call particular pieces of the time out
lt$yday   ##julian date
lt$hour   ##hour
lt$year   ##what.....time since 1900???
lt$year+1900  ##converts you to standard time

##these are particularly useful because you can do math on time
earlytime<-as.POSIXct('2015-03-23',format='%Y-%m-%d')

times <- c(0,31)

round(lt$sec,1) %>% filter(match %in% times)


ct - earlytime 

##as well as logical statements
ct > earlytime
ct == earlytime

######################
## GREPL
####################
grepl('Af',gapminder$country) # returns TRUE and FALSEs, which we can feed into filter()

gapminder %>%
    filter(grepl("Af", country)) %>% summary()

gapminder %>%
  filter(grepl('^Af',country)) %>% summary()

#####################################
## CHALLENGE
#####################################

## Median and Mean Life Exp for all Countiries that being with "Ma" for the years 1990-1997 