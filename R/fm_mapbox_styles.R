

#' Helper function for basemaps
#'
#' @export
fm_mapbox_styles <- function(style = c("basic", "no borders")){

  styles <- list(basic = "https://api.mapbox.com/styles/v1/michaelharper/ck9odvbw20vxv1ilqm5pzzpxf/tiles/512/{zoom}/{x}/{y}",
                 "no borders" = "https://api.mapbox.com/styles/v1/michaelharper/ck9twyfhl0s3u1itk09h3fnah/tiles/512/{zoom}/{x}/{y}",
                 "no names" = "https://api.mapbox.com/styles/v1/michaelharper/ck9u0ihkg0vhg1jqfijqmrsp1/tiles/512/{zoom}/{x}/{y}")


  return(styles[[style]])
}

