#
# Copyright (C) 2013-2018 University of Amsterdam
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

#' @export
WaapWls <- function(jaspResults, dataset, options, state = NULL) {

  if (.wwppCheckReady(options)) {
    # check the data
    dataset <- .wwppCheckData(jaspResults, dataset, options)

    # fit the models
    .wwppFit(jaspResults, dataset, options, "waapWls")
  }

  # main summary tables
  .wwppMakeTestsTables(jaspResults, dataset, options, "waapWls")
  .wwppMakeEstimatesTables(jaspResults, dataset, options, "waapWls")


  # figures
  if (options[["plotsMeanModelEstimatesPlot"]])
    .wwppEstimatesPlot(jaspResults, dataset, options, "waapWls")

  return()
}
