\name{renderWeather}
\alias{renderWeather}
\title{Download and parse weather for a weatherWidgetOutput element}
\usage{
  renderWeather(woeid = 3369, units = "f", refresh = 15, session)
}
\arguments{
  \item{woeid}{The "Where On Earth" ID of the location you
  want to monitor. You can look up this ID at
  \url{http://woeid.rosselliot.co.nz}.}

  \item{refresh}{the frequency (in minutes) to use when
  refreshing the widget.}

  \item{session}{The session in which this reactive
  function is operating.}
}
\description{
  Download and parse weather for a weatherWidgetOutput
  element
}
\author{
  Jeff Allen <jeff.allen@trestletechnology.net>
}
\seealso{
  \code{\link{weatherWidgetOutput}}
}

