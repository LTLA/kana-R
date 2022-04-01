#' Write contents for quality control
#'
#' Write quality control-related contents to the HDF5 state file.
#'
#' @param dir String containing the working directory for preparing the \pkg{kana} output.
#' @param metrics List containing \code{sums}, \code{detected} and \code{proportions},
#' which are numeric, integer and numeric vectors, respectively, of length equal to the number of cells.
#' @param thresholds List containing \code{sums}, \code{detected} and \code{proportions}, 
#' all of which are numeric vectors of length equal to the number of samples.
#' @param discards Logical vector of length equal to the number of cells.
#' @param use_mito_default,mito_prefix,nmads Parameters for the \pkg{kana} analysis.
#'
#' @return The QC contents are written to file.
#' A \code{NULL} is invisibly returned.
#'
#' @details
#' See \url{https://ltla.github.io/kanaval/quality__control_8hpp.html} for details.
#'
#' @author Aaron Lun
#'
#' @examples
#' dir <- initializeWrite()
#' writeQualityControl(dir, 
#'     metrics = list(
#'         sums = runif(100), 
#'         detected = sample(1000, 100), 
#'         proportions = runif(100)
#'     ),
#'     thresholds = list(
#'         sums = runif(2), 
#'         detected = sample(1000, 2), 
#'         proportions = runif(2)
#'     ),
#'     discards = rbinom(100, 1, 0.5) == 0
#' )
#'
#' @export
#' @import rhdf5
writeQualityControl <- function(dir, metrics, thresholds, discards, use_mito_default = TRUE, mito_prefix = "mt-", nmads = 3) {
    path <- file.path(dir, state.name)
    h5createGroup(path, "quality_control")

    h5createGroup(path, "quality_control/parameters")
    write_integer_scalar(path, "quality_control/parameters", "use_mito_default", as.integer(use_mito_default))
    write_string_scalar(path, "quality_control/parameters", "mito_prefix", as.character(mito_prefix))
    write_double_scalar(path, "quality_control/parameters", "nmads", as.double(nmads))

    h5createGroup(path, "quality_control/results")
    for (field in c("metrics", "thresholds")) {
        h5createGroup(path, paste0("quality_control/results/", field))

        if (field == "metrics") {
            y <- metrics
        } else {
            y <- thresholds
        }

        for (x in c("sums", "proportions")) {
            h5write(as.double(y[[x]]), path, paste0("quality_control/results/", field, "/", x))
        }
        h5write(as.integer(y[["detected"]]), path, paste0("quality_control/results/", field, "/", x))
    }

    h5write(as.integer(discards), path, "quality_control/results/discards")
    return(NULL)
}
