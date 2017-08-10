#################################################################################
##          The Power of Automation  and Programming                           ##
#################################################################################
##  by - Matt Boone (2015) modified by Auriel Fournier (2016)                  ##
library (dplyr)
library (ggplot2)
library (tidyr)

### -- https://github.com/aurielfournier/AOSSCO17

# ##############################################################################
# Were now moving onto the real interesting stuff.
# I used to tell everyone that i could make R brush its teeth.
# Most people would look at me funny, because its largely non-sensical
# But the point was, that I can make R do anything I want. I could probably figure
# Out a way to have it brush its teeth if I tried hard enough
# 
# R is a programming language thats built to handle statistical analysis effeciently. 
# However, it is not very different from python or bash/bin, because it has its roots
# in the same thing. It, like, every programming language speaks similarly, and is built
# on the same fundamentals that were established years ago.
# 
# But why would you want to use it like a programming language?
# -time
# -flexibility
# -no other option
# 
# Ill show you how I use R
# 
# Weather Radar
# SD card reader
# Ebird
# 
# Structure of the afternoon
# This might differ a bit from the first part of the course. Im going to teach
# some fundamentals of programming and how R handles them. Individually, it can be difficult
# to show how these pieces work and so well use some examples that dont reflect the
# "right" way to accomplish these tasks. But they point of them is to teach you
# each piece and itll make more sense when we put it all together at the end

#################################################################################
#################################################################################
##                     IF statements and FOR LOOPS                             ##
#################################################################################
##Control Function: an operation that controls the recording 
##processing, or transmission of data


##If statements, take logical statments and then decide what to do based on logic. 
# Whether its true or false 
# for instance if I was a robot and I was hungry and I wanted to do something about it I would write. 
IF I am Hungry I will Eat
# Tell my self if some condition exists to do something, and if it doesnt exist dont do that thing
#CONTROL
#ROUTING -it's a flagger on a road or a stop light


# Every language approaches this slightly differnetly. IN R's case it uses the if() function. Where we tell if IF something is TRUE then do something.
# In the R case, it evaluates whats inside the parenthesis then it does what you tell it to do
# So in a theoretical case:
if()
IF(ME=='Hungry') {eat()
  run()
  sleep()
  
  
  
  }


# telling R if i'm hungry, run the eat function. Now that's a nonsense function obviously.
# An important note is If it isnt true then it does nothing. Atleast as of now
#Lets move into a more realistic scenario.
# Say we have an object P, and i want to know if P is a large number (large than 100) or a small number (less than 100)
P<-500
P
if(P>100){print("That is a large number")}  ## so if P is greater than 100 it will print the phrase, that is a large number
if(P<=100){print("That is a small number")}   ##if P is less than or equal to 100 it will print, that is a small number

#mention T/F

#Lets give P a value of 50
P<-50
#Now lets give it a bigger number
P<-10000

##Say we want to figure out if a random number is greater than or less than 5
tt<-sample.int(10,1)
tt   #is our random number

# we can also tell it to do something if the statement IS NOT true, by then telling it 'else' and giving it
# a set of things to do if the statement was not true
if(tt>5){
  print('number is greater than 5') }else {
    print('number is less than 5')
    }

#important to put brackets

#If else is a 'wrapper' function meaning it automatically loops through the values given to you. while its overkill it also puts it nicely into a single function
ifelse(tt>5,'number is greater than 5',"number is less than 5")
ifelse(1:10,'number is greater than 5', 'number is less than 5')
#It's a wrapper function meaning it will do this
1:10
ifelse(1:10>5, 'number is greater than 5', 'number is less than 5')
# so this will tell us IF our random number is greater than 5, tell us, if not (or if else) tell us the number is less than 5

##These if statements can get complicated quickly. Say we want to add in what happens if the number does equal 5
if(tt>5){print('number is greater than 5')} else {
  
  if(tt<5){print('number is less than 5')} else {
    print('number is 5')
    } # this is the second else
  } #this is the first ifelse

#At the end of the day, this is logic, right. Telling R exactly what to do and when to do. And with it we control R
# I generally try not to put these in the ifelse wrapper


##pros of if statements: 
# Can define exactly when to do something and when not to (control a situation), logical (by definition)
##cons of if statements: 
# usually incorrectly used in R, make complicated statements

##IF STATEMENTS ARE BEST USED IN FOR LOOPS OR TO CHECK INPUTS. Controlling a situation

#When is this useful?
# I use this to control what happens when certain inputs are possible and we need to do something different for each situation, or if there is something that will make it fail.
# For instance lets say if we subset a data set and it ends up with zero rows. We dont want our script to fail
setwd('C:/Users/amf698/Documents/AOSSCO17/')
ebird<-read.csv('ebird_data.csv')

#Lets say we are running through different ebird data sets and want to pull out resident seabird species. Which are rare in most regions but exist in some places, like the west coast.
sub.ebird<-subset(ebird, pelagic==1 & perennial==1)
sub.ebird <- ebird %>% filter(pelagic==1, perennial==1)
#This results in zero rows, you can tell R how to handle this situation. In a couple of ways
nrow(sub.ebird)
if(nrow(sub.ebird)>0){ Tell it what to do }
if(nrow(sub.ebird)==0){print('Data has zero rows'); stop }
if(nrow(sub.ebird)==0){print('Data has zero rows, skipping');next}

####### Example time
# Lets now try a practice example. 
# Lets say we want to write a code that gives us average presence no matter what we subset our data by. But from previous analysis we know that taking a mean presence is not very robust when we only have an N<=30. When it's under an N of 30 we're more interested in the median value. I do not want it to analyze data that has an N<3
# Bonus if you can have the code tell us what analysis it used and the N of the value.
# Some useful functions may be: nrow(), mean(), median(), paste0(), print()
#sub.data<-subset(data, migrant==1 & shorebird==1)
sub.ebird<-ebird %>% filter(pelagic==1 , perennial==1)

if(nrow(sub.ebird)>3){
  
  if(nrow(sub.ebird)>30){print('I took the mean');print(mean(sub.ebird$presence))}
  if(nrow(sub.ebird)<=30){print('The median is:' )
    print(median(sub.ebird$presence))}
  
}
if(nrow(sub.ebird)>=3){}


#What you might be thinking right now, is that IF examples might be used rarely, particularly because in single example situations like this you wont be changing your inputs and if you did you'll know what the row lengths are, or can control if something doesnt exist in a data set.
# Thats where for loops come in, IF statements come in to play a lot more readily when you have no idea what the input might be

#############################################################
##                      for loops                          ##
#############################################################
##an iterative process that loops through a sequence

for(radar in c('KDOX','KDIX','KBUF')){ 
  
  print(radar) 
  
}   ###what did this do?
i<-1
print(i)
i<-2
print(i)
i<-3
print(i)
# it wrapped through all values between 1 and 10...
for(i in 1:10){
  #stores the value as the variable i (or any variable name we told it to)
  i<-1
  #and then runs EVERYTYHING between the brackets with the variable as that value
  print(i) 
}

i<-2
print(i)

# it then does this for the 1st value, then the 2nd, and so on until all values have been looped through the entire sequence of whatever it is we give to it

# because all its doing is storing the value as the variable (again it can be named anything)
#we can treat it like a normal variable

for(i in 1:10){
  
  print(i+1)
  
}  ## in this case we want to add 1 to that value. So it took 1 and added 1 (equals 2), then took the next value (2) and added 1 (equals 3) so on and so on.

#####
# We can do this for characters, it doesnt matter. It does a simple thing but this simple thing makes endless complexities
for(i in c('Matt','Auriel')){
  print(i)
}

for(i in c('Matt','Auriel','Liz')){
  if(i=='Matt'){print('Matt is awesome')}
  if(i=="Auriel"){print('Auriel is not')}
}

## for loops are useful for refering to rows or columns in a data set if we just feed it sequential numbers
data<-matrix(1:100,nrow=10,ncol=10)
data

for(i in 1:10){
  print(data[i,2])
}    ### is going to loop through all the rows in column 1 (and print that value)

for(i in 1:10){
  print(data[1,i])
}    ###loops through all the rows in column 2 (and prints that value)

for(i in 1:10){
  print(data[i,1]+5)
}   ###loops through all the rows in column 1 and adds 5 to that value

data[,1] <- 100

for(i in 1:9){
  data[i,2]<-data[i,1]+15
  }   ###does the same thing but stores the value in the correct row in column 2

data

data[,2]<- data[,1]+15  ###is the best way to do this particular task

data * data
#At this point you may be asking, well this is extremely useful or but wait Matt, that's not how you do that. 
# You're correct, for loops are one of the bases of all of programming. But, R has already written many of its functions with internal for loops, but in the C++ code, not in the R code.
#many functions can be vectorized, meaning r automatically loops things together
paste0('hd',1:10)   ### automatically adds the numbers 1 through 10 onto the word 'hd'
#All this is doing is basically this, but more effeciently:
for(i in 1:10){
  print(paste0('hd',i))
}

#I use the term vectorizing for refering to the concept that R functions have already written iterative proccesses in the function

#Trouble shooting for loops. For loops can be difficult to troubleshoot when they hit a snag so I wanted to give you a couple of tips on troubleshooting them.

#1. Put in a line at the top that allows you to read in a dummy variable

for(i in 1:10){
  #i<-2
  data[,5+i] 
}
i
#2. Print the outputs, or save middle outputs
for(i in c(1,2,NA,4)){
  print(i)
  sub.data<-i+1
  print("heres the middle data set")
  print(sub.data)
  print('now printing mean')
  mean(sub.data)
}

#3. Write the for loop last

for( i in 1:10) { 
#i<-1
d<-mean(i)+2
print(paste0('the answer is: ', d))

}

ebird$Family<-NA
ebird$family[ebird$group=='Ducks']<-'Anatidae'

ebird %>%
    mutate(Family = ifelse(group=="Ducks","Anatidae",NA))
##############################
# Summary of if and for loops
#####################################################################

##-'for' loops are best to do tasks that can not be vectorized or when memory is an issue
##- 'for' loops are ideal for looping through files or starter values
##-'If' statements should only be used if vectorizing was not an option
##-If you have to make more than one 'if' statement you can probably vectorize it
##-Neither is ideal for math, since R is very good at doing this
##-Exceptions are when a function can not be vectorized or when referencing previous values
##-Also for lowering memory usage 
#(If your files exceed 1.5gb looping or other packages may be requried)

###############################
# Task
#Here is a set of values. I want you to write a for loop that converts these to Farenheit 
# and then prints out whether this value is cold depending on if the resulting value is less 
# than 50 degrees farenheit. 
# this is because Matt, who wrote this, is from Texas, and hates cold
# The function for this conversion is 
# C*(9/5) +32
# use : for, if, print, and paste0
# https://github.com/aurielfournier/naoc_2016_r_workshop
length()
length(c(1,10))
values<-c(30,25,6)
values<-sample(1:40,10)


for(i in values){  d<-i*9/5 +32
ifelse(d<50,print(paste0(d,' degrees is cold')),print(d))
}

for(i in 1:length(values)){
  C = values[i]
  d <- C*9/5+32
  ifelse(d<50, print(paste0(d, ' degrees is cold')), print(paste0(d,' degress is perfect')))
}


values
for(i in values){
#i<-30  
  f<-i*9/5 +32
  #f
  if(f<50){print(paste0(f,' degrees is cold'))} else{print(paste0(f,' degrees is perfect'))}
  
}


######################################################################
# Programming
#R is a language. This is what makes it different than a program like spss. It is
# similar to sas in that it is it's own language you can write it to run statistics
# and perform other tasks
# It has a base in C++ that you can write complex programs in
# but it is optimized for analyzing data
# R can do many surprising things, but it should be noted that R doesn't do them 
# all optimally. There is a point when it is best to start learning other languages
# like C in order to do the more complex things. But you likely won't get ot this point!
#
# A quick aside on functions
# We're going to move into the territory where we start using loops and writing programs
# R's strength is in it's function interface, where we write functions, and then can
# easily run a long piece of code that's wrapped in a function
# Writing a piece of code and a function are nearly identical in thought, but are set
# up a little different. Just know every thing we write in long form can be 
# written as a function easily by just placing our variables in between the 
# function() parenthesis
#

temp_fun <- function(temp_values, trim){ 
  for(i in temp_values){
    d<-(i*9/5 +32 ) * trim
    if(d<=50) { print(paste0(d,' degrees is cold')) }
    if(d>50) { print(paste0(d," degrees is hot")) }
  } 
}

temp_fun(30,trim=.7)
# which can be simplified further
temp_fun<-function(temp_values){
  d<-temp_values*9/5 + 32
  ifelse(d<50, paste0(d, ' is cold'),paste0(d,' is hot'))  
}

#this runs our for loop for whatever vector of values you want
temp_fun(1)
temp_fun(c(1:50))
temp_fun("green")  # heres the problem when you're writing functions you need to be able to handle all possible values other wise you give the user a meaningless error
#################################################################################
# Rules for Programming
# programming itself is a term in that class to writing reproducible, flexible, and scalable code
# that requires minimal input, and a consistent output.
# What this means is everytime you run the program it has the same output, no matter
# the input, and in some respects no matter the format of the input.
#
# Rules for Writing reproducible, flexible, and scalable code
# 1. Do not hard code. Refering to columns by number, entering dynamic names as static.
#    Hard coding refers to something that is only relevant to the specific run.
#    To do this we have to start thinking about how we can refer to a column, name or 
#    Object in a way that never changes.
# For example always ref to column names exactly, not as numbers. This is simple and obvious
# but may require that we clean our data so that our column names are what we think they are
# an easy example is always running tolower(), as often capitalization can get mixed up
# This also goes for row names. 

head(data)
colnames(data)
str(data)

data[,15]
data$X1.1

data[7,2]
data[data$species=='American Crow',]
data %>% filter(species=="American Crow")

# one reason for this is that columns are out of order, or when you merge data sets
# and column numbers change, or you simply add more data. It's safer just to refer to it in this manner.
# If you need to do math on column numbers you can still do that with which() and grepl

which(data$species=='American Crow')   ##gives us the row just before Pontiac Firebird
data$species=='American Crow'

grepl('American',data$species)
data$species[grepl('American',data$species)]

data(msleep)
head(msleep)
#Task.
#lets try a complex example. here is an eBird data file I've compiled for the state of new jersey
# (it's called Ebird_DE.csv) it is in wide form, it has species names, taxa name, a variety of
# binary categories, and then presence numbers for each week, the weeks are labeled x1.1-x12.4
# How do we refer to the specific prevalance in a reproducible way? And not all these other columns.
# We have to do it in a scalable way just incase I want to add more columns. Which I clearly have done before
# 
# Lets make it complicated, say I want to calculate the mean presence each week only for breeding passerines 
# (breeder==1 and passerine==1)
# You can do it how ever you want, but as a hint, you might find some or all of these functions useful:
# which(), colnames(), grepl(). 
# Bonus points if you can figure out how to do it dplyr instead of base R

dat <- read.csv('https://raw.githubusercontent.com/aurielfournier/AOSSCO17/master/ebird_data.csv')

dat %>% head

dat[dat$breeder==1 & dat$passerine==1,grepl('^X',colnames(dat))]

result <- dat %>% 
  filter(breeder==1,passerine==1) %>%
  select(group,contains('X')) %>%
  gather("quarter_month","value",-group)
ggplot(data=result, aes(x=quarter_month, y=value)) + 
  geom_point()+facet_wrap(~group)


# 2. Make a dynamic and static variable list at the header of a code. This is essentially what
# we input in a function()

# 3. keep all your files in an organized order, and come up with a standard file system.
#    Write up a protocol for yourself, your lab, your company, and try to get people
#    to stick to it. We're going to start refering to changing file paths, and this
#    is imperative to making programs work everytime.

# Paste() is one of the most powerful tools for moving your experience from beginner to expert,
# and in particular refering to file paths on your computer based on the naming strucutre
#remember paste automatically adds a space between your two objects
paste('hello','world','im','hungry')   
#paste0 does not
paste0('hello','world')
#so we have to tell it what we want between each object
paste0('hello',' ','world')  # if you notice we told it to put a space (' ') between Hello and World
for(state in c('TX','NJ')){
print(paste0('ebird_',state,'.csv'))
}
# say we want  to have a program that you give its name, and it tells you hello
name<-c('Matt',"Auriel")
paste0('hello, ',name,' how are you?')

##we can write this as a function easily as well
foo<-function(name){
  paste0('hello, ',name,' how are you')
}

foo(name='matt')
# that was a tangent, lets move forward

## lets read in file names
folder<-'Monstersinc'
file<-'scaretotal_MikeW_March.csv'
setwd('C:/Users/amf698/Documents/AOSSCO17/Monstersinc')
read.csv(file)
paste0(folder,'/',file)   # so its going to look in what ever folder we told it (Monstersinc in this case)
# and then its going to look for the file we tell it (in this case scaretotal_MikeW_March.csv)
read.csv(paste0(folder,'/',file))

# and we can get it to read in any file in that folder by changing the value of file

#This seems a bit silly now, but when we start adding looped variables it's going
# be a lot easier

# Here is a list of files with similar structure but different folders and
# file beginning names. Write a program that loads a files depending on the month and name
#file1: scaretotal_MikeW_March.csv
#file2: scaretotal_JamesS_March.csv
#file3: scaretotal_MikeW_April.csv
#file4  scaretotal_JamesS_April.csv

name<-'JamesS'
month<-'April'

####read in this file
data<-read.csv(paste0('scaretotal_',name,'_',month,'.csv'))

# 4. Keep your brackets in order, and label them if necessary
##Lets do the same, but now lets write a loop function that loads all
# possible values. We'll use two for loops


#task4. I want you to write a function or a for loop that reads in all of the files
# for MikeW and stores them in a list()


month<-c('March','April')

##variables#####
our.list<-list()

for(mon in month){
  #mon<-'April'
  our.list[[paste0('MikeW_',mon)]]<-read.csv(paste0('scaretotal_MikeW','_',mon,'.csv'))
} 

#############
files<-list.files()
our.list<-list()
for(i in files){
  our.list[[i]]<-read.csv(i)
}

list.files()
strsplit('_', files)

##now lets put it all together, lets make it so reads in all the files for both Mike and James for
# both the months of March and April
name<-c('MikeW','JamesS')
month<-c('March','April')
####code#########
for(i in name){
  
  for(p in month){
    
    our.list[[paste0(i,'_',p)]]<-read.csv(paste0(folder,'/','scaretotal_',i,'_',p,'.csv'))
    
  }  ##end p loop
  
}   ###end i loop


# notice how not only are the end brackets labeled 
# but we're keeping the loops indented appropriately to show that one is nested inside of the other
# this is not _required_ by R, but it does make things easier. 

#### How to look over files with list.files()
our.files <- list()

files <- list.files(pattern="MikeW")

for(i in files){
  our.files[[i]] <- read.csv(paste0("Monstersinc/",i))
}




# 5. Start simple, and build to more complex. Don't think about the big picture
# think about the individual steps. If you can do each individual step, then you
# can put them together. Write it out without a for loop before you start writing one.
# for loops are just repeating the same thing over and over. Therefore, if you can do it once
# you can do it infinity times


############################
#I wanna make a function that calculates the 95% confidence interval no matter the input
#using these functions sd(), length(), qt()

################variables###############
data<-c(1:10)   ###data as a vector
ci<-.01         ###confidence
########################################
#sd/sqrt(n) * tvalue (df) +/- mean    #heres what we need to do
# so instead of thinking of this as one giant problem and perhaps freezing up
# we should break it down into it's pieces and figure out how to do them one by one

sd.data<-sd(data)   #this function calculates the standard deviation, whew that was easy

n<-length(data)    #length takes the length of a vector, well thats the same as N, right?

sem<-sd.data/n    # put them together. And there we go, we have sd/sqrt(n) also known as the standard error of the mean (sem)

#with some googling (or just using the help section) you can figure out that the function qt gives us the t value as long
# as we also give it the degrees of freedom (which is n-1) and the confidence interval (ci)
tvalue<-qt(ci,(length(data)-1))   ###with that we can write this  

mean.data<-mean(data)   ##the mean can be calculated with the mean function
sem*tvalue   ##gives us our interval
upper<-mean.data + sem*tvalue   ##putting it all together, this gives us our upper range

lower<-mean.data - sem*tvalue   ## our lower


###now that we have all 3 of our numbers for our confidence interval we can have it print out the values
print(paste0('your upper bound is: (',upper, ') and your lower bound is: (', lower,"), and your mean is: (", mean.data,')'))
##################################
#lets add in an if statement that gives us an error message if we put in a confidence interval that is not between 0 and 1. 
# we can now either run it as is:
################variables###############
data<-c(1:10)   ###data as a vector
ci<-.01         ###confidence
########################################
##start of code
if(ci>abs(1)){print("You can't have a probability greater than 1 you goof!")}else{
  sd.data<-sd(data)
  
  n<-length(data)
  
  sem<-sd.data/n
  
  tvalue<-qt(ci,(length(data)-1))
  
  mean.data<-mean(data)
  
  upper<-mean.data + sem*tvalue
  
  lower<-mean.data - sem*tvalue
  
  print(paste0('your upper bound is: (',upper, ') and your lower bound is: (', lower,"), and your mean is: (", mean.data,')'))
  list1<-list(upperbound=upper,lowerbound=lower,mean=mean.data)
}

###end of code
##################
#or we can make it into a function
###
CI.fun<-function(data,ci){
  if(ci>abs(1)){print("You can't have a probability greater than 1 you goof!")}else{
    sd.data<-sd(data)
    n<-length(data)
    sem<-sd.data/n
    tvalue<-qt(ci,(length(data)-1))
    mean.data<-mean(data)
    upper<-mean.data + sem*tvalue
    lower<-mean.data - sem*tvalue
    print(paste0('your upper bound is: (',upper, ') and your lower bound is: (', lower,"), and your mean is: (", mean.data,')'))
    list1<-list(upperbound=upper,lowerbound=lower,mean=mean.data)
  }}

##and now we can feed it whatever data vector and confidence interval we want
CI.fun(1:100,.95)    ##try it with a data vector of all integers between 1 and 100
CI.fun(sample.int(100,20),.95)   ###try it with a data vector of 20 random numbers

##whatever data vector we give it, as long as they are real numbers, it will give us an answer
# lets not forget our error message
CI.fun(1:10,2)


###heres how you would write the function shorter
# remember if you use a variable more than once, just store it as a value to make your life easier
CI.fun<-function(data,ci){
  range<-sd(data)/length(data) * qt(ci,(length(data)-1))
  mean.data<-mean(data)
  list1<-list(upper=mean.data+range,lower=mean.data-range,mean=mean.data)
  print(list1)
}
result<-CI.fun(1:10,.95)
