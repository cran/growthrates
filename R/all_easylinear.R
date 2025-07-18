#' Easy Growth Rates Fit to data Frame
#'
#' Determine maximum growth rates from log-linear part of the growth curve for
#' a series of experiments.
#'
#' @param formula model formula specifying dependent, independent and grouping
#'   variables in the form:
#'   \code{dependent ~ independent | group1 + group2 + \dots}.
#' @param data data frame of observational data.
#' @param time character vectors with name independent variabl.e.
#' @param y character vector with name of dependent variable
#' @param grouping model formula or character vector of criteria defining
#'   subsets in the data frame.
#' @param h with of the window (number of data).
#' @param quota part of window fits considered for the overall linear fit
#'   (relative to max. growth rate).
#' @param subset a specification of the rows to be used: defaults to all rows.
#' @param \dots generic parameters, reserved for future extensions.
#'
#' @return object with parameters of all fits.
#'
#' @references Hall, BG., Acar, H, Nandipati, A and Barlow, M (2014) Growth Rates Made Easy.
#' Mol. Biol. Evol. 31: 232-38, \doi{10.1093/molbev/mst187}
#'
#' @family fitting functions
#'
#' @examples
#'
#' \donttest{
#' library("growthrates")
#' L <- all_easylinear(value ~ time | strain + conc + replicate, data=bactgrowth)
#' summary(L)
#' coef(L)
#' rsquared(L)
#'
#' results <- results(L)
#'
#' library(lattice)
#' xyplot(mumax ~ conc|strain, data=results)
#' }
#'
#' @rdname all_easylinear
#' @export
#'
all_easylinear <- function(...) UseMethod("all_easylinear")


#' @rdname all_easylinear
#' @export
#'
all_easylinear.formula <- function(formula, data,  h = 5, quota = 0.95,
                                   subset = NULL, ...) {

  ## force data frame if user enters a tibble
  if (inherits(data, "tbl_df")) data <- as.data.frame(data)

  X <- get_all_vars(formula, data)
  if (!is.null(subset)) X <- X[subset, ]
  all_easylinear.data.frame(data = X, grouping = formula, h = h, quota = quota)
}


#' @rdname all_easylinear
#' @export
#'
all_easylinear.data.frame <-
  function(data, grouping, time = "time", y = "value",  h = 5, quota = 0.95, ...) {

    ## force data frame if user enters a tibble
    if (inherits(data, "tbl_df")) data <- as.data.frame(data)

    splitted.data <- multisplit(data, grouping)

    ## todo: consider to attach parsed formula as attr to splitted.data
    if (inherits(grouping, "formula")) {
      p <- parse_formula(grouping)
      time     <- p$timevar
      y        <- p$valuevar
      grouping <- p$groups
    }

    ## suppress warnings, esp. in case of "perfect fit"
    #fits <- lapply(splitted.data,
    #               function(tmp)
    #                 suppressWarnings(fit_easylinear(
    #                   tmp[,time], tmp[,y], h = h, quota = quota
    #                 )))

    ## suppress only "perfect fit" warning
    fits <- lapply(splitted.data,
                   function(tmp) {
                     withCallingHandlers({
                       fit_easylinear(tmp[,time], tmp[,y], h = h, quota = quota)
                     }, warning = function(w) {
                       if (startsWith(conditionMessage(w),
                         "essentially perfect fit")) invokeRestart("muffleWarning")
                     })
                   })

    new("multiple_easylinear_fits", fits = fits, grouping = grouping)
  }
