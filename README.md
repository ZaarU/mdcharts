# MDCharts

![Build](https://github.com/marchdev-tk/mdcharts/workflows/build/badge.svg)
[![Pub](https://img.shields.io/pub/v/mdcharts.svg)](https://pub.dartlang.org/packages/mdcharts)
![GitHub](https://img.shields.io/github/license/marchdev-tk/mdcharts)
![GitHub stars](https://img.shields.io/github/stars/marchdev-tk/mdcharts?style=social)

march.dev charts library. Provides highly customizable and configurable charts.

## Getting Started

### LineChart

#### Data

* ##### REQUIRED data

  * `data` - set of data with `DateTime` keys and `double` values based on which chart will be drawned.

* ##### There are 2 general types of the `LineChart`:

  * **`Periodical` grid type (only `monthly` available for now):**

    Periodical means that if there's not enough data to draw full chart (there's gaps between dates) chart will automatically fulfill lacking data based on `LineChartDataType`.

    * For `LineChartDataType.bidirectional` data type lacking data will be set to `0`.

    * For `LineChartDataType.unidirectional` data type lacking data will calculated from previous values so, that charts will be looking like ascending (e.g. Progress) or descending (e.g. Burndown) chart.

  * **`Undefined` grid type:**

    Undefined means that the chart will be drawned using only provided data.

    Note that `LineChartDataType` is omitted with this type of grid.

* ##### Max Value 

  * `predefinedMaxValue` - predefined max value for the chart.
  * `maxValueRoundingMap` - rounding map for the maxValue that is used by beautification function of Y axis labels.

* ##### Limits

  * `limit` - if provided, will be painted on the chart as a horizontal indication line.
  * `limitText` - custom text to set to the label of the limit line.

  Note that if `limitText` is set without provided `limit`, there will be no limit line.

* ##### Tooltip builders

  * `titleBuilder` - builds title of the tooltip based on `DateTime` key and/or `double` value from provided data.
  * `subtitleBuilder` - builds subtitle of the tooltip based on `DateTime` key and/or `double` value from provided data.

* ##### Label builder

  * `xAxisLabelBuilder` - builds X axis label based on `DateTime` value from provided data.
  * `yAxisLabelBuilder` - builds Y axis label based on `double` value from provided data, `maxValue` specifically.

#### Settings

* `xAxisDivisions` - quantity of the X axis divisions, defaults to `3`.
* `yAxisDivisions` - quantity of the Y axis divisions, defaults to `2`.
* `xAxisLabelQuantity` - quantity of the X axis labels to draw, defaults to `null`.
* `axisDivisionEdges` - axis division edges, defaults to `AxisDivisionEdges.none`.
* `showAxisX` - whether to show X axis or not, defaults to `true`.
* `showAxisY` - whether to show Y axis or not, defaults to `true`.
* `lineFilling` - whether to fill chart between the line and the X axis or not, defaults to `true`.
* `lineShadow` - whether to draw shadow beneath the line or not, defaults to `true`.
* `altitudeLine` - whether to draw the altitude line or not, defaults to `true`.
* `limitLabelSnapPosition` - snap position options of limit label, defaults to `LimitLabelSnapPosition.axis`.
* `showAxisXLabels` - whether to show labels on the X axis or not, defaults to `true`.
* `showAxisYLabels` - whether to show labels on the Y axis or not, defaults to `true`.

#### Styles

* `gridStyle` - styling options for the grid, for more details please refer to the source code of the `LineChartGridStyle`.
* `axisStyle` - styling options for the axis, for more details please refer to the source code of the `LineChartAxisStyle`.
* `lineStyle` - styling options for the chart line, for more details please refer to the source code of the `LineChartLineStyle`.
* `limitStyle` - styling options for the limit, for more details please refer to the source code of the `LineChartLimitStyle`.
* `pointStyle` - styling options for the point and tooltip above point, for more details please refer to the source code of the `LineChartPointStyle`.

### BarChart

#### Data

* ##### REQUIRED data

  * `data` - set of data with `DateTime` keys and `List<double>` values based on which chart will be drawned.

* ##### Max Value 

  * `predefinedMaxValue` - predefined max value for the chart.
  * `maxValueRoundingMap` - rounding map for the maxValue that is used by beautification function of Y axis labels.

* ##### Selection

  * `initialSelectedPeriod` - initial selected period of the bar chart, defaults to `null`.
  * `onSelectedPeriodChanged` - callback that notifies if selected period has changed, defaults to `null`.

* ##### Label builder

  * `xAxisLabelBuilder` - builds X axis label based on `DateTime` value from provided data.
  * `yAxisLabelBuilder` - builds Y axis label based on `double` value from provided data, `maxValue` specifically.

#### Settings

* `yAxisDivisions` - quantity of the Y axis divisions, defaults to `2`.
* `axisDivisionEdges` - axis division edges, defaults to `AxisDivisionEdges.none`.
* `showAxisX` - whether to show X axis or not, defaults to `true`.
* `showAxisXLabels` - whether to show labels on the X axis or not, defaults to `true`.
* `showAxisYLabels` - whether to show labels on the Y axis or not, defaults to `true`.
* `yAxisLayout` - layout type of the Y axis labels, defaults to `YAxisLayout.overlay`.
* `yAxisLabelSpacing` - spacing between the Y axis labels and chart itself, defaults to `0`.
* `barSpacing` - spacing between bars in one item, defaults to `0`.
* `itemSpacing` - spacing between group of bars, defaults to `12`.
* `showSelection` - whether to show selection of the items or not, defaults to `true`.
* `duration` - the length of time animation should last, defaults to `400 milliseconds`.
* `alignment` - alignment of the bars within chart, defaults to `BarAlignment.end`.
* `reverse` - whether the scroll view scrolls in the reading direction, defaults to `false`.
* `fit` - insription type of the bars within target box (painting zone), defaults to `BarFit.none`.

#### Style

* `gridStyle` - styling options for the grid, for more details please refer to the source code of the `BarChartGridStyle`.
* `axisStyle` - styling options for the axis, for more details please refer to the source code of the `BarChartAxisStyle`.
* `barStyle` - styling options for the chart line, for more details please refer to the source code of the `BarChartBarStyle`.

## Examples

To see usage example navigate to the [Example](example/README.md) section.

## Feature requests and Bug reports

Feel free to post a feature requests or report a bug [here](https://github.com/marchdev-tk/mdcharts/issues).

## TODO

* Add MdDate to all charts (with unit-tests)
* Add ability to accept custom painters (requires ENORMOUS amount of time)
