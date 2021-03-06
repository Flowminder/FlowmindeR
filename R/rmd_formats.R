#' HTML Output for Flowminder Reports
#'
#' Uses bookdown package to allow cross-referencing. Specifies many defaults,
#'   including floating table of contents, code folding and styling.
#'
#' @param toc TRUE/FALSE (default TRUE). Display a table of contents
#' @param code_folding "show", "hide", or FALSE to change code display behaviour
#' @param self_contained Produce a standalone HTML file with no external dependencies, using data: URIs to incorporate the contents of linked scripts, stylesheets, images, and videos. Set as FALSE if the file size increases as Git cannot handle binary functions very efficiently.
#' @param ... additional arguments which can be parsed by the html_document function
#'
#' @seealso  \code{\link[rmarkdown]{html_document}}
#'
#' @export
#' @author Michael Harper
#'
fm_html <- function(toc = TRUE, code_folding = "hide",  number_sections = FALSE, self_contained = TRUE, ...) {

  # get the locations of resource files located within the package
  #css <- system.file("reports/styles.css", package = "mypackage")
  footer <- system.file("rmarkdown/resources/elements/footer.html", package = "FlowmindeR")
  header <- system.file("rmarkdown/resources/elements/header.html", package = "FlowmindeR")
  css <- system.file("rmarkdown/resources/style.css", package = "FlowmindeR")
  theme_css <- system.file("rmarkdown/resources/elements/bootstrap_custom.css", package = "FlowmindeR")

  # call the base html_document function
  bookdown::html_document2(toc = toc,
                           fig_caption = TRUE,
                           number_sections = number_sections,
                           self_contained = self_contained,
                           collapsed = FALSE,
                           toc_float = TRUE,
                           code_folding = code_folding,
                           css = list(css, theme_css),
                           includes = rmarkdown::includes(after_body = footer, before_body = header),
                           ...)
}

#' Word Output for Flowminder Reports
#'
#' Uses bookdown package to allow cross-referencing. Uses the styles reference
#'  file `mystyles.docx` stored in directory `inst/rmarkdown/templates/elements`
#'  to define custom styling.
#'
#' @param toc TRUE/FALSE (default TRUE). Display a table of contents
#' @param toc_depth the depth of the table of contents. Default is 2
#' @param ... additional arguments which can be parsed by the word_document function
#'
#' @seealso  \code{\link[rmarkdown]{word_document}}
#'
#' @author Michael Harper
#' @export
#'
fm_word <- function(toc = TRUE, toc_depth = 2, ...) {

  # get the locations of resource files located within the package
  #css <- system.file("reports/styles.css", package = "mypackage")
  style <- system.file("resources/elements/mystyles.docx", package = "FlowmindeR")

  # call the base html_document function
  bookdown::word_document2(toc = toc,
                           fig_width = 6,
                           fig_height = 4,
                           fig_caption = TRUE,
                           reference_docx = style,
                           ...)
}



#' PDF Output for Flowminder Reports
#'
#' A custom report style to fromat the output of R Markdown reports.
#'  Uses bookdown's \code{pdf_document2} as the base format to allow
#'  cross-referencing and other improvements.
#'
#'  Lower level LaTeX YAML settings are specified in an external file. This
#'  controls the document paper size, margins, and other layout options.
#'
#' @param toc TRUE/FALSE (default TRUE). Display a table of contents
#' @param toc_depth the depth of the table of contents. Default is 2
#' @param ... additional arguments which can be parsed by the word_document function
#'
#' @seealso  \code{\link[rmarkdown]{pdf_document}}
#'
#' @author Michael Harper
#' @export
#'
fm_pdf <- function(toc = FALSE, toc_depth = 2, number_sections = FALSE, latex_engine= "pdflatex", extra_tex = "", ...) {

  # get the locations of resource files located within the package
  header <- system.file("rmarkdown/resources/preamble.tex", package = "FlowmindeR")
  filePathImages <- system.file("rmarkdown/resources", package = "FlowmindeR")
  updatedHeader <- stringr::str_replace(readLines(header), "LOCALFILEPATH", filePathImages)

  # Allow additional LaTeX to be added to header
  updatedHeader <- c(updatedHeader, extra_tex)

  tempTex <- tempfile(pattern = "file", fileext = ".tex")
  writeLines(text = updatedHeader, tempTex)

  # call the base html_document function
  bookdown::pdf_document2(toc = toc,
                          latex_engine= latex_engine,
                          number_sections = number_sections,
                          toc_depth= toc_depth,
                          fig_caption= TRUE,
                          includes = rmarkdown::includes(in_header = tempTex),
                          ...)

}
