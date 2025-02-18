% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RcppExports.R
\name{calc_inv}
\alias{calc_inv}
\title{Calculate the shrinkage inverse of a \emph{matrix} of data using Singular
Value Decomposition (\emph{SVD}).}
\usage{
calc_inv(tseries, eigen_thresh = 0.01, eigen_max = 0L)
}
\arguments{
\item{\code{tseries}}{A \emph{time series} or \emph{matrix} of data.}

\item{\code{eigen_thresh}}{A \emph{numeric} threshold level for discarding
small singular values in order to regularize the inverse of the
matrix \code{tseries} (the default is \code{0.01}).}

\item{\code{eigen_max}}{An \emph{integer} equal to the number of singular
values used for calculating the shrinkage inverse of the matrix
\code{tseries} (the default is \code{eigen_max = 0} - equivalent to
\code{eigen_max} equal to the number of columns of \code{tseries}).}
}
\value{
A \emph{matrix} equal to the shrinkage inverse of the matrix
  \code{tseries}.
}
\description{
Calculate the shrinkage inverse of a \emph{matrix} of data using Singular
Value Decomposition (\emph{SVD}).
}
\details{
The function \code{calc_inv()} calculates the shrinkage inverse of the
  matrix \code{tseries} using Singular Value Decomposition (\emph{SVD}).
  
  The function \code{calc_inv()} first performs Singular Value Decomposition
  (\emph{SVD}) of the matrix \code{tseries}.  
  The \emph{SVD} of a matrix \eqn{\strong{A}} is defined as the
  factorization:
  \deqn{
    \strong{A} = \strong{U}  \, \Sigma  \, \strong{V}^T
  }
  Where \eqn{\strong{U}} and \eqn{\strong{V}} are the left and right
  \emph{singular matrices}, and \eqn{\Sigma} is a diagonal matrix of
  \emph{singular values} \eqn{\Sigma = \{\sigma_i\}}.
  
  The inverse \eqn{\strong{A}^{-1}} of the matrix \eqn{\strong{A}} can be
  calculated from the \emph{SVD} matrices as:
  \deqn{
    \strong{A}^{-1} = \strong{V} \, \Sigma^{-1} \, \strong{U}^T
  }
  
  The \emph{regularized inverse} of the matrix \eqn{\strong{A}} is given by:
  \deqn{
    \strong{A}^{-1} = \strong{V}_n \, \Sigma_n^{-1} \, \strong{U}_n^T
  }
  Where \eqn{\strong{U}_n}, \eqn{\strong{V}_n} and \eqn{\Sigma_n} are the
  \emph{SVD} matrices with the rows and columns corresponding to zero
  \emph{singular values} removed.
  
  The function \code{calc_inv()} applies regularization by discarding the
  smallest singular values \eqn{\sigma_i} that are less than the threshold
  level \code{eigen_thresh} times the sum of all the singular values:
  \deqn{\sigma_i < eigen\_thresh \cdot (\sum{\sigma_i})}
  
  It then discards additional singular values so that only the largest
  \code{eigen_max} singular values remain.  
  It calculates the shrinkage inverse from the \emph{SVD} matrices using
  only the largest singular values up to \code{eigen_max}.  For example, if
  \code{eigen_max = 3} then it only uses the \code{3} largest singular
  values. This has the effect of dimension shrinkage.
  
  If the matrix \code{tseries} has a large number of small singular values,
  then the number of remaining singular values may be less than
  \code{eigen_max}.
}
\examples{
\dontrun{
# Calculate ETF returns
returns <- na.omit(rutils::etfenv$returns)
# Calculate covariance matrix
covmat <- cov(returns)
# Calculate shrinkage inverse using RcppArmadillo
invmat <- HighFreq::calc_inv(covmat, eigen_max=3)
# Calculate shrinkage inverse from SVD in R
svdec <- svd(covmat)
eigen_max <- 1:3
invsvd <- svdec$v[, eigen_max] \%*\% (t(svdec$u[, eigen_max]) / svdec$d[eigen_max])
# Compare RcppArmadillo with R
all.equal(invmat, invsvd)
}

}
