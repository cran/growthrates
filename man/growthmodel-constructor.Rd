% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/aab_growthmodel-constructor.R
\name{growthmodel}
\alias{growthmodel}
\alias{user-defined}
\alias{functions}
\title{Create a User-defined Parametric Growth Model}
\usage{
growthmodel(x, pnames = NULL)
}
\arguments{
\item{x}{a function with arguments \code{times} and \code{parms}, and
returning a matrix with two columns \code{time} and \code{y}.}

\item{pnames}{character vector with the names of the model parameters.}
}
\description{
This constructor method allows to create user-defined functions
  that can be used as parametric models describing time-dependent
  growth of organisms.
}
\details{
Package \pkg{growthrates} has a plug-in architecture allowing
  user-defined growth models of the following form:

\preformatted{
  identifier <- function(time, parms) {
    ... content of function here ...
    return(as.matrix(data.frame(time=time, y=y)))
  }
}

where \code{time} is a numeric vector and \code{parms} a named, non-nested
    list of model parameters. The constructor function \code{growthmodel}
    is used to attach the names of the parameters as an optional
    attribute.
}
\examples{

test <- function(time, parms) {
  with(as.list(parms), {
    y <- (K * y0) / (y0 + (K - y0) * exp(-mumax * time)) + y_shift
    return(as.matrix(data.frame(time=time, y=y)))
 })
}

mygrowthmodel <- growthmodel(test, c("y0", "mumax", "K", "y_shift"))


}
\seealso{
Other growth models: 
\code{\link{grow_baranyi}()},
\code{\link{grow_exponential}()},
\code{\link{grow_gompertz}()},
\code{\link{grow_gompertz2}()},
\code{\link{grow_huang}()},
\code{\link{grow_logistic}()},
\code{\link{grow_richards}()},
\code{\link{ode_genlogistic}()},
\code{\link{ode_twostep}()}
}
\concept{growth models}
