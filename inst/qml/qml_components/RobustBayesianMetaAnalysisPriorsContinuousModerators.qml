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
import QtQuick
import QtQuick.Layouts
import JASP.Controls
import JASP

ColumnLayout
{
	spacing: 						0
	property string componentType:	"Default type"
	property string analysisType:	"normal"

	Label
	{
		text: componentType === "null" ? qsTr("Continuous Moderators (null)") : qsTr("Continuous Moderators")
	}

	RowLayout
	{
		Layout.preferredWidth:	parent.width
		layoutDirection: Qt.RightToLeft
		Label { text: qsTr("Truncation");	Layout.preferredWidth: 174 * preferencesModel.uiScale }
	}
	Item
	{
		implicitWidth:	parent.width
		implicitHeight: priorLabel.implicitHeight
		Label { text: qsTr("Prior weights");	anchors.right: parent.right; id: priorLabel	}
		Label { text: qsTr("Lower");			anchors.right: parent.right; anchors.rightMargin: 127 * preferencesModel.uiScale - implicitWidth}
		Label { text: qsTr("Upper");			anchors.right: parent.right; anchors.rightMargin: 174 * preferencesModel.uiScale - implicitWidth}
		Label { text: qsTr("Parameters");		anchors.right: parent.right; anchors.rightMargin: 350 * preferencesModel.uiScale - implicitWidth}
		Label { text: qsTr("Distribution");		anchors.right: parent.right; anchors.rightMargin: 460 * preferencesModel.uiScale - implicitWidth}
	}

	VariablesList
	{
		name			: componentType === "null" ? "priorsModeratorsContinuousNull" : "priorsModeratorsContinuous"
		source			: [{ name: "effectSizeModelTerms", use: "type=scale"}]
		listViewType	: JASP.AssignedVariables
		draggable		: false
		optionKey		: "value"
		preferredHeight : 150 * preferencesModel.uiScale

		rowComponent: RowLayout
		{
			spacing:				8 * preferencesModel.uiScale
			layoutDirection:		Qt.RightToLeft

			FormulaField
			{
				name: 				"priorWeight"
				value:				"1"
				min: 				0
				inclusive: 			JASP.None
				fieldWidth:			40 * preferencesModel.uiScale
				useExternalBorder:	false
				showBorder:			true
			}

			Row
			{
				spacing:				4 * preferencesModel.uiScale
				Layout.preferredWidth:	120 * preferencesModel.uiScale

				FormulaField
				{
					id:					truncationLower
					name: 				"truncationLower"
					visible:			typeItem.currentValue !== "spike" && typeItem.currentValue !== "uniform" && typeItem.currentValue !== "none"
					value:				(typeItem.currentValue === "gammaK0" || typeItem.currentValue === "gammaAB" || typeItem.currentValue === "invgamma" || 
										typeItem.currentValue === "lognormal" || typeItem.currentValue === "beta") ? "0" : "-Inf"
					min:				(typeItem.currentValue === "gammaK0" || typeItem.currentValue === "gammaAB" || typeItem.currentValue === "invgamma" || 
										typeItem.currentValue === "lognormal" || typeItem.currentValue === "beta") ? "0" : "-Inf"
					max: 				truncationUpper.value
					inclusive: 			JASP.MinOnly
					fieldWidth:			40 * preferencesModel.uiScale
					useExternalBorder:	false
					showBorder:			true
				}

				FormulaField
				{
					id:					truncationUpper
					name: 				"truncationUpper"
					visible:			typeItem.currentValue !== "spike" && typeItem.currentValue !== "uniform" && typeItem.currentValue !== "none"
					value:				(typeItem.currentValue === "beta") ? "1" : "Inf"
					max:				(typeItem.currentValue === "beta") ? "1" : "Inf"
					min: 				truncationLower ? truncationLower.value : 0
					inclusive: 			JASP.MaxOnly
					fieldWidth:			40 * preferencesModel.uiScale
					useExternalBorder:	false
					showBorder:			true
				}

			}

			Row
			{
				spacing:				4 * preferencesModel.uiScale
				Layout.preferredWidth:	170 * preferencesModel.uiScale

				FormulaField
				{
					label:				"μ "
					name:				"mu"
					visible:			typeItem.currentValue === "normal"		||
										typeItem.currentValue === "lognormal"	||
										typeItem.currentValue === "t"
					value:				"0"
					inclusive:			JASP.None
					fieldWidth: 		40 * preferencesModel.uiScale
					useExternalBorder:	false
					showBorder: 		true
				}
				FormulaField
				{
					label:				"x₀"
					name:				"x0"
					visible:			typeItem.currentValue === "cauchy"	||
										typeItem.currentValue === "spike"
					value:				"0"
					inclusive:			JASP.None
					fieldWidth: 		40 * preferencesModel.uiScale
					useExternalBorder:	false
					showBorder: 		true
				}
				FormulaField
				{
					label:				"σ "
					name:				"sigma"
					id:					sigma
					visible:			typeItem.currentValue === "normal"		||
										typeItem.currentValue === "lognormal"	||
										typeItem.currentValue === "t"
					value:				"0.25"
					min:				0
					inclusive:			JASP.None
					fieldWidth: 		40 * preferencesModel.uiScale
					useExternalBorder:	false
					showBorder: 		true
				}
				FormulaField
				{
					label:				"k "
					name:				"k"
					visible:			typeItem.currentValue === "gammaK0"
					value:				"1"
					min:				0
					inclusive:			JASP.None
					fieldWidth: 		40 * preferencesModel.uiScale
					useExternalBorder:	false
				}
				FormulaField
				{
					label:				"θ"
					name:				"theta"
					visible:			typeItem.currentValue === "cauchy"	||
										typeItem.currentValue === "gammaK0"
					value:				"1"
					min:				0
					inclusive:			JASP.None
					fieldWidth: 		40 * preferencesModel.uiScale
					useExternalBorder:	false
					showBorder: 		true
				}
				FormulaField
				{
					label:				"ν"
					name:				"nu"
					visible:			typeItem.currentValue === "t"
					value:				"2"
					min:				1
					inclusive:			JASP.MinOnly
					fieldWidth: 		40 * preferencesModel.uiScale
					useExternalBorder:	false
					showBorder: 		true
				}
				FormulaField
				{
					label:				"α "
					name:				"alpha"
					visible:			typeItem.currentValue === "gammaAB"	 ||
										typeItem.currentValue === "invgamma" ||
										typeItem.currentValue === "beta"
					value:				"1"
					min:				0
					inclusive:			JASP.None
					fieldWidth: 		40 * preferencesModel.uiScale
					useExternalBorder:	false
					showBorder: 		true
				}
				FormulaField
				{
					label:				"β"
					name:				"beta"
					visible:			typeItem.currentValue === "gammaAB"	 ||
										typeItem.currentValue === "invgamma" ||
										typeItem.currentValue === "beta"
					value:				"0.15"
					min:				0
					inclusive:			JASP.None
					fieldWidth: 		40 * preferencesModel.uiScale
					useExternalBorder:	false
					showBorder: 		true
				}
				FormulaField
				{
					label:				"a "
					name:				"a"
					id:					a
					visible:			typeItem.currentValue === "uniform"
					value:				"0"
					max:				b.value
					inclusive:			JASP.None
					fieldWidth: 		40 * preferencesModel.uiScale
					useExternalBorder:	false
					showBorder: 		true
				}
				FormulaField
				{
					label:				"b"
					name:				"b"
					id:					b
					visible:			typeItem.currentValue === "uniform"
					value:				"1"
					min:				a.value
					inclusive:			JASP.None
					fieldWidth: 		40 * preferencesModel.uiScale
					useExternalBorder:	false
					showBorder: 		true
				}
			}

			DropDown
			{
				id: typeItem
				name: "type"
				fieldWidth:		100 * preferencesModel.uiScale
				useExternalBorder: true
				startValue: componentType === "null" ? "spike" : "normal"
				values:
				[
					{ label: qsTr("Normal(μ,σ)"),			value: "normal"},
					{ label: qsTr("Student-t(μ,σ,v)"),		value: "t"},
					{ label: qsTr("Cauchy(x₀,θ)"),			value: "cauchy"},
					{ label: qsTr("Gamma(α,β)"),			value: "gammaAB"},
					{ label: qsTr("Gamma(k,θ)"),			value: "gammaK0"},
					{ label: qsTr("Inverse-Gamma(α,β)"),	value: "invgamma"},
					{ label: qsTr("Log-Normal(μ,σ)"),		value: "lognormal"},
					{ label: qsTr("Beta(α,β)"),				value: "beta"},
					{ label: qsTr("Uniform(a,b)"),			value: "uniform"},
					{ label: qsTr("Spike(x₀)"),				value: "spike"},
					{ label: qsTr("None"),					value: "none"}
				]
			}

		}
	}

}
