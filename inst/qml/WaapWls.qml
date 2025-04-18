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
import QtQuick			2.8
import QtQuick.Layouts	1.3
import JASP.Controls
import JASP.Widgets		1.0
import JASP				1.0

Form
{

	VariablesForm
	{
		preferredHeight: 200 * preferencesModel.uiScale

		AvailableVariablesList
		{
			name: "allVariables"
		}

		AssignedVariablesList
		{
			name:			"effectSize"
			title:
			{
				if (measuresCorrelation.checked)
					qsTr("Correlation")
				else
					qsTr("Effect Size")
			}
			singleVariable:	true
			allowedColumns:	["scale"]
		}

		AssignedVariablesList
		{
			name:			"effectSizeSe"
			title:			qsTr("Effect Size Standard Error")
			singleVariable:	true
			allowedColumns:	["scale"]
			visible:		active

			property bool active:   measuresGeneral.checked
			onActiveChanged: if (!active && count > 0) itemDoubleClicked(0);
		}

		AssignedVariablesList
		{
			name: 			"sampleSize"
			title: 			qsTr("Sample size")
			singleVariable: true
			allowedColumns: ["scale"]
			visible:		active

			property bool active:   measuresCorrelation.checked
			onActiveChanged: if (!active && count > 0) itemDoubleClicked(0);
		}

		DropDown
		{
			visible:	measuresCorrelation.checked
			label:		qsTr("Transform correlations to")
			name:		"transformCorrelationsTo"
			values:
			[
				{ label: qsTr("Fisher's z"),	value: "fishersZ"},
				{ label: qsTr("Cohen's d"),		value: "cohensD"}
			]
		}
	}

	RadioButtonGroup
	{
		name:					"measures"
		title:					qsTr("Measure")

		RadioButton
		{
			label: qsTr("Effect sizes & SE")
			value: "general"
			id: 	measuresGeneral
			checked:true
		}

		RadioButton
		{
			label: qsTr("Correlations & N")
			value: "correlation"
			id: 	measuresCorrelation
		}
	}

	Section
	{
		title: qsTr("Inference")
		
		Group
		{
			CheckBox
			{
				text:		qsTr("Mean estimates table")
				name:		"inferenceMeanEstimatesTable"
				checked:	true
			}

			CheckBox
			{
				text:		qsTr("Multiplicative heterogeneity estimates table")
				name:		"inferenceMultiplicativeHeterogeneityEstimatesEstimatesTable"
				checked:	false
			}
		}
	}

	Section
	{
		title: qsTr("Plots")

		CheckBox
		{
			text:	qsTr("Mean model estimates")
			name:	"plotsMeanModelEstimatesPlot"
		}

	}
}
