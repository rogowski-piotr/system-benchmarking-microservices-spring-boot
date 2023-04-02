#######################################
#           CLEAN WORKSPACE           #
#######################################
rm(list = ls())
cat("\014")
# dev.off(dev.list()["RStudioGD"])


#######################################
#               IMPORTS               #
#######################################
library(ggplot2)
library(reshape)
library(grid)
library(dplyr)
library(jsonlite)
library(stringr)
library(gridExtra)


#######################################
#              FUNCTIONS              #
#######################################
load_data_and_calculate_throughput <- function(jmeter_csv_path, technology_name, architecture_name, parsed_data_reference) {
  data_csv <- read.csv(jmeter_csv_path)
  
  data_frame <- data.frame(Elapsed = data_csv$elapsed, check.names=FALSE)
  data_frame <- data.frame(data_frame, Latency = data_csv$Latency, check.names=FALSE)
  data_frame <- data.frame(append(data_frame, c(Technology=technology_name), after=0))
  data_frame <- data.frame(append(data_frame, c(Architecture=architecture_name), after=0))
  data_frame <- data.frame(data_frame, Route=str_split_fixed(data_csv$label, " ", 3)[,2], check.names = FALSE)
  
  data_frame$Throughput <- with(data_csv, sentBytes * 1000 / ( elapsed * 1024))
  data_frame <- union_all(data_frame, parsed_data_reference)
  return(data_frame)
}


#######################################
#           SETUP & INPUTS            #
#######################################
setwd("C:/Users/rogus/Desktop/wyniki po optimalizacji mikroserwisow")
jmeter_path_dotnet_monolith      <- "Dotnet - monolith/jmeter_output.csv"
jmeter_path_dotnet_microservices <- "Dotnet - microservices/jmeter_output.csv"
jmeter_path_flask_monolith       <- "Flask - monolith/jmeter_output.csv"
jmeter_path_flask_microservices  <- "Flask - microservices/jmeter_output.csv"
jmeter_path_spring_monolith      <- "Spring Boot - monolith/jmeter_output.csv"
jmeter_path_spring_microservices <- "Spring Boot - microservices/jmeter_output.csv"


#######################################
#            PARSING DATA             #
#######################################
parsed_data <- data.frame(matrix(ncol = 0, nrow = 0))
parsed_data <- load_data_and_calculate_throughput(jmeter_path_dotnet_monolith,      "Dotnet",      "Monolith",      parsed_data)
parsed_data <- load_data_and_calculate_throughput(jmeter_path_dotnet_microservices, "Dotnet",      "Microservices", parsed_data)
parsed_data <- load_data_and_calculate_throughput(jmeter_path_flask_monolith,       "Flask",       "Monolith",      parsed_data)
parsed_data <- load_data_and_calculate_throughput(jmeter_path_flask_microservices,  "Flask",       "Microservices", parsed_data)
parsed_data <- load_data_and_calculate_throughput(jmeter_path_spring_monolith,      "Spring Boot", "Monolith",      parsed_data)
parsed_data <- load_data_and_calculate_throughput(jmeter_path_spring_microservices, "Spring Boot", "Microservices", parsed_data)


#######################################
#           PLOT THROUGHPUT           #
#######################################
plot_throughput <- ggplot(data = parsed_data, aes(x = Architecture, y = Throughput, fill = Technology)) +
  geom_boxplot() +
  xlab("") +
  ylab("Throughput [kB/s]") +
  scale_y_continuous(breaks = seq(0, 11, by = 1), limits = c(0, 11)) # scale to required size

png(file=paste("plot_throughput.png", sep = ""), width = 1000, height= 800, res = 190)
print(plot_throughput)
dev.off()


#######################################
#     PLOT REQUESTS PRE SECONDS       #
#######################################
benchmark_duration_seconds <- 60

# count total number of requests depending on architecture and technology
requests_dotnet_microservices <- nrow(parsed_data[parsed_data$Architecture == "Microservices" & parsed_data$Technology == "Dotnet",])
requests_flask_microservices  <- nrow(parsed_data[parsed_data$Architecture == "Microservices" & parsed_data$Technology == "Flask",])
requests_spring_microservices <- nrow(parsed_data[parsed_data$Architecture == "Microservices" & parsed_data$Technology == "Spring Boot",])
requests_dotnet_monolith      <- nrow(parsed_data[parsed_data$Architecture == "Monolith"      & parsed_data$Technology == "Dotnet",])
requests_flask_monolith       <- nrow(parsed_data[parsed_data$Architecture == "Monolith"      & parsed_data$Technology == "Flask",])
requests_spring_monolith      <- nrow(parsed_data[parsed_data$Architecture == "Monolith"      & parsed_data$Technology == "Spring Boot",])

# count requests per seconds
handled_requests_dotnet_microservices      <- requests_dotnet_microservices  / benchmark_duration_seconds
handled_requests_dotnet_monolith           <- requests_dotnet_monolith       / benchmark_duration_seconds
handled_requests_flask_microservices       <- requests_flask_microservices   / benchmark_duration_seconds
handled_requests_flask_monolith            <- requests_flask_monolith        / benchmark_duration_seconds
handled_requests_spring_boot_microservices <- requests_spring_microservices  / benchmark_duration_seconds
handled_requests_spring_boot_monolith      <- requests_spring_monolith       / benchmark_duration_seconds

# Convert data to data.frame
df_spring_boot_monolith <-      data.frame(architecture = "Monolith",      technology = "Spring boot", value = handled_requests_spring_boot_monolith,      check.names=FALSE)
df_spring_boot_microservices <- data.frame(architecture = "Microservices", technology = "Spring boot", value = handled_requests_spring_boot_microservices, check.names=FALSE)
df_dotnet_monolith <-           data.frame(architecture = "Monolith",      technology = "Dotnet",      value = handled_requests_dotnet_monolith,           check.names=FALSE)
df_dotnet_microservices <-      data.frame(architecture = "Microservices", technology = "Dotnet",      value = handled_requests_dotnet_microservices,      check.names=FALSE)
df_flask_monolith <-            data.frame(architecture = "Monolith",      technology = "Flask",       value = handled_requests_flask_monolith,            check.names=FALSE)
df_flask_microservices <-       data.frame(architecture = "Microservices", technology = "Flask",       value = handled_requests_flask_microservices,       check.names=FALSE)

# Merge all data.frame
data_requests <- union_all(df_spring_boot_microservices, df_spring_boot_monolith)
data_requests <- union_all(data_requests, df_dotnet_monolith)
data_requests <- union_all(data_requests, df_dotnet_microservices)
data_requests <- union_all(data_requests, df_flask_monolith)
data_requests <- union_all(data_requests, df_flask_microservices)

# Plot and save to png
p1 <- ggplot(data = data_requests, aes(x = architecture, y = value, fill = technology)) +
  geom_bar(stat="identity", color="black", position="dodge") +
  theme_minimal() + 
  labs(title = "Request per second depending on configuration", y = "requests", x = "architecture")

png(file=paste("requests_per_second.png", sep = ""), width = 1000, height= 800, res = 190)
print(p1)
dev.off()
