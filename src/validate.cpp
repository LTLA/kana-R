#include "Rcpp.h"
#include "kanaval/validate.hpp"

//[[Rcpp::export(rng=false)]]
SEXP validate_(std::string path, bool embedded, int version) {
    H5::H5File handle(path, H5F_ACC_RDONLY);
    kanaval::validate(handle, embedded, version);
    return R_NilValue;
}
