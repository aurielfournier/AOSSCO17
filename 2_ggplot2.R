### -- ggplot2 section
### -- By - Auriel Fournier
### -- https://github.com/aurielfournier/AOSSCO17

# use install.packages() if you don't have these already
library(dplyr)
library(ggplot2) 
library(ggthemes)
library(RColorBrewer)
library(gridExtra)
library(gapminder) 

# ggplot2 is built on the grammar of graphics, the idea that any plot can be expressed from the same set of components: 

#------ a **data** set
#------ a **coordinate system**
#------ and a set of **geoms** --the visual representation of data points.

# The key to understanding ggplot2 is thinking about a figure in layers. This idea may be familiar to you if you have used image editing programs like Photoshop, Illustrator, or Inkscape.
# Let's start off with an example:

ggplot(data = gapminder, 
       aes(x = gdpPercap, y = lifeExp))

# this gives us a plot, with no data on it, but for a good reason. 
# we have told ggplot what data we want to use, and what axis we want
# the variables to be on, but we haven't told it how we want the data displayed
# do we want points? lines? box plots? it has no idea
# so it gives us the blank canvas
# so lets add a layer

ggplot(data = gapminder, 
       aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

# now we can see the data! huzzah!
# we use a '+' sign to connect layers in ggplot, instead of the %>% pipe that we 
# learned earlier. I realize this can be confusing



# lets go into a bit more detail of what the above code says
# We've passed in two arguments to `ggplot`. First, we tell `ggplot` what data we
# want to show on our figure, in this example the gapminder data we read in
# earlier. 
# For the second argument we passed in the `aes` function, which
# tells `ggplot` how variables in the **data** map to *aesthetic* properties of
# the figure, in this case the **x** and **y** variables. 
# Here we told `ggplot` we want to plot the "gdpPercap" column of the gapminder 
# data frame on the x-axis, and the "lifeExp" column on the y-axis. 
# Notice that we didn't need to explicitly pass `aes` these columns (e.g. `x = gapminder[, "gdpPercap"]`), this is because `ggplot` is smart enough to know to look in the **data** for that column!

# What do we need to change to look at how life expectancy changes over time?  

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp)) + 
  geom_point()

# Hint: the gapminder dataset has a column called "year", which should appear
# on the x-axis.

### Challenge 2 

# In the previous examples and challenge we've used the `aes` function to tell
# the scatterplot **geom** about the **x** and **y** locations of each point.
# Another *aesthetic* property we can modify is the point *color*. Modify the
# code from the previous challenge to **color** the points by the "continent"
# column. What trends do you see in the data? Are they what you expected?

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp,
           color=continent)) + 
  geom_point()


############################
# ---- Layers
############################


#Using a scatterplot probably isn't the best for visualising change over time.
#Instead, let's tell `ggplot` to visualise the data as a line plot:
  
ggplot(data = gapminder, 
       aes(x=year, y=lifeExp, 
            color=continent)) +
  geom_line()

#Instead of adding a `geom_point` layer, we've added a `geom_line` layer. 
# but this probably doesn't look the way we expect
# since we have the lines colored by continent, there is one line per continent,
# so all the countries in that continent are merged together
# if we add the **by** *aesthetic*, we will be able to say do each line
# by country, and see a different chart

ggplot(data = gapminder, 
       aes(x=year, y=lifeExp, 
           by=country,color=continent)) +
  geom_line()

# But what if we want to visualise both lines and points on the plot? 
# We can simply add another layer to the plot:
  
ggplot(data = gapminder, 
       aes(x=year, y=lifeExp, 
           by=country, color=continent)) +
  geom_line() + 
  geom_point()

#It's important to note that each layer is drawn on top of the previous layer. In
#this example, the points have been drawn *on top of* the lines. Here's a
#demonstration:
  
ggplot(data = gapminder, 
       aes(x=year, y=lifeExp, 
           by=country)) +
  geom_line(aes(color=continent)) + 
  geom_point()

# In this example, the *aesthetic* mapping of **color** has been moved from the
# global plot options in `ggplot` to the `geom_line` layer so it no longer applies
# to the points. Now we can clearly see that the points are drawn on top of the
# lines.

# Switch the order of the point and line layers from the previous example. What happened?

  ## Transformations and statistics
  
#  ggplot also makes it easy to overlay statistical models over the data. To
# demonstrate we'll go back to our first example:

ggplot(data = gapminder, 
       aes(x = gdpPercap, 
           y = lifeExp, color=continent)) +
  geom_point()

# Currently it's hard to see the relationship between the points due to some strong
# outliers in GDP per capita. We can change the scale of units on the x axis using
# the *scale* functions. These control the mapping between the data values and
# visual values of an aesthetic. We can also modify the transparency  of the
# points, using the *alpha* funtion, which is especially helpful when you have
# a large amount of data which is very clustered.

ggplot(data = gapminder, 
       aes(x = gdpPercap, 
           y = lifeExp)) +
  geom_point(alpha = 0.5, 
             aes(color=continent)) + 
  scale_x_log10()  

# The `log10` function applied a transformation to the values of the gdpPercap
# column before rendering them on the plot, so that each multiple of 10 now only
# corresponds to an increase in 1 on the transformed scale, e.g. a GDP per capita
# of 1,000 is now 3 on the y axis, a value of 10,000 corresponds to 4 on the y
# axis and so on. This makes it easier to visualise the spread of data on the
# x-axis.

# We can fit a simple relationship to the data by adding another layer,
#`geom_smooth`:
  
ggplot(data = gapminder, 
  aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha=0.5) + 
  scale_x_log10() + 
  geom_smooth(method="lm", aes(color=continent))

# We can make the line thicker by *setting* the **size** aesthetic in the
# `geom_smooth` layer:
  
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() + 
  scale_x_log10() + 
  geom_smooth(method="lm", aes(size=continent))

# There are two ways an *aesthetic* can be specified. Here we *set* the **size**
#  aesthetic by passing it as an argument to `geom_smooth`. Previously in the
# lesson we've used the `aes` function to define a *mapping* between data
# variables and their visual representation.

# ## Challenge 4a

# Modify the color and size of the points on the point layer in the previous
# example.
#
# Hint: do not use the `aes` function.
#

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(color="red", size=2) + 
  scale_x_log10() + 
  geom_smooth(method="lm", size=1.5)

## Challenge 4b 
#
# Modify your solution to Challenge 4a so that the points are now a different shape and are colored by continent.

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color=continent, shape=continent), ) + 
  scale_x_log10() + 
  geom_smooth(method="lm", size=1.5)

#  Hint: The color argument can be used inside and outside the aesthetic 'aes()'.

# we can also use pipes to deliver our data to ggplot

gapminder %>%
  filter(year>=1990) %>%
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point() 

## Multi-panel figures

# Earlier we visualised the change in life expectancy over time across all
# countries in one plot. Alternatively, we can split this out over multiple panels
# by adding a layer of **facet** panels. Focusing only on those countries with
# names that start with the letter "A" or "Z".

ggplot(data=gapminder, 
       aes(x = year, 
           y = lifeExp, 
           group=country)) +
  geom_line() + 
  facet_wrap(~continent, ncol=2)

# The `facet_wrap` layer took a "formula" as its argument, denoted by the tilde
# (~). This tells R to draw a panel for each unique value in the country column
# of the gapminder dataset.

## Modifying text

# To clean this figure up for a publication we need to change some of the text
# elements. The x-axis is too cluttered, and the y axis should read
# "Life expectancy", rather than the column name in the data frame.

# We can do this by adding a couple of different layers. The **theme** layer
# controls the axis text, and overall text size, and there are special layers
# for changing the axis labels. To change the legend title, we need to use the
# **scale** layer.

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, group=country,
           color=continent)) +
    geom_line() + 
    facet_wrap( ~continent, ncol=2) +
    xlab("Year") + 
    ylab("Life expectancy") + 
    ggtitle("Figure 1") +
    scale_colour_discrete(name="Continent") +
    theme_few()


# This is a taste of what you can do with `ggplot2`. RStudio provides a
# really useful cheat sheet of the different layers available, and more
# extensive documentation is available on the [ggplot2 website][ggplot-doc].
# Finally, if you have no idea how to change something, a quick google search will
# usually send you to a relevant question and answer on Stack Overflow with reusable
# code to modify!

# http://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf
# http://docs.ggplot2.org/current/



# you can build your own themes (we'll cover this later)
# OR you can use some pre made themes
# https://github.com/jrnold/ggthemes

ggplot(data=gapminder, 
       aes(x = year, 
           y = lifeExp, 
           group=country)) +
  geom_line()+
  theme_economist()

ggplot(data=gapminder, 
       aes(x = year, 
           y = lifeExp, 
           group=country)) +
  geom_line()+
  theme_gdocs()

ggplot(data=gapminder, 
       aes(x = year, 
           y = lifeExp, 
           group=country)) +
  geom_line()+
  theme_excel()

## Custom Themes

?theme # shows you all the little things you can manipulate in a ggplot
# thus far I've always been able to get done what needs doing with a custom theme
# look at the graph below, its pretty visually assualting
# figure out how to fix it

ggplot(data=gapminder, 
       aes(x = year, 
           y = lifeExp, 
           group=country)) +
  geom_line(aes(color=continent), size=0.1)+
  facet_wrap(~continent)+
  ylab("Life Expectancy")+
  theme(axis.text.x = element_text(size = 12, ang=90, color = "black"), 
        axis.text.y = element_text(size = 12, color = "black"), 
        axis.title.y = element_text(size = 20), 
        plot.background = element_rect(fill="white"), 
        panel.background = element_rect(fill="white", color="black"), 
        panel.grid.major = element_line(colour = NA), 
        panel.grid.minor = element_line(colour = NA), 
        title = element_text(size = 20), 
#        axis.line.x = element_line(colour = "black"), 
#        axis.line.y = element_line(colour = "black"), 
        strip.background = element_rect(fill = "white", color = "black"), 
        strip.text = element_text(size = 15, color="black"),
        legend.background = element_rect(fill="white"),
        legend.text = element_text(color="black"),
        legend.key=element_rect(fill="white"))
  


######################
# Colors (RColorBrewer)
#####################
#http://colorbrewer2.org/
  
display.brewer.all(n=NULL, type="all", select=NULL, exact.n=TRUE,colorblindFriendly=TRUE)
  
mypalette<-brewer.pal(5,"Greens")

ggplot(gapminder, aes(x=continent, 
                      y=lifeExp, 
                      fill=continent)) + 
  geom_boxplot()+ 
  ggtitle("TITLE HERE")+ 
  xlab("text here")+ 
  ylab("text here") + 
  scale_fill_manual(values=mypalette)

mypalette<-brewer.pal(5,"Set2")

mypalette[2] <- "#000000"

ggplot(gapminder, aes(x=continent, y=lifeExp, 
                      fill=continent)) + 
  geom_boxplot()+ 
  ggtitle("TITLE HERE")+ 
  xlab("text here")+ 
  ylab("text here") + 
  scale_fill_manual(values=mypalette)

# you can always add onto the aesthetics later by adding an additional aes command. 
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp))+
  scale_x_log10()+ 
  aes(color=continent)+
  geom_point()+
  geom_smooth(lwd=3, se=F)

###################################
## Saving, Stacking and Rearranging Graphs (gridExtra)
###################################

(a <- gapminder %>%
          filter(continent=="Oceania") %>%
          ggplot(aes(x=year, y=lifeExp, group=country)) + 
  geom_line())

(b <- gapminder %>%
          filter(continent=="Europe") %>%
          ggplot(aes(x=year, y=gdpPercap,
                     group=country)) + 
  geom_line())


grid.arrange(a,b,a,b,nrow=2)

#ggsave(a, file="filenamehere.extension")
ggsave(a, file="~/../Desktop/example_file.jpeg", 
       height=4, width=4, units="cm", dpi=600)


png("~/../Desktop/x.png", height=12, width=12, units="cm", res=300)

grid.arrange(a,b,a,b,nrow=2)

dev.off()
