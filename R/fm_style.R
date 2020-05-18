#' Set FM ggplot theme
#'
#' This function allows you to set the ggplot theme of your graphics
#'
#'  @param ... additional arguments which are processed by the `theme` argument
#'   of ggplot
#'
#' @keywords fm_style
#' @export
#' @examples
#' set_fm_style()

set_fm_style <- function(...) {

  # Set theme
  ggthemr::ggthemr("fresh")
  ggthemr::set_swatch(c("#ADD8A4", "#095798", "#9D8C70", "#BDAC90", "#2977B8", "#C11D1D", "#FAAD61"))

  # define reused style for graphs
  ggplot2::theme_update(
    panel.background = ggplot2::element_rect(fill = "grey97"),
    plot.title = ggplot2::element_text(family = "Merriweather Bold", size = ggplot2::rel(1)),
    legend.justification = c(1, 1),
    legend.spacing.y = ggplot2::unit(0.5, "cm"),
    legend.key.size = ggplot2::unit(0.3, "cm"),
    plot.subtitle = ggplot2::element_text(hjust = 0, face = "italic", size = ggplot2::rel(0.9), colour = "grey60"),
    ...
  )
}

