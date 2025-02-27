% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/validate.R
\name{validate}
\alias{validate}
\title{Validate a state file}
\usage{
validate(path, embedded = TRUE, version = "1.1.0")
}
\arguments{
\item{path}{String containing the path to the HDF5 file.}

\item{embedded}{Logical scalar indicating whether the input files were embedded into the kana file.
If \code{FALSE}, it is assumed that they were linked from an external resource.}

\item{version}{Version number for the kana file.}
}
\value{
\code{NULL} if there are no problems, otherwise an error is raised.
}
\description{
Validate the HDF5 state file embedded in the kana file.
}
\seealso{
See \url{https://ltla.github.io/kanaval} for the specification.
}
\author{
Aaron Lun
}
