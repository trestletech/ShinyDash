lookupIconName <- function(code){
  switch(as.character(code), 
         "0"='tornado',
         "1"='tornado',
         "2"='tornado',
         "3"='lightning',
         "4"='lightning',
         "5"='snow',
         "6"='sleet',
         "7"='snow',
         "8"='drizzle',
         "9"='drizzle',
         "10"='sleet',
         "11"='rain',
         "12"='rain',
         "13"='snow',
         "14"='snow',
         "15"='snow',
         "16"='snow',
         "17"='hail',
         "18"='sleet',
         "19"='haze',
         "20"='fog',
         "21"='haze',
         "22"='haze',
         "23"='wind',
         "24"='wind',
         "25"='thermometer low',
         "26"='cloud',
         "27"='cloud moon',
         "28"='cloud sun',
         "29"='cloud moon',
         "30"='cloud sun',
         "31"='moon',
         "32"='sun',
         "33"='moon',
         "34"='sun',
         "35"='hail',
         "36"='thermometer full',
         "37"='lightning',
         "38"='lightning',
         "39"='lightning',
         "40"='rain',
         "41"='snow',
         "42"='snow',
         "43"='snow',
         "44"='cloud',
         "45"='lightning',
         "46"='snow',
         "47"='lightning')
}

#' Download and parse weather for a weatherWidgetOutput element
#' @param woeid The "Where On Earth" ID of the location you want to monitor. 
#' You can look up this ID at \url{http://woeid.rosselliot.co.nz}.
#' @param refresh the frequency (in minutes) to use when refreshing the widget.
#' @param session The session in which this reactive function is operating.
#' @seealso \code{\link{weatherWidgetOutput}}
#' @importFrom httr GET
#' @importFrom httr content
#' @importFrom XML xmlAttrs
#' @importFrom XML xmlRoot
#' @author Jeff Allen <jeff.allen@@trestletechnology.net>
#' @export
renderWeather <- function (woeid=3369, units=c("f", "c"), refresh = 15, session) {
  require(XML)
  require(httr)
  
  units = match.arg(units)
  
  reactive({
    invalidateLater(round(refresh*60*1000), session)
    
    url <- paste("http://weather.yahooapis.com/forecastrss?w=",woeid,"&u=", units, sep="")
    xml <- content(GET(url))
    root <- xmlRoot(xml)
    weatherData <- xmlAttrs(root[["channel"]][["item"]][["condition"]])
    weatherLocation <- xmlAttrs(root[["channel"]][["location"]])
    list (
      condition = weatherData[["text"]],
      temp = paste(weatherData[["temp"]]," º",if(units=="c") "C" else "F", sep=""),
      climacon = lookupIconName(weatherData["code"]),
      title = paste(weatherLocation["city"], "Weather")
    )
  })
}
