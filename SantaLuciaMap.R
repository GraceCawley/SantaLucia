# Load the necessary libraries
library(png)
library(ggplot2)

# Load the image
img_path <- "~/Desktop/Santa Lucia Part 2/santalucia2.png"
img <- readPNG(img_path)

# Define the plot dimensions based on the provided area of interest
lon_min <- -123.02901
lon_max <- -120.10116
lat_min <- 34.08049
lat_max <- 35.94295

# Create the data frame with your coordinates
data <- data.frame(
  Label = c("9", "8", "7", "4", "6", "5", "1", "2", "3", "Davidson Seamount"),
  Latitude = c(35.1806, 35.1806, 35.1806, 34.9109, 34.9109, 34.9109, 34.6413, 34.6413, 34.6413, 35.7167),
  Longitude = c(-121.47, -121.8, -122.13, -122.13, -121.47, -121.8, -122.13, -121.8, -121.47, -122.7167)
)

# Add Arguello Canyon points to the data frame
arguello_canyon <- data.frame(
  Label = c("Arguello 1", "Arguello 2", "Arguello 3"),
  Latitude = c(34.5400, 34.350, 34.1000),
  Longitude = c(-120.700, -121.100, -121.295)
)

data <- rbind(data, arguello_canyon)

# Set plot parameters to remove margins and axis space
par(mar = c(5, 5, 1, 1), oma = c(0, 0, 0, 0), xaxs='i', yaxs='i')

# Plot the image with axis labels
plot(1, type = "n", xlim = c(lon_min, lon_max), ylim = c(lat_min, lat_max), xlab = "Longitude", ylab = "Latitude", asp = 1)
rasterImage(img, lon_min, lat_min, lon_max, lat_max)

# Overlay the points with yellow squares for all stations except Davidson Seamount
points(data$Longitude[data$Label != "Davidson Seamount"], data$Latitude[data$Label != "Davidson Seamount"], 
       col = "yellow", pch = 22, bg = "yellow", cex = 2)

# Overlay the Davidson Seamount point as a star
points(data$Longitude[data$Label == "Davidson Seamount"], data$Latitude[data$Label == "Davidson Seamount"], 
       col = "purple", pch = 8, cex = 4)

# Overlay Arguello Canyon points with green triangles
points(data$Longitude[grepl("Arguello", data$Label)], data$Latitude[grepl("Arguello", data$Label)], 
       col = "green", pch = 24, bg = "green", cex = 2)

# Add the station numbers inside the boxes
text(data$Longitude[data$Label != "Davidson Seamount" & !grepl("Arguello", data$Label)], 
     data$Latitude[data$Label != "Davidson Seamount" & !grepl("Arguello", data$Label)], 
     labels = data$Label[data$Label != "Davidson Seamount" & !grepl("Arguello", data$Label)], cex = 0.7, col = "black", font = 2)

# Add the Davidson Seamount label in white
text(data$Longitude[data$Label == "Davidson Seamount"], data$Latitude[data$Label == "Davidson Seamount"], 
     labels = data$Label[data$Label == "Davidson Seamount"], cex = 0.7, col = "white", font = 2)

# Add Arguello Canyon labels
text(data$Longitude[grepl("Arguello", data$Label)], data$Latitude[grepl("Arguello", data$Label)], 
     labels = data$Label[grepl("Arguello", data$Label)], cex = 0.7, col = "black", font = 2)