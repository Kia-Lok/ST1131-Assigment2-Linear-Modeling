setwd("~/Desktop/NUS Mods/Actual Mods from Semester/ST1131/Data/")
df = read.csv("hdb_2017_2025Feb_sample.csv")
head(df)
attach(df)
#Q1
#Treated as Quantitative Data:Storey Range, Floor Area Sqm, Lease Commence Date, 
#Resale Price, Remaining_lease
#Modifications to Data:
#Storey_range -> Convert to high and low
#Reamining lease -> years only with decimal point
#Resale Price -> Expressed in hundred thousand

#Q2
#Histogram plot (Continuous Quantiative)
hist(df$floor_area_sqm, xlim=c(30, 250), ylim=c(0, 1100), breaks = 44)

#Q3
#Bar Plot (Normative Categorical)
unique(flat_type)
two_room <- length(flat_type[flat_type == "2 ROOM"])
three_room <- length(flat_type[flat_type == "3 ROOM"])
four_room <- length(flat_type[flat_type == "4 ROOM"])
five_room <- length(flat_type[flat_type == "5 ROOM"])
executive <- length(flat_type[flat_type == "EXECUTIVE"])
multi <- length(flat_type[flat_type == "MULTI-GENERATION"])
values <- c(two_room, three_room, four_room, five_room, executive, multi)
names <- c("2 Room", "3 Room", "4 Room", "5 Room", "Executive", "Multi-Generational")
barplot(values, names.arg = names)

#Q4
#6 times boxplots...? How to represent them nicely?
two_room <- floor_area_sqm[flat_type == "2 ROOM"]
three_room <- floor_area_sqm[flat_type == "3 ROOM"]
four_room <- floor_area_sqm[flat_type == "4 ROOM"]
five_room <- floor_area_sqm[flat_type == "5 ROOM"]
executive <- floor_area_sqm[flat_type == "EXECUTIVE"]
multi <- floor_area_sqm[flat_type == "MULTI-GENERATION"]
boxplot(two_room, three_room, four_room, five_room, executive, multi)

#Q5
#Scatterplot + Cor
new_resale_price <- df$resale_price / 100000
plot(df$floor_area_sqm, new_resale_price)
cor(df$floor_area_sqm, new_resale_price)

#Q6
#Linear regression + Variables