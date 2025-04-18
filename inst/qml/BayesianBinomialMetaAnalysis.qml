//
// Copyright (C) 2013-2018 University of Amsterdam
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public
// License along with this program.  If not, see
// <http://www.gnu.org/licenses/>.
//
import QtQuick 2.8
import QtQuick.Layouts 1.3
import JASP.Controls
import JASP.Widgets 1.0
import JASP 1.0
import "./qml_components"		as MA

Form
{

	VariablesForm
	{
		preferredHeight:	250 * preferencesModel.uiScale
		Layout.columnSpan:	2

		AvailableVariablesList {name: "variablesList"}

		AssignedVariablesList
		{
			name: 			"successesGroup1"
			title: 			qsTr("Successes (group 1)")
			singleVariable: true
			allowedColumns: ["scale"]
		}

		AssignedVariablesList
		{
			name: 			"successesGroup2"
			title: 			qsTr("Successes (group 2)")
			singleVariable: true
			allowedColumns: ["scale"]
		}

		AssignedVariablesList
		{
			name: 			"observationsGroup1"
			title: 			qsTr("Observations (group 1)")
			singleVariable: true
			allowedColumns: ["scale"]
		}

		AssignedVariablesList
		{
			name: 			"observationsGroup2"
			title: 			qsTr("Observations (group 2)")
			singleVariable: true
			allowedColumns: ["scale"]
		}


		AssignedVariablesList
		{
			name: 			"studyLabel"
			title: 			qsTr("Study Labels")
			singleVariable:	true
			allowedColumns: ["nominal"]
		}
	}

	CheckBox
	{
		name:		"priorDistributionPlot"
		label:		qsTr("Prior distribution plots")
	}

	//// Inference ////
	MA.RobustBayesianMetaAnalysisInference
	{
		analysisType:	"BiBMA"
	}

	//// Plots section ////
	MA.RobustBayesianMetaAnalysisPlots
	{
		analysisType:	"BiBMA"
	}

	//// Diagnostics section ////
	MA.RobustBayesianMetaAnalysisDiagnostics
	{
		analysisType:	"BiBMA"
	}

	//// Priors ////
	Section
	{
		title: 				qsTr("Models")
		columns:			1

		// effect prior
		MA.RobustBayesianMetaAnalysisPriors
		{
			Layout.preferredWidth:	parent.width
			componentType:			"modelsEffect"
			analysisType:			"binomial"
		}

		// heterogeneity prior
		MA.RobustBayesianMetaAnalysisPriors
		{
			Layout.preferredWidth:	parent.width
			componentType:			"modelsHeterogeneity"
			analysisType:			"binomial"
		}

		// baseline prior
		MA.RobustBayesianMetaAnalysisBaseline
		{
			Layout.preferredWidth:	parent.width
			componentType:			"modelsBaseline"
		}

		Divider { }

		CheckBox
		{
			id:						priorsNull
			name:					"priorsNull"
			label:					qsTr("Set null priors")
		}

		// effect prior
		MA.RobustBayesianMetaAnalysisPriors
		{
			Layout.preferredWidth:	parent.width
			componentType:			"modelsEffectNull"
			analysisType:			"binomial"
			visible:				priorsNull.checked
		}

		// effect prior
		MA.RobustBayesianMetaAnalysisPriors
		{
			Layout.preferredWidth:	parent.width
			componentType:			"modelsHeterogeneityNull"
			analysisType:			"binomial"
			visible:				priorsNull.checked
		}

		// baseline prior
		MA.RobustBayesianMetaAnalysisBaseline
		{
			Layout.preferredWidth:	parent.width
			componentType:			"modelsBaselineNull"
			visible:				priorsNull.checked
		}
	}

	//// Advanced section for prior model probabilities sampling settings ////
	MA.RobustBayesianMetaAnalysisAdvanced
	{
		analysisType:	"BiBMA"
	}

}
