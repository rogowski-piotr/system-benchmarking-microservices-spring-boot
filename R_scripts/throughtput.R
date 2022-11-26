library(ggplot2)
library(reshape)
library(grid)
library(dplyr)

dir = 'd:/studies/mgr2/proj_bad/OK/'


#######################Monoliths############################
#.NET Monolith
#Route 1
tmp <- read.csv(paste(dir, 'Dotnet_Monolith_Route1.csv', sep = ""))
data <- data.frame(Elapsed = tmp$elapsed, check.names=FALSE)
data <- data.frame(data, Latency = tmp$Latency, check.names=FALSE)
data <- data.frame(append(data, c(Technology='.NET'), after=0))
data <- data.frame(append(data, c(Architecture='Monolith'), after=0))
data <- data.frame(append(data, c(Route='Route1'), after=0))
data$Throughput <- with(tmp, sentBytes *1000 / ( elapsed * 1024))

#elapsed1 = data_d1$elapsed
#latency1 = data1$Latency

#plot(y = elapsed2_mean,
#     xlab = "x-axis",
#     ylab = "y-axis",
#     main = "Plot")

#Route 2
tmp <- read.csv(paste(dir, 'Dotnet_Monolith_Route2.csv', sep = ""))
data_tmp <- data.frame(Elapsed = tmp$elapsed, check.names=FALSE)
data_tmp <- data.frame(data_tmp, Latency = tmp$Latency, check.names=FALSE)
data_tmp <- data.frame(append(data_tmp, c(Technology='.NET'), after=0))
data_tmp <- data.frame(append(data_tmp, c(Architecture='Monolith'), after=0))
data_tmp <- data.frame(append(data_tmp, c(Route='Route2'), after=0))
data_tmp$Throughput <- with(tmp, sentBytes *1000 / ( elapsed * 1024))
data <- union_all(data, data_tmp)


#Flask Monolith
#Route 1 
tmp <- read.csv(paste(dir, 'Flask_Monolith_Route1.csv', sep = ""))
data_tmp <- data.frame(Elapsed = tmp$elapsed, check.names=FALSE)
data_tmp <- data.frame(data_tmp, Latency = tmp$Latency, check.names=FALSE)
data_tmp <- data.frame(append(data_tmp, c(Technology='Flask'), after=0))
data_tmp <- data.frame(append(data_tmp, c(Architecture='Monolith'), after=0))
data_tmp <- data.frame(append(data_tmp, c(Route='Route1'), after=0))
data_tmp$Throughput <- with(tmp, sentBytes *1000/ ( elapsed * 1024))
data <- union_all(data, data_tmp)

#Route 2
tmp <- read.csv(paste(dir, 'Flask_Monolith_Route2.csv', sep = ""))
data_tmp <- data.frame(Elapsed = tmp$elapsed, check.names=FALSE)
data_tmp <- data.frame(data_tmp, Latency = tmp$Latency, check.names=FALSE)
data_tmp <- data.frame(append(data_tmp, c(Technology='Flask'), after=0))
data_tmp <- data.frame(append(data_tmp, c(Architecture='Monolith'), after=0))
data_tmp <- data.frame(append(data_tmp, c(Route='Route2'), after=0))
data_tmp$Throughput <- with(tmp, sentBytes *1000 / ( elapsed * 1024))
data <- union_all(data, data_tmp)

#Spring Boot Monolith
#Route 1 
tmp <- read.csv(paste(dir, 'Spring_Boot_Monolith_Route1.csv', sep = ""))
data_tmp <- data.frame(Elapsed = tmp$elapsed, check.names=FALSE)
data_tmp <- data.frame(data_tmp, Latency = tmp$Latency, check.names=FALSE)
data_tmp <- data.frame(append(data_tmp, c(Technology='Spring Boot'), after=0))
data_tmp <- data.frame(append(data_tmp, c(Architecture='Monolith'), after=0))
data_tmp <- data.frame(append(data_tmp, c(Route='Route1'), after=0))
data_tmp$Throughput <- with(tmp, sentBytes *1000 / ( elapsed * 1024))
data <- union_all(data, data_tmp)

#Route 2
tmp <- read.csv(paste(dir, 'Spring_Boot_Monolith_Route2.csv', sep = ""))
data_tmp <- data.frame(Elapsed = tmp$elapsed, check.names=FALSE)
data_tmp <- data.frame(data_tmp, Latency = tmp$Latency, check.names=FALSE)
data_tmp <- data.frame(append(data_tmp, c(Technology='Spring Boot'), after=0))
data_tmp <- data.frame(append(data_tmp, c(Architecture='Monolith'), after=0))
data_tmp <- data.frame(append(data_tmp, c(Route='Route2'), after=0))
data_tmp$Throughput <- with(tmp, sentBytes *1000 / ( elapsed * 1024))
data <- union_all(data, data_tmp)

###############Microservices##################
#.Net Microservices
#Route 1
tmp <- read.csv(paste(dir, 'Dotnet_Microservices_Route1.csv', sep = ""))
data_tmp <- data.frame(Elapsed = tmp$elapsed, check.names=FALSE)
data_tmp <- data.frame(data_tmp, Latency = tmp$Latency, check.names=FALSE)
data_tmp <- data.frame(append(data_tmp, c(Technology='.NET'), after=0))
data_tmp <- data.frame(append(data_tmp, c(Architecture='Microservices'), after=0))
data_tmp <- data.frame(append(data_tmp, c(Route='Route1'), after=0))
data_tmp$Throughput <- with(tmp, sentBytes *1000 / ( elapsed * 1024))
data <- union_all(data, data_tmp)

#Route 2
tmp <- read.csv(paste(dir, 'Dotnet_Microservices_Route2.csv', sep = ""))
data_tmp <- data.frame(Elapsed = tmp$elapsed, check.names=FALSE)
data_tmp <- data.frame(data_tmp, Latency = tmp$Latency, check.names=FALSE)
data_tmp <- data.frame(append(data_tmp, c(Technology='.NET'), after=0))
data_tmp <- data.frame(append(data_tmp, c(Architecture='Microservices'), after=0))
data_tmp <- data.frame(append(data_tmp, c(Route='Route2'), after=0))
data_tmp$Throughput <- with(tmp, sentBytes *1000 / ( elapsed * 1024))
data <- union_all(data, data_tmp)

#Flask Microservices
#Route 1
tmp <- read.csv(paste(dir, 'Flask_Microservices_Route1.csv', sep = ""))
data_tmp <- data.frame(Elapsed = tmp$elapsed, check.names=FALSE)
data_tmp <- data.frame(data_tmp, Latency = tmp$Latency, check.names=FALSE)
data_tmp <- data.frame(append(data_tmp, c(Technology='Flask'), after=0))
data_tmp <- data.frame(append(data_tmp, c(Architecture='Microservices'), after=0))
data_tmp <- data.frame(append(data_tmp, c(Route='Route1'), after=0))
data_tmp$Throughput <- with(tmp, sentBytes *1000 / ( elapsed * 1024))
data <- union_all(data, data_tmp)

#Route 2
tmp <- read.csv(paste(dir, 'Flask_Microservices_Route2.csv', sep = ""))
data_tmp <- data.frame(Elapsed = tmp$elapsed, check.names=FALSE)
data_tmp <- data.frame(data_tmp, Latency = tmp$Latency, check.names=FALSE)
data_tmp <- data.frame(append(data_tmp, c(Technology='Flask'), after=0))
data_tmp <- data.frame(append(data_tmp, c(Architecture='Microservices'), after=0))
data_tmp <- data.frame(append(data_tmp, c(Route='Route2'), after=0))
data_tmp$Throughput <- with(tmp, sentBytes *1000 / ( elapsed * 1024))
data <- union_all(data, data_tmp)

#Spring Boot Microservices
#Route 1
tmp <- read.csv(paste(dir, 'Spring_Boot_Microservices_Route1.csv', sep = ""))
data_tmp <- data.frame(Elapsed = tmp$elapsed, check.names=FALSE)
data_tmp <- data.frame(data_tmp, Latency = tmp$Latency, check.names=FALSE)
data_tmp <- data.frame(append(data_tmp, c(Technology='Spring Boot'), after=0))
data_tmp <- data.frame(append(data_tmp, c(Architecture='Microservices'), after=0))
data_tmp <- data.frame(append(data_tmp, c(Route='Route1'), after=0))
data_tmp$Throughput <- with(tmp, sentBytes *1000 / ( elapsed * 1024))
data <- union_all(data, data_tmp)

#Route 2
tmp <- read.csv(paste(dir, 'Spring_Boot_Microservices_Route2.csv', sep = ""))
data_tmp <- data.frame(Elapsed = tmp$elapsed, check.names=FALSE)
data_tmp <- data.frame(data_tmp, Latency = tmp$Latency, check.names=FALSE)
data_tmp <- data.frame(append(data_tmp, c(Technology='Spring Boot'), after=0))
data_tmp <- data.frame(append(data_tmp, c(Architecture='Microservices'), after=0))
data_tmp <- data.frame(append(data_tmp, c(Route='Route2'), after=0))
data_tmp$Throughput <- with(tmp, sentBytes *1000 / ( elapsed * 1024))
data <- union_all(data, data_tmp)

####################### PLOTTING ##########################################

#data <- data.frame("Route 1" = elapsed1, "Route 2" = elapsed2)

#boxplot(data_elapsed, 
#        xlab = "Route",
#        ylab = "Time [ms]",
#        main = "Route comparison - Monolith"
#       names = c("Route 1", "Route 2")
#) aggregate(data$Elapsed, list(data$Technology), FUN = median)
#aggregate(Elapsed ~  Technology, data, median)

#medians <- aggregate(Elapsed ~  Technology + Architecture, data, median)
#medians <- aggregate(Elapsed = data$Elapsed, by = list(data$Architecture, data$Technology), median)

p1 = ggplot(data[data$Architecture == "Monolith",], aes(x = Technology, y = Throughput)) + 
  geom_boxplot(fill = c("lightgreen")) +
  facet_wrap(~Route, ncol = 1) +
  xlab("") +
  ylab("Throughput [kB/s]") +
  labs(subtitle = "Monolith") +
  coord_cartesian(ylim=c(0, 15))
  
#+geom_text(medians, mapping = aes(label = Elapsed, y = Elapsed - 300))

p2 = ggplot(data[data$Architecture == "Microservices",], aes(x = Technology, y = Throughput)) + 
  geom_boxplot(fill = c("lightgreen")) +
  facet_wrap(~Route, ncol = 1) +
  xlab("") +
  ylab("") +
  labs(subtitle = "Microservices") +
  coord_cartesian(ylim=c(0, 1.7))


grid.arrange(p1, p2, ncol = 2)


p1 = ggplot(data[data$Route == "Route1",], aes(x = Technology, y = Throughput)) + 
  geom_boxplot(fill = c("lightgreen")) +
  facet_wrap(~Architecture, ncol = 1) +
  xlab("") +
  ylab("Throughput [kB/s]") +
  labs(subtitle = "Route 1") +
  coord_cartesian(ylim=c(0, 15))
#+geom_text(medians, mapping = aes(label = Elapsed, y = Elapsed - 300))

p2 = ggplot(data[data$Route == "Route2",], aes(x = Technology, y = Throughput)) + 
  geom_boxplot(fill = c("lightgreen")) +
  facet_wrap(~Architecture, ncol = 1) +
  xlab("") +
  ylab("") +
  labs(subtitle = "Route 2") +
  coord_cartesian(ylim=c(0, 3))


grid.arrange(p1, p2, ncol = 2)

