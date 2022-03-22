// Copyright (c) 2022, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:ui';

import 'package:flutter/painting.dart';

/// Contains various customization options for the [LineChart].
class LineChartStyle {
  /// Constructs an instance of [LineChartStyle].
  const LineChartStyle({
    this.axisStyle = const LineChartAxisStyle(),
    this.lineStyle = const LineChartLineStyle(),
    this.limitStyle = const LineChartLimitStyle(),
    this.pointStyle = const LineChartPointStyle(),
  });

  /// Style of the axis lines.
  final LineChartAxisStyle axisStyle;

  /// Style of the line.
  ///
  /// It contains customization for the line itself, color or gradient of the
  /// filled part of the chart and final point altitude line.
  final LineChartLineStyle lineStyle;

  /// Style of the limit label and label dashed line.
  final LineChartLimitStyle limitStyle;

  /// Style of the point.
  ///
  /// It contains customizaiton for the point itself, drop line, tooltip and
  /// bottom margin.
  final LineChartPointStyle pointStyle;
}

/// Contains various customization options for the axis of the chart.
class LineChartAxisStyle {
  /// Constructs an instance of [LineChartAxisStyle].
  const LineChartAxisStyle({
    this.stroke = 1,
    this.color = const Color(0x33FFFFFF),
    this.labelStyle = defaultLabelStyle,
    this.labelTopPadding = 8,
  });

  static const defaultLabelStyle = TextStyle(
    height: 16 / 11,
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: Color(0xFFFFFFFF),
  );

  /// Stroke of the axis lines.
  ///
  /// Defaults to `1`.
  final double stroke;

  /// Color of the axis lines.
  ///
  /// Defaults to `0x33FFFFFF`.
  final Color color;

  /// Axis label style.
  ///
  /// Defaults to [defaultLabelStyle].
  final TextStyle labelStyle;

  /// Top padding of the axis label.
  ///
  /// Defaults to `8`.
  final double labelTopPadding;

  /// Gets a [Paint] for the axis drawing.
  Paint get paint => Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = stroke
    ..color = color;
}

/// Contains various customization options for the line of the chart itself.
class LineChartLineStyle {
  /// Constructs an instance of [LineChartLineStyle].
  ///
  /// If it is needed to remove the fill gradient - set [fillGradient]
  /// explicitly to `null`.
  const LineChartLineStyle({
    this.color = const Color(0xFFFFFFFF),
    this.stroke = 3,
    this.shadowColor = const Color(0x33000000),
    this.shadowStroke = 4,
    this.shadowOffset = const Offset(0, 2),
    this.blurRadius = 4,
    this.fillGradient = defaultGradient,
    this.fillColor,
    this.altitudeLineStroke = 1,
    this.altitudeLineColor = const Color(0x33FFFFFF),
  });

  static const defaultGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0x4DFFFFFF),
      Color(0x33FFFFFF),
      Color(0x1AFFFFFF),
      Color(0x01FFFFFF),
    ],
    stops: [0, 0.1675, 0.5381, 1],
  );

  /// Color of the chart line.
  ///
  /// Defaults to `0xFFFFFFFF`.
  final Color color;

  /// Stroke of the chart line.
  ///
  /// Defaults to `3`.
  final double stroke;

  /// Color of the shadow beneath the chart line.
  ///
  /// Defaults to `0x33000000`.
  final Color shadowColor;

  /// Stroke of the shadow beneath the chart line.
  ///
  /// Defaults to `4`.
  final double shadowStroke;

  /// Offset of the shadow beneath the chart line.
  ///
  /// Defaults to `Offset(0, 2)`.
  final Offset shadowOffset;

  /// Blur radius of the shadow beneath the chart line.
  ///
  /// Defaults to `4`.
  final double blurRadius;

  /// Fill gradient of the chart between X axis and chart line.
  ///
  /// Defaults to [defaultGradient].
  final Gradient? fillGradient;

  /// Fill color of the chart between X axis and chart line.
  ///
  /// Defaults to `null`.
  final Color? fillColor;

  /// Stroke of the altitude line.
  ///
  /// Defaults to `1`.
  final double altitudeLineStroke;

  /// Color of the altitude line.
  ///
  /// Defaults to `0x33FFFFFF`.
  final Color altitudeLineColor;

  bool get filled => fillGradient != null || fillColor != null;

  Paint get linePaint => Paint()
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = stroke
    ..color = color;

  Paint get shadowPaint => Paint()
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = shadowStroke
    ..color = shadowColor
    ..imageFilter = ImageFilter.blur(sigmaX: blurRadius, sigmaY: blurRadius);

  Paint get altitudeLinePaint => Paint()
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.butt
    ..strokeWidth = altitudeLineStroke
    ..color = altitudeLineColor;

  Paint getFillPaint([Rect? bounds]) {
    assert(filled);

    final gradientPaint = Paint()..style = PaintingStyle.fill;

    if (fillColor != null) {
      gradientPaint.color = fillColor!;
    }
    if (fillGradient != null) {
      assert(
        bounds != null,
        'bounds must not be null if fillGradient not null',
      );

      gradientPaint.shader = fillGradient!.createShader(bounds!);
    }

    return gradientPaint;
  }
}

/// Contains various customization options for limit line and label.
class LineChartLimitStyle {
  /// Constructs an instance of [LineChartLimitStyle].
  const LineChartLimitStyle({
    this.labelStyle = defaultStyle,
    this.labelOveruseStyle = defaultOveruseStyle,
    this.labelTextPadding = defaultTextPadding,
    this.labelColor = const Color(0xFFFFFFFF),
    this.dashColor = const Color(0x80FFFFFF),
    this.dashStroke = 1,
    this.dashSize = 2,
    this.gapSize = 2,
  });

  static const defaultStyle = TextStyle(
    height: 1.33,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: Color(0xFF000000),
  );
  static const defaultOveruseStyle = TextStyle(
    height: 1.33,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: Color(0xFFED2A24),
  );
  static const defaultTextPadding = EdgeInsets.fromLTRB(11, 3, 14, 3);

  /// [TextStyle] of a label.
  ///
  /// Defaults to [defaultStyle].
  final TextStyle labelStyle;

  /// [TextStyle] of a label if limit was overused.
  ///
  /// Defaults to [defaultOveruseStyle].
  final TextStyle labelOveruseStyle;

  /// Padding of a label.
  ///
  /// Defaults to [defaultTextPadding].
  final EdgeInsets labelTextPadding;

  /// Background color of a label.
  ///
  /// Defaults to `0xFFFFFFFF`.
  final Color labelColor;

  /// Color of a dashed line.
  ///
  /// Defaults to `0x80FFFFFF`.
  final Color dashColor;

  /// Stroke of a dash line.
  ///
  /// Defaults to `1`.
  final double dashStroke;

  /// Size of dashes.
  ///
  /// Defaults to `2`.
  final double dashSize;

  /// Gap between dashes.
  ///
  /// Defaults to `2`.
  final double gapSize;

  /// Gets a [Paint] for the limit line drawing.
  Paint get linePaint => Paint()
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.butt
    ..strokeWidth = dashStroke
    ..color = dashColor;

  /// Gets a [Paint] for the limit label drawing.
  Paint get labelPaint => Paint()
    ..style = PaintingStyle.fill
    ..color = labelColor;
}

/// Contains various customization options for the point (last available or
/// currently selected by user).
class LineChartPointStyle {
  /// Constructs an instance of [LineChartPointStyle].
  const LineChartPointStyle({
    this.innerColor = const Color(0xFF000000),
    this.innerSize = 7,
    this.outerColor = const Color(0xFFFFFFFF),
    this.outerSize = 17,
    this.shadowColor = const Color(0x33000000),
    this.dropLineColor = const Color(0xFFFFFFFF),
    this.dropLineDashSize = 2,
    this.dropLineGapSize = 2,
    this.tooltipColor = const Color(0xFFFFFFFF),
    this.tooltipTitleStyle = defaultTooltipTitleStyle,
    this.tooltipSubtitleStyle = defaultTooltipSubtitleStyle,
    this.tooltipPadding = defaultTooltipPadding,
    this.tooltipSpacing = 2,
    this.bottonMargin = 6,
  });

  static const defaultTooltipTitleStyle = TextStyle(
    height: 1,
    fontSize: 10,
    color: Color(0xCC000000),
  );
  static const defaultTooltipSubtitleStyle = TextStyle(
    height: 16 / 12,
    fontSize: 12,
    color: Color(0xFF000000),
  );
  static const defaultTooltipPadding = EdgeInsets.fromLTRB(12, 4, 12, 9);

  /// Color of the inner circle.
  ///
  /// Defaults to `0xFF000000`.
  final Color innerColor;

  /// Size (diameter) of the inner circle.
  ///
  /// Defaults to `7`.
  final double innerSize;

  /// Color of the outer circle.
  ///
  /// Defaults to `0xFFFFFFFF`.
  final Color outerColor;

  /// Size (diameter) of the outer circle.
  ///
  /// Defaults to `17`.
  final double outerSize;

  /// Shadow color.
  ///
  /// Defaults to `0x33000000`.
  final Color shadowColor;

  /// Color of the drop line.
  ///
  /// Defaults to `0xFFFFFFFF`.
  final Color dropLineColor;

  /// Dash size of the drop line.
  ///
  /// Defaults to `2`.
  final double dropLineDashSize;

  /// Gap size of the drop line.
  ///
  /// Defaults to `2`.
  final double dropLineGapSize;

  /// Color of the tooltip.
  ///
  /// Defaults to `0xFFFFFFFF`.
  final Color tooltipColor;

  /// Title style of the tooltip.
  ///
  /// Defaults to [defaultTooltipTitleStyle].
  final TextStyle tooltipTitleStyle;

  /// Subtitle style of the tooltip.
  ///
  /// Defaults to [defaultTooltipSubtitleStyle].
  final TextStyle tooltipSubtitleStyle;

  /// Padding around title and subtitle of the tooltip.
  ///
  /// Defaults to [defaultTooltipPadding].
  final EdgeInsets tooltipPadding;

  /// Spacing between title and subtitle of the tooltip.
  ///
  /// Defaults to `2`.
  final double tooltipSpacing;

  /// Bottom margin of the tooltip.
  ///
  /// Defaults to `6`.
  final double bottonMargin;
}
