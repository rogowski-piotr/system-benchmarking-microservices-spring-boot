library(ggplot2)
library(reshape)
library(grid)
library(dplyr)
library(jsonlite)
library(stringr)
library(gridExtra)

############################## FUNCTIONS #####################################

load_data <- function(path, file1, file2, parsed_data){
  
  json_data <- fromJSON(paste(path, file1, sep = ""), flatten = TRUE)
  tmp1 <- as.numeric(json_data$data$result$values[[1]][,2])
  
  json_data <- fromJSON(paste(path, file2, sep = ""), flatten = TRUE)
  tmp2 <- as.numeric(json_data$data$result$values[[1]][,2])
  
  technology_name <- ""
  if (toupper(paste(strsplit(path, "-")[[1]][3], collapse = " ")) != "SPRING") { 
    technology_name <- paste(strsplit(path, "-")[[1]][3], collapse = " ")
    architecture_name <- paste(strsplit(paste(strsplit(path, "-")[[1]][4], collapse = " "), "\\.")[[1]][1], collapse = " ")
  } 
  else { 
    technology_name <- paste(strsplit(path, "-")[[1]][3:4], collapse = " ")
    architecture_name <- paste(strsplit(paste(strsplit(path, "-")[[1]][5], collapse = " "), "\\.")[[1]][1], collapse = " ")
  }
  
  data_tmp <- data.frame(Memory_Usage = tmp1, check.names=FALSE)
  data_tmp <- data.frame(data_tmp, CPU_Usage = tmp2, check.names=FALSE)
  data_tmp <- data.frame(append(data_tmp, c(Technology=technology_name), after=0))
  data_tmp <- data.frame(append(data_tmp, c(Architecture=architecture_name), after=0))
  parsed_data <- union_all(parsed_data, data_tmp)
  
  return(parsed_data)
  
}


############################### CODE #########################################


# The main directory for the output files

dir <- "D:/xxx/"

#+ List of the sources. This script assumes there is a special naming convention. 
#+ Comment out files that are non-existent in your project

path <- "docker-compose-dotnet-microservices.yml/"
path <- append(path, "docker-compose-dotnet-monolith.yml/")
path <- append(path, "docker-compose-flask-microservices.yml/")
path <- append(path, "docker-compose-flask-monolith.yml/")
path <- append(path, "docker-compose-spring-boot-microservices.yml/")
path <- append(path, "docker-compose-spring-boot-monolith.yml/")


# Defining an object (Data Frame) to store the data

parsed_data <- data.frame(matrix(ncol = 0, nrow = 0))

# Loading the data from csv files

for (file in path) {
  
  parsed_data <- load_data(paste(dir, file, sep = ""), "sum_memory_usage_bytes.json", "sum_percentage_cpu_usage_seconds_total.json",parsed_data)
  
}


# Plotting diagrams ##################################3

# Memory Usage ###

png(file=paste(dir, "memory_usage_architecture.png", sep = ""), width = 1200, height= 800)

p1 = ggplot(parsed_data[toupper(parsed_data$Architecture) == "MONOLITH",], aes(x = Technology, y = Memory_Usage)) + 
  geom_boxplot(fill = c("lightgreen")) +
# facet_wrap(~Route, ncol = 1) +
  xlab("") +
  ylab("Memory Usage [B]") +
  labs(subtitle = "Monolith") 
#+
#  coord_cartesian(ylim=c(0, 15))

p2 = ggplot(parsed_data[toupper(parsed_data$Architecture) == "MICROSERVICES",], aes(x = Technology, y = Memory_Usage)) + 
  geom_boxplot(fill = c("lightgreen")) +
#  facet_wrap(~Route, ncol = 1) +
  xlab("") +
  ylab("") +
  labs(subtitle = "Microservices") 
#+
#  coord_cartesian(ylim=c(0, 1.7))


grid.arrange(p1, p2, ncol = 2)

dev.off()

# CPU Usage ##########

png(file=paste(dir, "cpu_usage_architecture.png", sep = ""), width = 1200, height= 800)

p1 = ggplot(parsed_data[toupper(parsed_data$Architecture) == "MONOLITH",], aes(x = Technology, y = CPU_Usage)) + 
  geom_boxplot(fill = c("lightgreen")) +
  # facet_wrap(~Route, ncol = 1) +
  xlab("") +
  ylab("Memory Usage [B]") +
  labs(subtitle = "Monolith") 
#+
#  coord_cartesian(ylim=c(0, 15))

p2 = ggplot(parsed_data[toupper(parsed_data$Architecture) == "MICROSERVICES",], aes(x = Technology, y = CPU_Usage)) + 
  geom_boxplot(fill = c("lightgreen")) +
  #  facet_wrap(~Route, ncol = 1) +
  xlab("") +
  ylab("") +
  labs(subtitle = "Microservices") 
#+
#  coord_cartesian(ylim=c(0, 1.7))


grid.arrange(p1, p2, ncol = 2)

dev.off()