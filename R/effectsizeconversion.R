#
# Copyright (C) 2018 University of Amsterdam
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

#main
EffectSizeConversion <- function(jaspResults, dataset, options) {
  
  .showOptions(jaspResults, options)
  dataset <- .readData(dataset, options)
 
}

.showOptions <- function(jaspResults, options) {

  options[["variables"]] <- c(options$fisherZs, options$cohenDs, options$corrs, options$logORs, options$varMeasures)
  
  baseTable <- createJaspTable(title = "Variables to convert")
  baseTable$addColumnInfo(name = "baseTableCl", title = "Variables", type = "string")
  baseTable[["baseTableCl"]] <- options$variables

  jaspResults[["baseTable"]] <- baseTable

}

.readData <- function(dataset, options) {

  if(!is.null(dataset)) return(dataset)

  return(.readDataSetToEnd(columns = options$variables))
}



