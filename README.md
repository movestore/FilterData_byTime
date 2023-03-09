# Filter by Time Interval
MoveApps

Github repository: *github.com/movestore/FilterData_byTime*

## Description
Takes a start and end timestamp and filters to all locations in that time range. 

## Documentation
This App filters locations from a Movement data set to a time range that is defined by a start timestamp and/or end timestamp given by the user. Locations of all animals are considered.

### Input data
moveStack in Movebank format

### Output data
moveStack in Movebank format

### Artefacts
none

### Settings 
**Start Time (`startTime`):** a timestamp with year, month, day, hour, minute and second has to be selected interactively. Example: “2020-11-09 12:00:00”.

**End Time (`endTime`):** another timestamp with year, month, day, hour, minute and second has to be selected interactively. Take care that this has to lie after the start timestamp. Example: "2020-11-12 23:22:00"

### Null or error handling:
**Setting `startTime`:** if no start timestamp is defined then the first timestamp of the data is used

**Setting `endTime`:** if no end timestamp is defined then the last timestamp of the data is used

:warning: If the start time is defined to be after the end time, a warning is given. The algorithm switches the parameters and filters the data in the sensible time frame. 

**Data:** If none of the locations in the input data set lie in the requested time range, a warning is given and a NULL data set is returned. The NULL return value likely produces an error.
