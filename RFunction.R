library('move')

rFunction <- function(data, startTime=NULL, endTime=NULL)
{
  Sys.setenv(tz="GMT") 
  minT <- min(timestamps(data))
  maxT <- max(timestamps(data))
  
  if (is.null(startTime)) 
  {
    logger.info(paste("No start time given, keep all data with minimum timestamp",min(timestamps(data))))
    startTime <- minT
  } else logger.info(paste("Start time given:",startTime))
  if (is.null(endTime)) 
  {
    logger.info(paste("No end time given, keep all data with maximum timestamp",max(timestamps(data))))
    endTime <- maxT
  } else logger.info(paste("End time given:",endTime))
  
  startTime <- as.POSIXct(startTime)
  endTime <- as.POSIXct(endTime)
  
  if (startTime>endTime)
  {
    logger.info("Warning! Error! Your start date is after your end date. No filtering, return input data set.")
    result <- data
  } else if (minT>endTime | maxT<startTime)
  {
    logger.info("Warning! None of your data lies in the requested time range. No filtering, return input data set.")
    result <- data
  } else
  {
    result <- data[timestamps(data)>=as.POSIXct(startTime)&
                     timestamps(data)<=as.POSIXct(endTime),]
    logger.info(paste("Filtering successful. It found",length(result),"positions of",length(namesIndiv(result)),"animal(s)."))
  }
  
  #zero move cleanup not necessary

  result
}
  
