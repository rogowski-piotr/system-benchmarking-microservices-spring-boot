rm(list = ls())
cat("\014")  

library(ggplot2)
library(reshape)
library(grid)
library(dplyr)
library(jsonlite)
library(stringr)
library(gridExtra)
library(patchwork)



#######################################
#             Input data              #
#######################################
# CPU
#title <- "Consumption of system resources (CPU)"
#y_label <- "CPU usage [%]"
#output_file_name = "system_resources_consumption_cpu.png"
#file_sufix <- "percentage_cpu_usage_seconds_total"

# Memory
title <- "Consumption of system resources (RAM)"
y_label <- "Memory Usage [kB]"
output_file_name = "system_resources_consumption_memory_usage_bytes.png"
file_sufix <- "memory_usage_bytes"



#######################################
#        Obtain path to files         #
#######################################
path_data_json_dotnet_monolith <-       paste("Dotnet - monolith/system resources consumption/monolith_",                       file_sufix, ".json", sep = "")
path_data_json_dotnet_microservice_1 <- paste("Dotnet - microservices/system resources consumption/reverse-proxy_",             file_sufix, ".json", sep = "")
path_data_json_dotnet_microservice_2 <- paste("Dotnet - microservices/system resources consumption/ubuntu_distance-service_1_", file_sufix, ".json", sep = "")
path_data_json_dotnet_microservice_3 <- paste("Dotnet - microservices/system resources consumption/ubuntu_place-service_1_",    file_sufix, ".json", sep = "")
path_data_json_dotnet_microservice_4 <- paste("Dotnet - microservices/system resources consumption/ubuntu_route1-service_1_",   file_sufix, ".json", sep = "")
path_data_json_dotnet_microservice_5 <- paste("Dotnet - microservices/system resources consumption/ubuntu_route2-service_1_",   file_sufix, ".json", sep = "")

path_data_json_spring_boot_monolith <-       paste("Spring Boot - monolith/system resources consumption/monolith_",                       file_sufix, ".json", sep = "")
path_data_json_spring_boot_microservice_1 <- paste("Spring Boot - microservices/system resources consumption/reverse-proxy_",             file_sufix, ".json", sep = "")
path_data_json_spring_boot_microservice_2 <- paste("Spring Boot - microservices/system resources consumption/ubuntu_distance-service_1_", file_sufix, ".json", sep = "")
path_data_json_spring_boot_microservice_3 <- paste("Spring Boot - microservices/system resources consumption/ubuntu_place-service_1_",    file_sufix, ".json", sep = "")
path_data_json_spring_boot_microservice_4 <- paste("Spring Boot - microservices/system resources consumption/ubuntu_route1-service_1_",   file_sufix, ".json", sep = "")
path_data_json_spring_boot_microservice_5 <- paste("Spring Boot - microservices/system resources consumption/ubuntu_route2-service_1_",   file_sufix, ".json", sep = "")

path_data_json_flask_monolith <-       paste("Flask - monolith/system resources consumption/monolith_",                       file_sufix, ".json", sep = "")
path_data_json_flask_microservice_1 <- paste("Flask - microservices/system resources consumption/reverse-proxy_",             file_sufix, ".json", sep = "")
path_data_json_flask_microservice_2 <- paste("Flask - microservices/system resources consumption/ubuntu_distance-service_1_", file_sufix, ".json", sep = "")
path_data_json_flask_microservice_3 <- paste("Flask - microservices/system resources consumption/ubuntu_place-service_1_",    file_sufix, ".json", sep = "")
path_data_json_flask_microservice_4 <- paste("Flask - microservices/system resources consumption/ubuntu_route1-service_1_",   file_sufix, ".json", sep = "")
path_data_json_flask_microservice_5 <- paste("Flask - microservices/system resources consumption/ubuntu_route2-service_1_",   file_sufix, ".json", sep = "")



#######################################
#      Read data form json files      #
#######################################
data_json_dotnet_monolith <-        fromJSON(path_data_json_dotnet_monolith,       flatten = TRUE)
data_json_dotnet_microservice_1 <-  fromJSON(path_data_json_dotnet_microservice_1, flatten = TRUE)
data_json_dotnet_microservice_2 <-  fromJSON(path_data_json_dotnet_microservice_2, flatten = TRUE)
data_json_dotnet_microservice_3 <-  fromJSON(path_data_json_dotnet_microservice_3, flatten = TRUE)
data_json_dotnet_microservice_4 <-  fromJSON(path_data_json_dotnet_microservice_4, flatten = TRUE)
data_json_dotnet_microservice_5 <-  fromJSON(path_data_json_dotnet_microservice_5, flatten = TRUE)

data_json_spring_boot_monolith <-       fromJSON(path_data_json_spring_boot_monolith,       flatten = TRUE)
data_json_spring_boot_microservice_1 <- fromJSON(path_data_json_spring_boot_microservice_1, flatten = TRUE)
data_json_spring_boot_microservice_2 <- fromJSON(path_data_json_spring_boot_microservice_2, flatten = TRUE)
data_json_spring_boot_microservice_3 <- fromJSON(path_data_json_spring_boot_microservice_3, flatten = TRUE)
data_json_spring_boot_microservice_4 <- fromJSON(path_data_json_spring_boot_microservice_4, flatten = TRUE)
data_json_spring_boot_microservice_5 <- fromJSON(path_data_json_spring_boot_microservice_5, flatten = TRUE)

data_json_flask_monolith <-       fromJSON(path_data_json_flask_monolith,       flatten = TRUE)
data_json_flask_microservice_1 <- fromJSON(path_data_json_flask_microservice_1, flatten = TRUE)
data_json_flask_microservice_2 <- fromJSON(path_data_json_flask_microservice_2, flatten = TRUE)
data_json_flask_microservice_3 <- fromJSON(path_data_json_flask_microservice_3, flatten = TRUE)
data_json_flask_microservice_4 <- fromJSON(path_data_json_flask_microservice_4, flatten = TRUE)
data_json_flask_microservice_5 <- fromJSON(path_data_json_flask_microservice_5, flatten = TRUE)




#######################################
#     Extract usage resources data    #
#######################################
values_dotnet_monolith <-       as.numeric(data_json_dotnet_monolith$data$result$values[[1]][,2]) / (1024 * 1024)
values_dotnet_microservice_1 <- as.numeric(data_json_dotnet_microservice_1$data$result$values[[1]][,2]) / (1024 * 1024)
values_dotnet_microservice_2 <- as.numeric(data_json_dotnet_microservice_2$data$result$values[[1]][,2]) / (1024 * 1024)
values_dotnet_microservice_3 <- as.numeric(data_json_dotnet_microservice_3$data$result$values[[1]][,2]) / (1024 * 1024)
values_dotnet_microservice_4 <- as.numeric(data_json_dotnet_microservice_4$data$result$values[[1]][,2]) / (1024 * 1024)
values_dotnet_microservice_5 <- as.numeric(data_json_dotnet_microservice_5$data$result$values[[1]][,2]) / (1024 * 1024)

values_spring_boot_monolith <-        as.numeric(data_json_spring_boot_monolith$data$result$values[[1]][,2]) / (1024 * 1024)
values_spring_boot_microservice_1 <-  as.numeric(data_json_spring_boot_microservice_1$data$result$values[[1]][,2]) / (1024 * 1024)
values_spring_boot_microservice_2 <-  as.numeric(data_json_spring_boot_microservice_2$data$result$values[[1]][,2]) / (1024 * 1024)
values_spring_boot_microservice_3 <-  as.numeric(data_json_spring_boot_microservice_3$data$result$values[[1]][,2]) / (1024 * 1024)
values_spring_boot_microservice_4 <-  as.numeric(data_json_spring_boot_microservice_4$data$result$values[[1]][,2]) / (1024 * 1024)
values_spring_boot_microservice_5 <-  as.numeric(data_json_spring_boot_microservice_5$data$result$values[[1]][,2]) / (1024 * 1024)

values_flask_monolith <-        as.numeric(data_json_flask_monolith$data$result$values[[1]][,2]) / (1024 * 1024)
values_flask_microservice_1 <-  as.numeric(data_json_flask_microservice_1$data$result$values[[1]][,2]) / (1024 * 1024)
values_flask_microservice_2 <-  as.numeric(data_json_flask_microservice_2$data$result$values[[1]][,2]) / (1024 * 1024)
values_flask_microservice_3 <-  as.numeric(data_json_flask_microservice_3$data$result$values[[1]][,2]) / (1024 * 1024)
values_flask_microservice_4 <-  as.numeric(data_json_flask_microservice_4$data$result$values[[1]][,2]) / (1024 * 1024)
values_flask_microservice_5 <-  as.numeric(data_json_flask_microservice_5$data$result$values[[1]][,2]) / (1024 * 1024)



#####################################################
#     Sum usage resources data for microservices    #
#####################################################
values_dotnet_microservices_all <- c()
for (x in 1:length(values_dotnet_microservice_1)) {
  val_1 <- values_dotnet_microservice_1[x]
  val_2 <- values_dotnet_microservice_2[x]
  val_3 <- values_dotnet_microservice_3[x]
  val_4 <- values_dotnet_microservice_4[x]
  val_5 <- values_dotnet_microservice_5[x]
  val <- val_1 + val_2 + val_3 + val_4 + val_5
  values_dotnet_microservices_all <- c(values_dotnet_microservices_all, val)
}

values_spring_boot_microservices_all <- c()
for (x in 1:length(values_spring_boot_microservice_1)) {
  val_1 <- values_spring_boot_microservice_1[x]
  val_2 <- values_spring_boot_microservice_2[x]
  val_3 <- values_spring_boot_microservice_3[x]
  val_4 <- values_spring_boot_microservice_4[x]
  val_5 <- values_spring_boot_microservice_5[x]
  val <- val_1 + val_2 + val_3 + val_4 + val_5
  values_spring_boot_microservices_all <- c(values_spring_boot_microservices_all, val)
}

values_flask_microservices_all <- c()
for (x in 1:length(values_flask_microservice_1)) {
  val_1 <- values_flask_microservice_1[x]
  val_2 <- values_flask_microservice_2[x]
  val_3 <- values_flask_microservice_3[x]
  val_4 <- values_flask_microservice_4[x]
  val_5 <- values_flask_microservice_5[x]
  val <- val_1 + val_2 + val_3 + val_4 + val_5
  values_flask_microservices_all <- c(values_flask_microservices_all, val)
}



#######################################
#      Convert data to data.frame     #
#######################################
df_dotnet_monolith <-           data.frame(technology = "dotnet",      architecture = "monolith",      value = values_dotnet_monolith,               check.names=FALSE)
df_dotnet_microservices <-      data.frame(technology = "dotnet",      architecture = "microservices", value = values_dotnet_microservices_all,      check.names=FALSE)
df_spring_boot_monolith <-      data.frame(technology = "spring boot", architecture = "monolith",      value = values_spring_boot_monolith,          check.names=FALSE)
df_spring_boot_microservices <- data.frame(technology = "spring boot", architecture = "microservices", value = values_spring_boot_microservices_all, check.names=FALSE)
df_flask_monolith <-            data.frame(technology = "flask",       architecture = "monolith",      value = values_flask_monolith,                check.names=FALSE)
df_flask_microservices <-       data.frame(technology = "flask",       architecture = "microservices", value = values_flask_microservices_all,       check.names=FALSE)

parsed_data <- union_all(df_dotnet_monolith, df_dotnet_microservices)
parsed_data <- union_all(parsed_data, df_spring_boot_monolith)
parsed_data <- union_all(parsed_data, df_spring_boot_microservices)
parsed_data <- union_all(parsed_data, df_flask_monolith)
parsed_data <- union_all(parsed_data, df_flask_microservices)



#######################################
#                 Plot                #
#######################################
p1 <- ggplot(data = parsed_data, aes(x = architecture, y = value, fill = technology)) +
  geom_boxplot() +
  labs(title = title, y = y_label, x = "architecture") +
  #ylim(0, 100)

png(file=paste(output_file_name, sep = ""), width = 500, height= 400)
print(p1)
dev.off()
