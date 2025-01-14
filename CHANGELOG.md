# Changelog

## 4.0.3 - 03.11.2022

* Changes of the `LineChart`:
  * Added temp solution to fix summer/winter time shifts.

## 4.0.2 - 03.11.2022

* Changes of the `LineChart`:
  * Fixed typedData dates generator again.

## 4.0.1 - 28.10.2022

* Changes of the `LineChart`:
  * Fixed typedData dates generator.

## 4.0.0 - 18.10.2022

* Changes of the `LineChart`:
  * Fixed documentation.

* Changes of the `GaugeChart`:
  * Redesigned section tap handling (moved it from painter to widget).
  * Fixed `GaugeChartData` hash code generation.
  * Fixed limitation that prevented from drawing more then one chart on the screen.

## 4.0.0-dev.14 - 14.10.2022

* Changes of the `LineChart`:
  * Fixed initial dot position.

## 4.0.0-dev.13 - 28.09.2022

* Changes of the `GaugeChart`:
  * Fixed normalized lists mismatch in case of initial zero only data.

## 4.0.0-dev.12 - 16.09.2022

* Changes of the `LineChart`:
  * Added line and point animation.

## 4.0.0-dev.11 - 08.09.2022

* Changes of the `BarChart`:
  * Redesigned border painting on the bars that are smaller then border stroke plus top bar radius.

## 4.0.0-dev.10 - 07.09.2022

* Fixes of the `BarChart`:
  * Fixed padding issue of `BarChart` with `BarFit.contain` fit type.
  * Fixed tap handling of `BarChart` with `BarFit.contain` fit type.

* Changes of the `BarChart`:
  * Redesigned zero bars to use border color as a main color if any provided, otherwise will fallback to normal color selection type.

## 4.0.0-dev.9 - 07.09.2022

* Changes of the `BarChart`:
  * Added separate colors for selected bars.
  * Added bar border customizations.
  * Added shadow customizations.
  * Added Y axis label layout customizations.
  * Added bar fitting customizations.

## 4.0.0-dev.8 - 18.08.2022

* Reverted previous change.
* Mark custom paint of `GaugeChart` as complex.

## 4.0.0-dev.7 - 18.08.2022

* Increased blur radius from 1px to 2px.

## 4.0.0-dev.6 - 18.08.2022

* Added blur for the edges of the `GaugeChart` to remove "sharpened" edges (possibly it is caused by flutter itself).

## 4.0.0-dev.5 - 17.08.2022

* Added explicitly anti-aliasing to all `Paint`'s.
* Set `filterQuality` to `FilterQuality.medium` for all `Paint`'s.

## 4.0.0-dev.4 - 02.08.2022

* Changed `GaugeChart.onSelectionChanged` delegate type from `ValueChanged<int>` to `IndexedPredicate` which now allows to control whether animation is needed or not by passing `true/false` as a return value.

## 4.0.0-dev.3 - 02.08.2022

* Adjusted `GaugeChartBackgroundStyle.borderFilled` check before painting border.
* Removed ignoring of the taps over already selected section as it caused more issues than value.

## 4.0.0-dev.2 - 01.08.2022

* Fixed `GaugeChartBackgroundStyle.borderColor` default value.
* Redo radius calculation, changed constraints from `Size.shortestSize` to `Size.width`.

## 4.0.0-dev.1 - 01.08.2022

* Added `GaugeChart`.
* Limitations:
  * Large borders are drawing outside of the path on the bottom side;
  * Only one chart could be on the screen;
  * No documentation for gauge chart.

## 3.1.1 - 21.07.2022

* Adjusted drawing of limited X axis labels.
* Adjusted example app.

## 3.1.0 - 18.07.2022

* Added `xAxisLabelQuantity` to `LineChartSettings` which defines the quantity of the X axis labels to draw.

## 3.0.0 - 30.06.2022

Full list of chages:

### 3.0.0-dev.6 - 30.06.2022

* Added caching of the typedData getter, it will significantly improve rendering performance of the `LineChart`.

### 3.0.0-dev.5 - 30.06.2022

* Added caching of the division size calculation method, it will significantly improve rendering performance of the `LineChart`.

### 3.0.0-dev.4 - 29.06.2022

* Added negative values support to `LineChart`.

### 3.0.0-dev.3 - 28.06.2022

* Fixed grid redraw issue caused by usage of old data due to animation implementation.

### 3.0.0-dev.2 - 28.06.2022

* Fixed taps on `BarChart`s bars.

### 3.0.0-dev.1 - 27.06.2022

* Added animation for the `BarChart`.
* Added alignment of the bars for the `BarChart`.
* **BREAKING CHANGE:**
  * chart data are now drawing from the first to the last item (in previous versions they were drawn reversed), and this change has led to changes in `BarChartData.selectedPeriod` getter (previously used to get first item as fallback, but now - last item).

## 2.1.1 - 21.06.2022

* Added ability to tap between chart and x axis label.

## 2.1.0 - 17.06.2022

* Added handling of taps over the bar chart.

## 2.0.3 - 03.06.2022

* Fixed `selectedPeriod` functionality.

## 2.0.2 - 01.06.2022

* Fixed `onSelectedPeriodChanged` raising from selection changed.
* Fixed grid and axis positioning if there's no data initially provided.

## 2.0.1 - 01.06.2022

* Added TextStyle to the RichLabelBuilder delegate.
* Fixed zero length data chart drawing.
* Fixed extra scrolling if padding was provided.
* Fixed label positioning if there's too few data.

## 2.0.0 - 31.05.2022

* Added `BarChart`.

## 1.4.1 - 05.05.2022

* Fixed `LimitLabelSnapPosition.chartBoundary` bias calculations.

## 1.4.0 - 04.05.2022

* Removed bool parameters `showFirstAxisYDivision` and `showLastAxisXDivision` and added enum `AxisDivisionEdges` that provides more complex customization of axis divisions at the edges of the grid.
* Added snap position of limit label.
* Added labels to the Y axis of the chart, that caused redesigning of `maxValue` calculation mechanic.

## 1.3.2 - 01.04.2022

* Fixed chart drawing with only 1 data entry.

## 1.3.1 - 30.03.2022

* Added detection of `horizontal drag start`.

## 1.3.0 - 30.03.2022

* Redesigned drawing of the first point.
* Fixed timezone issue.
* Fixed styles for point drop line stroke.

## 1.2.3 - 26.03.2022

* Fixed value normalization if all provided data is 0.

## 1.2.2 - 26.03.2022

* Fixed StackOverflowException for descending unidirectional chart.
* Fixed `xAxisDates` getter for unidirectional chart with empty data.

## 1.2.1 - 26.03.2022

* Fixed `typedData` getter when data is empty.

## 1.2.0 - 26.03.2022

* Allowed chart creation with less then 2 points.
* Added option to set padded value to max value.

## 1.1.0 - 25.03.2022

* Fixed color/gradient fill.
* Added to `LineChartGridStyle` stroke and color for X and Y axis as a separate values.
* Added option to show first Y axis grid line.
* Added option to show last X axis grid line.
* Renamed blurRadius to shadowBlurRadius in `LineChartLineStyle`.

## 1.0.1 - 25.03.2022

* Added changelog.

## 1.0.0 - 25.03.2022

* Added `LineChart`.
