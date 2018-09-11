#' Produce reports
#'
#' Produce html reports from a rmd file. It's mainly a wrapper arrond [rmarkdown::render()]
#'
#' @return Return invisibly the file path of the produced report
#' @param rmd name of the rmd file
#' @param n_file prefix numbering of the output file
#' @param open_file open the html file in the default browser once produced. By default, `TRUE`.
#' @param report_dir target directory for the reports
#' @param rmds_dir source directery for the `.Rmds` files. By default, the directory *rmds*.
#' @export
#' @importFrom rmarkdown render
#' @md
#'
report <- function(rmd, n_file, open_file = TRUE,
                   report_dir = here("docs"), rmds_dir = here()) {

  if(!require(rmarkdown)) stop("Install rmarkdown package")

  rmd_path <- file.path(rmds_dir, rmd)

  # Generate the file name (without number) based on rmd file
  base_name <- sub(pattern = ".Rmd", replacement = "", x = basename(rmd_path))
  html_name <- paste0(base_name, ".html")

  if(missing(n_file)){
    file_name <- html_name
  } else {
    # Make nfiles with always 2 digits
    n_file <- ifelse(as.integer(n_file) < 10, paste0("0", n_file), n_file)
    file_name <- paste0(n_file, "-", html_name)
  }

  # Produce the file. Simple wrapper of the render function
  rmarkdown::render(
    input = rmd_path,
    encoding = "UTF-8",
    output_format = html_document(
      toc = TRUE,
      toc_depth = 2,
      toc_float = TRUE,
      code_folding = "hide",
      theme = "spacelab",
      df_print = "paged"
    ),
    output_file = file_name,
    output_dir = report_dir,
    envir = new.env()
  )

  result_path <- file.path(report_dir, file_name)

  if(open_file) browseURL(result_path)

  invisible(result_path)
}
