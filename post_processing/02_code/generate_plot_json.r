library(ggplot2)
library(jsonlite)
library(stringr)
library("optparse")

############################## FUNCTIONS #####################################

load_data <- function(file) {
  
  #load data from json - only values (this part of the code --> [[1]][,2]) - no timestamps
  json_data <- fromJSON(file, flatten = TRUE)
  tmp <- as.numeric(json_data$data$result$values[[1]][,2])
 
  
  #inserting data from the file
  parsed_data <- data.frame(data = tmp, check.names=FALSE)

  return(parsed_data)
  
}

draw_plot <- function(parsed_data, title="plot", y ="", x ="", destination) {
  png(file=destination)
  
  plot <- ggplot(data = parsed_data, aes(x = "", y = data)) +
    geom_boxplot(fill = c("lightgreen")) +
    xlab(x) +
    ylab(y) +
    ggtitle(title)
  
  print(plot)
  dev.off()

}

############################### CODE #########################################

option_list = list(
  make_option(c("-f", "--file"), type="character", default=NULL, 
              help="Path of the input file", metavar="character"),
  make_option(c("-t", "--technology"), type="character", default="", 
              help="Name of the technology (eg. Spring Boot)", metavar="character"),
  make_option(c("-T", "--title"), type="character", default="Plot", 
              help="Plot title [default= %default]", metavar="character"),
  make_option(c("-y", "--ylab"), type="character", default="Value", 
              help="Y axis label (eg. 'CPU Usage [%]') [default= %default]", metavar="character"),
  make_option(c("-d", "--destination"), type="character", default="./03_output/Plot.png", 
              help="Path of the output file (eg. /home/plot.png)", metavar="character")
); 

opt_parser = OptionParser(option_list=option_list);
opt = parse_args(opt_parser);

if (is.null(opt$file)) {
  print_help(opt_parser)
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
}

#parsing the file % printing the plot
parsed_data <- load_data(file = opt$file)
draw_plot(parsed_data, opt$title, opt$ylab, opt$technology, opt$destination)