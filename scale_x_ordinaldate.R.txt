#' go from ordinal dates to readable dates in axis
#' 
#' @keywords ggplot2 
#' @export
#' @examples 
#' ggplot(data=dat, aes(x=x, y=y))+geom_point()+


scale_x_ordinaldate <- function(year){
scale_x_continuous(label=function(x) strftime(chron(x, origin=c(month=1, day=1,year=year)), "%B %d"))
}