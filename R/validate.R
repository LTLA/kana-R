#' Validate a state file
#'
#' Validate the HDF5 state file embedded in the kana file.
#'
#' @param path String containing the path to the HDF5 file.
#' @param embedded Logical scalar indicating whether the input files were embedded into the kana file.
#' If \code{FALSE}, it is assumed that they were linked from an external resource.
#' @param version Version number for the kana file.
#'
#' @return \code{NULL} if there are no problems, otherwise an error is raised.
#'
#' @author Aaron Lun
#'
#' @seealso
#' See \url{https://ltla.github.io/kanaval} for the specification.
#'
#' @export
#' @importFrom Rcpp sourceCpp
#' @useDynLib kana.parser, .registration=TRUE
validate <- function(path, embedded = TRUE, version = "1.1.0") {
    stopifnot(length(path)==1, is.character(path), !is.na(path))
    path <- normalizePath(path, mustWork=TRUE)

    stopifnot(length(embedded)==1, is.logical(embedded), !is.na(embedded))

    version <- package_version(version)
    stopifnot(version >= package_version("1.0.0"))
    version <- version$major * 1000000L + version$minor * 1000L + version$patch
    stopifnot(length(version)==1, is.integer(version), !is.na(version))

    validate_(path, embedded, version)
}
