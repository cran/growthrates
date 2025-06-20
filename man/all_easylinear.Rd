% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/all_easylinear.R
\name{all_easylinear}
\alias{all_easylinear}
\alias{all_easylinear.formula}
\alias{all_easylinear.data.frame}
\title{Easy Growth Rates Fit to data Frame}
\usage{
all_easylinear(...)

\method{all_easylinear}{formula}(formula, data, h = 5, quota = 0.95, subset = NULL, ...)

\method{all_easylinear}{data.frame}(
  data,
  grouping,
  time = "time",
  y = "value",
  h = 5,
  quota = 0.95,
  ...
)
}
\arguments{
\item{\dots}{generic parameters, reserved for future extensions.}

\item{formula}{model formula specifying dependent, independent and grouping
variables in the form:
\code{dependent ~ independent | group1 + group2 + \dots}.}

\item{data}{data frame of observational data.}

\item{h}{with of the window (number of data).}

\item{quota}{part of window fits considered for the overall linear fit
(relative to max. growth rate).}

\item{subset}{a specification of the rows to be used: defaults to all rows.}

\item{grouping}{model formula or character vector of criteria defining
subsets in the data frame.}

\item{time}{character vectors with name independent variabl.e.}

\item{y}{character vector with name of dependent variable}
}
\value{
object with parameters of all fits.
}
\description{
Determine maximum growth rates from log-linear part of the growth curve for
a series of experiments.
}
\examples{

\donttest{
library("growthrates")
L <- all_easylinear(value ~ time | strain + conc + replicate, data=bactgrowth)
summary(L)
coef(L)
rsquared(L)

results <- results(L)

library(lattice)
xyplot(mumax ~ conc|strain, data=results)
}

}
\references{
Hall, BG., Acar, H, Nandipati, A and Barlow, M (2014) Growth Rates Made Easy.
Mol. Biol. Evol. 31: 232-38, \doi{10.1093/molbev/mst187}
}
\seealso{
Other fitting functions: 
\code{\link{all_growthmodels}()},
\code{\link{all_splines}()},
\code{\link{fit_easylinear}()},
\code{\link{fit_growthmodel}()},
\code{\link{fit_spline}()}
}
\concept{fitting functions}
