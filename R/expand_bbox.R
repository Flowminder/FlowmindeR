
#' Function to extract bounding box of object
#' Useful for clipping basemaps to study region
#' @export
#'
expand_bbox <- function(shapefile, expand = 0.1, equal = T){

  # Extract BBOX buffer
  bbox_input <- sf::st_bbox(shapefile)

  # Calculate dimensions
  width <- as.numeric(bbox_input[3] - bbox_input[1])
  height <- as.numeric(bbox_input[4] - bbox_input[2])

  # Correct dimensions if requested
  if(equal){

    # Function rescales the Y axis based on how far it is from equator to account WGS projection distortion
    # Creates a square bounding box
    correction <- function(x) 1/cos(x * pi/180)

    # Calculates y centre point
    y_centroid <- as.numeric((bbox_input[4] + bbox_input[2])/2)

    desired_width <- height * correction(y_centroid)
    desired_height <- width / correction(y_centroid)

    # Only one of these numbers will be positive
    width_diff <- desired_width - width
    height_diff <- desired_height - height

    if(width_diff > height_diff){
      bbox_input[3] <- bbox_input[3] + width_diff/2
      bbox_input[1] <- bbox_input[1] - width_diff/2
    }
    if(height_diff > width_diff){
      bbox_input[4] <- bbox_input[4] + height_diff/2
      bbox_input[2] <- bbox_input[2] - height_diff/2
    }

  }

  # crop tiles to boundaries with buffer:
  bbox <-
    st_as_sfc(st_bbox(bbox_input)) %>%
    st_buffer(width * expand) %>%
    as("Spatial")

  return(bbox)

}
