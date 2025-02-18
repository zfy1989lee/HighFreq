% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/HighFreq.R
\name{season_ality}
\alias{season_ality}
\title{Perform seasonality aggregations over a single-column \emph{xts} time series.}
\usage{
season_ality(xtes, indeks = format(zoo::index(xtes), "\%H:\%M"))
}
\arguments{
\item{\code{xtes}}{A single-column \emph{xts} time series.}

\item{\code{indeks}}{A vector of \emph{character} strings representing points in
time, of the same length as the argument \code{xtes}.}
}
\value{
An \emph{xts} time series with mean aggregations over the seasonality
  interval.
}
\description{
Perform seasonality aggregations over a single-column \emph{xts} time series.
}
\details{
The function \code{season_ality()} calculates the mean of values
  observed at the same points in time specified by the argument
  \code{indeks}. An example of a daily seasonality aggregation is the average
  price of a stock between 9:30AM and 10:00AM every day, over many days. The
  argument \code{indeks} is passed into function \code{tapply()}, and must be
  the same length as the argument \code{xtes}.
}
\examples{
# Calculate running variance of each minutely OHLC bar of data
xtes <- ohlc_variance(HighFreq::SPY)
# Remove overnight variance spikes at "09:31"
indeks <- format(index(xtes), "\%H:\%M")
xtes <- xtes[!indeks=="09:31", ]
# Calculate daily seasonality of variance
var_seasonal <- season_ality(xtes=xtes)
chart_Series(x=var_seasonal, name=paste(colnames(var_seasonal),
  "daily seasonality of variance"))
}
