#' Start the writing process
#'
#' Set up the staging directory and state file for creating a \pkg{kana} file.
#'
#' @param dir String containing the path to a staging directory.
#' Any existing file at that location is deleted and \code{dir} is created.
#'
#' @return String containing a path to a configured staging directory.
#' 
#' @author Aaron Lun
#' @examples
#' dir <- initializeWrite()
#' list.files(dir)
#' 
#' @export
#' @import rhdf5
initializeWrite <- function(dir = tempfile()) {
    if (file.exists(dir)) {
        unlinK(dir, recursive=TRUE)
    }
    dir.create(dir, recursive=TRUE, showWarnings = FALSE)
    h5createFile(file.path(dir, state.name))
    return(invisible(dir))
}
