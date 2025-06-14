#
# Copyright (C) 2019 University of Amsterdam
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

# TODO
# - custom prior for factor moderators does not work

#' @export
RobustBayesianMetaAnalysis <- function(jaspResults, dataset, options, state = NULL) {

  options[["analysis"]] <- "RoBMA"

  if (.maReady(options)) {
    dataset <- .maCheckData(dataset, options)
    .maCheckErrors(dataset, options)
  }

  RobustBayesianMetaAnalysisCommon(jaspResults, dataset, options)

  return()
}
