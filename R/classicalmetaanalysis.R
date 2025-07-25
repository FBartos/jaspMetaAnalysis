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
ClassicalMetaAnalysis <- function(jaspResults, dataset = NULL, options, ...) {

  options[["analysis"]] <- "metaAnalysis"

  if (.maReady(options)) {
    dataset <- .maCheckData(dataset, options)
    .maCheckErrors(dataset, options)
  }


  ClassicalMetaAnalysisCommon(jaspResults, dataset, options)

  return()
}

.maDependencies        <- c(
  "effectSize", "effectSizeStandardError", "predictors", "predictors.types", "clustering", "subgroup", "method", "fixedEffectTest",
  "effectSizeModelTerms", "effectSizeModelIncludeIntercept",
  "clusteringUseClubSandwich", "clusteringSmallSampleCorrection",
  "confidenceIntervalsLevel",
  "fixParametersTau2", "fixParametersTau2Value",
  "fixParametersWeights", "fixParametersWeightsVariable",
  "weightedEstimation",
  "diagnosticsCasewiseDiagnosticsRerunWithoutInfluentialCases",
  # optimizer settings
  "optimizerMethod", "optimizerInitialTau2", "optimizerInitialTau2Value",
  "optimizerMinimumTau2", "optimizerMinimumTau2Value", "optimizerMaximumTau2", "optimizerMaximumTau2Value",
  "optimizerMaximumIterations", "optimizerMaximumIterationsValue", "optimizerConvergenceTolerance", "optimizerConvergenceToleranceValue",
  "optimizerConvergenceRelativeTolerance", "optimizerConvergenceRelativeToleranceValue", "optimizerStepAdjustment", "optimizerStepAdjustmentValue",
  "optimizerMaximumEvaluations", "optimizerMaximumEvaluationsValue",
  "optimizerInitialTrustRegionRadius", "optimizerInitialTrustRegionRadiusValue", "optimizerFinalTrustRegionRadius", "optimizerFinalTrustRegionRadiusValue",
  "optimizerMaximumRestarts", "optimizerMaximumRestartsValue",
  "advancedExtendMetaforCall", "advancedExtendMetaforCallCode",
  # simple ma specific
  "heterogeneityModelTerms", "heterogeneityModelIncludeIntercept", "heterogeneityModelLink",
  "permutationTest", "permutationTestIteration", "permutationTestType", "setSeed", "seed",
  # multilevel/multivariate specific
  "randomEffects", "randomEffectsSpecification",
  "computeCovarianceMatrix", "computeCovarianceMatrix",
  # multivariate effect size computation
  "varianceCovarianceMatrixType",
  "varianceCovarianceMatrixFile",
  "varianceCovarianceMatrixCorrelationMatrix",
  "varianceCovarianceMatrixSubcluster",
  "varianceCovarianceMatrixCluster",
  "varianceCovarianceMatrixForcePositiveDefiniteness",
  "varianceCovarianceMatrixCheckPositiveDefiniteness",
  "varianceCovarianceMatrixCorrelationMatrix",
  "varianceCovarianceMatrixConstruct",
  "varianceCovarianceMatrixConstructType",
  "varianceCovarianceMatrixTime1",
  "varianceCovarianceMatrixTime2",
  "varianceCovarianceMatrixGroup1",
  "varianceCovarianceMatrixGroup1",
  "varianceCovarianceMatrixGroupSize1",
  "varianceCovarianceMatrixGroupSize2",
  "varianceCovarianceMatrixConstructCorrelationMatrix",
  "varianceCovarianceMatrixConstructCorrelationMatrixValue",
  "varianceCovarianceMatrixConstructCorrelationMatrixFilePath",
  "varianceCovarianceMatrixConstructTypeCorrelationMatrix",
  "varianceCovarianceMatrixConstructTypeCorrelationMatrixValue",
  "varianceCovarianceMatrixConstructTypeCorrelationMatrixFilePath",
  "varianceCovarianceMatrixTimeLag1Correlation",
  # Mantel-Haenszel / Peto
  "successesGroup1", "successesGroup2", "sampleSizeGroup1", "sampleSizeGroup2",
  "eventsGroup1", "eventsGroup2", "personTimeGroup1", "personTimeGroup2",
  "effectSizeMeasure",
  "advancedAdd", "advancedTo", "advancedDropStudiesWithNoCasesOrEvents", "advancedContinuityCorrection"
)
.maForestPlotDependencies <- c(
  # do not forget to add variable carrying options to the .maDataPlottingDependencies
  "transformEffectSize", "confidenceIntervalsLevel", "bayesFactorType",
  "forestPlotStudyInformation",
  "forestPlotStudyInformationAllVariables",
  "forestPlotStudyInformationSelectedVariables",
  "forestPlotStudyInformationSelectedVariablesSettings",
  "forestPlotStudyInformationPredictedEffects",
  "forestPlotStudyInformationStudyWeights",
  "forestPlotStudyInformationOrderBy",
  "forestPlotStudyInformationOrderAscending",
  "forestPlotStudyInformationAggregateBy",
  "forestPlotStudyInformationAggregateMethod",
  "forestPlotStudyInformationAggregateMethodBubbleRelativeSize",
  "forestPlotEstimatedMarginalMeans",
  "forestPlotEstimatedMarginalMeansModelVariables",
  "forestPlotEstimatedMarginalMeansSelectedVariables",
  "forestPlotEstimatedMarginalMeansTermTests",
  "forestPlotEstimatedMarginalMeansCoefficientTests",
  "forestPlotEstimatedMarginalMeansCoefficientTestsAgainst",
  "forestPlotEstimatedMarginalMeansCoefficientTestsAgainst0",
  "forestPlotEstimatedMarginalMeansAdjustedEffectSizeEstimate",
  "forestPlotModelInformation",
  "forestPlotEffectSizeFixedEffectEstimate",
  "forestPlotEffectSizeFixedEffectTest",
  "forestPlotEffectSizePooledEstimate",
  "forestPlotEffectSizePooledEstimateTest",
  "forestPlotEffectSizeModerationTest",
  "forestPlotHeterogeneityTest",
  "forestPlotHeterogeneityEstimateTau",
  "forestPlotHeterogeneityEstimateTau2",
  "forestPlotHeterogeneityEstimateI2",
  "forestPlotHeterogeneityEstimateH2",
  "forestPlotHeterogeneityModerationTest",
  "forestPlotPublicationBiasTest",
  "forestPlotPredictionIntervals",
  "forestPlotEstimatesAndConfidenceIntervals",
  "forestPlotConditionalEstimates",
  "forestPlotTestsInRightPanel",
  "forestPlotAllignLeftPanel",
  "forestPlotSubgroupPanelsWithinSubgroup",
  "forestPlotSubgroupFullDatasetEstimatedMarginalMeans",
  "forestPlotSubgroupFullDatasetModelInformation",
  "forestPlotMappingColor",
  "forestPlotMappingShape",
  "forestPlotRelativeSizeEstimates",
  "forestPlotRelativeSizeText",
  "forestPlotRelativeSizeAxisLabels",
  "forestPlotRelativeSizeRow",
  "forestPlotRelativeSizeLeftPanel",
  "forestPlotRelativeSizeMiddlePanel",
  "forestPlotRelativeSizeRightPanel",
  "forestPlotAuxiliaryAdjustWidthBasedOnText",
  "forestPlotAuxiliaryDigits",
  "forestPlotAuxiliaryTestsInformation",
  "forestPlotAuxiliaryPlotColor",
  "forestPlotAuxiliaryAddVerticalLine",
  "forestPlotAuxiliaryAddVerticalLineValue",
  "forestPlotAuxiliaryAddVerticalLine2",
  "forestPlotAuxiliaryAddVerticalLineValue2",
  "forestPlotAuxiliaryEffectLabel",
  "forestPlotAuxiliarySetXAxisLimit",
  "forestPlotAuxiliarySetXAxisLimitLower",
  "forestPlotAuxiliarySetXAxisLimitUpper",
  "forestPlotStudyInformationSecondaryConfidenceInterval",
  "forestPlotStudyInformationSecondaryConfidenceIntervalLevel"
)
.maBubblePlotDependencies <- c(
  "transformEffectSize", "confidenceIntervalsLevel",
  "bubblePlotSelectedVariable",
  "bubblePlotSeparateLines",
  "bubblePlotSeparatePlots",
  "bubblePlotSdFactorCovariates",
  "bubblePlotBubblesSize",
  "bubblePlotBubblesRelativeSize",
  "bubblePlotBubblesTransparency",
  "bubblePlotBubblesJitter",
  "bubblePlotConfidenceIntervals",
  "bubblePlotConfidenceIntervalsTransparency",
  "bubblePlotPredictionIntervals",
  "bubblePlotPredictionIntervalsTransparency",
  "colorPalette",
  "bubblePlotTheme",
  "bubblePlotLegendPosition",
  "bubblePlotRelativeSizeText"
)
.maDataPlottingDependencies <- c(
  "forestPlotStudyInformationSelectedVariables",
  "forestPlotStudyInformationOrderBy",
  "forestPlotStudyInformationAggregateBy",
  "forestPlotMappingColor",
  "forestPlotMappingShape",
  "studyLabels"
)
.maReady               <- function(options) {

  if (.maIsClassical(options, notMHP = TRUE)) {

    # data
    inputReady <- options[["effectSize"]] != "" && options[["effectSizeStandardError"]] != ""

    # model
    termsEffectSizeReady    <- length(options[["effectSizeModelTerms"]]) > 0    || options[["effectSizeModelIncludeIntercept"]]
    termsHeterogeneityReady <- length(options[["heterogeneityModelTerms"]]) > 0 || options[["heterogeneityModelIncludeIntercept"]]

    return(inputReady && termsEffectSizeReady && termsHeterogeneityReady)

  } else if (.maIsClassical(options)) {

    # data
    if (options[["method"]] %in% c("mantelHaenszelFrequencies", "peto")) {
      inputReady <- options[["successesGroup1"]] != "" && options[["successesGroup2"]] != "" &&
        options[["sampleSizeGroup1"]] != "" && options[["sampleSizeGroup2"]] != ""
    } else if (options[["method"]] == "mantelHaenszelEvents") {
      inputReady <- options[["eventsGroup1"]] != "" && options[["eventsGroup2"]] != "" &&
        options[["personTimeGroup1"]] != "" && options[["personTimeGroup2"]] != ""
    }

    return(inputReady)

  } else {

    # data
    if (options[["analysis"]] %in% c("RoBMA", "NoBMA")) {
      inputReady <- options[["effectSize"]] != "" && options[["effectSizeStandardError"]] != ""
    } else if (options[["analysis"]] == "BiBMA") {
      inputReady <- options[["successesGroup1"]] != "" && options[["successesGroup2"]] != "" &&
        options[["sampleSizeGroup1"]] != "" && options[["sampleSizeGroup2"]] != ""
    }

    # missing priors automatically throw error

    return(inputReady)
  }
}
.maCheckData           <- function(dataset, options) {

  # model data
  predictorsNominal <- options[["predictors"]][options[["predictors.types"]] == "nominal"]
  predictorsScale   <- options[["predictors"]][options[["predictors.types"]] == "scale"]

  # omit NAs
  omitOnVariables <- c(
    options[["effectSize"]],
    options[["effectSizeStandardError"]],
    if (length(options[["clustering"]]) > 0 && options[["clustering"]] != "") options[["clustering"]],
    if (length(options[["studyLevelMultilevel"]]) > 0 && options[["studyLevelMultilevel"]] != "") options[["studyLevelMultilevel"]],
    if (length(options[["subgroup"]])   > 0 && options[["subgroup"]]   != "") options[["subgroup"]],
    if (length(predictorsNominal)       > 0) predictorsNominal,
    if (length(predictorsScale)         > 0) predictorsScale
  )
  anyNaByRows <- apply(dataset[,omitOnVariables], 1, function(x) anyNA(x))
  dataset     <- dataset[!anyNaByRows,]
  attr(dataset, "NAs")    <- sum(anyNaByRows)
  attr(dataset, "NasIds") <- anyNaByRows

  # drop empty factor levels
  dataset <- droplevels(dataset)

  return(dataset)
}
.maCheckErrors         <- function(dataset, options) {

  .hasErrors(
    dataset              = dataset,
    type                 = c("infinity", "observations"),
    all.target           = c(
      options[["effectSize"]],
      options[["effectSizeStandardError"]]
    ),
    observations.amount  = "< 2",
    exitAnalysisIfErrors = TRUE)

  # do not check effect sizes / standard errors for 0 variance
  otherVariable <- options[["predictors"]]
  if (length(otherVariable) > 0) {
    .hasErrors(
      dataset              = dataset,
      type                 = c("infinity", "observations", "variance", "factorLevels"),
      all.target           = otherVariable,
      observations.amount  = "< 2",
      factorLevels.amount  = "< 2",
      exitAnalysisIfErrors = TRUE)
  }

  .hasErrors(
    dataset              = dataset,
    seCheck.target       = options[["effectSizeStandardError"]],
    custom               = .maCheckStandardErrors,
    exitAnalysisIfErrors = TRUE)
}
.maCheckStandardErrors <- list(seCheck = function(dataset, target) {
    nonPositive <- !all(dataset[,target] > 0, na.rm = TRUE)
    if (nonPositive) {
      return(gettext("All standard errors must be positive."))
    }
  })
.maIsClassical         <- function(options, notMHP = FALSE) {

  # check if the analysis is classical
  if (options[["analysis"]] %in% c("metaAnalysis", "metaAnalysisMultilevelMultivariate", "mantelHaenszelPeto")) {
    if (notMHP) {
      return(options[["analysis"]] %in% c("metaAnalysis", "metaAnalysisMultilevelMultivariate"))
    } else {
      return(TRUE)
    }
  } else if (options[["analysis"]] %in% c("RoBMA", "NoBMA", "BiBMA")){
    return(FALSE)
  } else {
    stop("Unknown module")
  }
}
