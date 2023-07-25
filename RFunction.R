library('move2')

rFunction <- function(data, startTime=NULL, endTime=NULL, filter=TRUE)
{
  Sys.setenv(tz="UTC") 
  minT <- min(mt_time(data))
  maxT <- max(mt_time(data))
  
  if (is.null(startTime)) 
  {
    logger.info(paste("No start time given, keep all data with minimum timestamp",minT))
    startTime <- minT
  } else 
  {
    startTime <- as.POSIXct(startTime,format="%Y-%m-%dT%H:%M:%OSZ")
    logger.info(paste("Start time given:",startTime))
  }
    
    if (is.null(endTime)) 
  {
    logger.info(paste("No end time given, keep all data with maximum timestamp",maxT))
    endTime <- maxT
  } else 
  {
    endTime <- as.POSIXct(endTime,format="%Y-%m-%dT%H:%M:%OSZ")
    logger.info(paste("End time given:",endTime))
  }  

  if (startTime>endTime)
  {
    startTime0 <- startTime
    endTime0 <- endTime
    startTime <- endTime0
    endTime <- startTime0
    logger.info("Warning! Error! Your start timestamp is after your end timestamp. We assume that they were switched and filter the data accordingly.")
  }
  
  if (filter==TRUE)
  {
    if (minT>endTime | maxT<startTime)
    {
      logger.info("Warning! None of your data lies in the requested time range. Return NULL.")
      result <- NULL
    } else
    {
      result <- data[mt_time(data)>=startTime & mt_time(data)<=endTime,]
      logger.info(paste("Filtering successful. It found",nrow(result),"positions of",length(unique(mt_track_id(result))),"track(s)."))
    }
  } else
  {
    if (minT>endTime | maxT<startTime)
    {
      logger.info("Warning! None of your data lies in the requested time range. Return full data set with all 'in_time' = 'in'.")
      result <- data
      result$in_time <- 'in'
    } else
    {
      result <- data
      ix <- which(mt_time(data)>=startTime & mt_time(data)<=endTime)
      result$in_time <- NA
      result$in_time[ix] <- 'in'
      result$in_time[-ix] <- 'out'
      logger.info(paste("Filtering successful. It found",nrow(result),"positions of",length(unique(mt_track_id(result))),"track(s). The attribute 'in_time' is appended to your input data."))
    }
  }

  result
}
  
