// Copyright (c) 2022, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/rendering.dart';

import 'data.dart';
import 'style.dart';

class _TextPainter {
  _TextPainter(TextSpan textSpan) {
    textPainter = TextPainter(
      text: textSpan,
      maxLines: 1,
      textDirection: TextDirection.ltr,
    );
  }

  late TextPainter textPainter;
  bool _needsLayout = true;

  Size get size {
    textPainter.layout();
    _needsLayout = false;
    return textPainter.size;
  }

  void paint(Canvas canvas, Offset offset) {
    if (_needsLayout) {
      textPainter.layout();
    }
    textPainter.paint(canvas, offset);
  }
}

class LineChartPainter extends CustomPainter {
  const LineChartPainter(
    this.data,
    this.style,
  );

  final LineChartData data;
  final LineChartStyle style;

  double getWidthFraction(Size size) {
    final xDivisions = data.xAxisDivisions;
    final widthFraction = size.width / xDivisions;

    return widthFraction;
  }

  double getHeightFraction(Size size) {
    final yDivisions = data.yAxisDivisions;
    final heightFraction = size.height / yDivisions;

    return heightFraction;
  }

  double normalize(double value) {
    final max = data.maxValue;
    return 1 - value / max;
  }

  void paintGrid(Canvas canvas, Size size) {
    final gridPaint = Paint()..color = const Color(0x90FFFFFF);

    final xDivisions = data.xAxisDivisions;
    final widthFraction = size.width / xDivisions;
    for (var i = 1; i < xDivisions; i++) {
      canvas.drawLine(
        Offset(widthFraction * i, 0),
        Offset(widthFraction * i, size.height),
        gridPaint,
      );
    }

    final yDivisions = data.yAxisDivisions;
    final heightFraction = size.height / yDivisions;
    for (var i = 1; i < yDivisions; i++) {
      canvas.drawLine(
        Offset(0, heightFraction * i),
        Offset(size.width, heightFraction * i),
        gridPaint,
      );
    }
  }

  void paintAxis(Canvas canvas, Size size) {
    final axisPaint = style.axisStyle.paint;

    const topLeft = Offset.zero;
    final bottomLeft = Offset(0, size.height);
    final bottomRight = Offset(size.width, size.height);

    // x axis
    canvas.drawLine(bottomLeft, bottomRight, axisPaint);
    // y axis
    canvas.drawLine(topLeft, bottomLeft, axisPaint);
  }

  void paintChartLine(Canvas canvas, Size size) {
    final map = data.typedData;
    final widthFraction = getWidthFraction(size);
    final path = Path();

    final isDescending = data.dataType == LineChartDataType.unidirectional &&
        data.dataDirection == LineChartDataDirection.descending;

    if (!isDescending) {
      path.moveTo(0, size.height);
    }

    double firstY = 0;
    double x = 0;
    double y = 0;
    for (var i = 0; i < map.length; i++) {
      final value = map.entries.elementAt(i).value;

      x = widthFraction * i;
      y = normalize(value) * size.height;

      if (i == 0) {
        firstY = y;
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }

      if (i == map.length - 1) {
        path.moveTo(x, y);
      }
    }

    final gradientPath = Path.from(path);
    final shadowPath = path.shift(const Offset(0, 2));

    // finishing path to create valid gradient/color fill
    gradientPath.lineTo(x, size.height);
    gradientPath.lineTo(0, size.height);
    if (isDescending) {
      gradientPath.lineTo(0, 0);
    } else {
      gradientPath.lineTo(0, firstY);
    }

    canvas.drawPath(
      gradientPath,
      style.lineStyle.getFillPaint(gradientPath.getBounds()),
    );

    canvas.drawLine(
      Offset(x, y),
      Offset(x, size.height),
      style.lineStyle.altitudeLinePaint,
    );

    canvas.drawPath(shadowPath, style.lineStyle.shadowPaint);
    canvas.drawPath(path, style.lineStyle.linePaint);
  }

  void paintChartLimitLine(Canvas canvas, Size size) {
    if (data.limit == null) {
      return;
    }

    final path = Path();
    final y = normalize(data.limit!) * size.height;

    path.moveTo(0, y);

    final dashWidth = style.limitStyle.dashSize;
    final gapWidth = style.limitStyle.gapSize;
    final count = (size.width / (dashWidth + gapWidth)).round();
    for (var i = 1; i <= count; i++) {
      path.relativeLineTo(dashWidth, 0);
      path.relativeMoveTo(gapWidth, 0);
    }

    canvas.drawPath(path, style.limitStyle.linePaint);
  }

  void paintChartLimitLabel(Canvas canvas, Size size) {
    if (data.limit == null) {
      return;
    }

    final yCenter = normalize(data.limit!) * size.height;
    final textSpan = TextSpan(
      text: data.limitText ?? data.limit.toString(),
      style: data.limitOverused
          ? style.limitStyle.labelOveruseStyle
          : style.limitStyle.labelStyle,
    );
    final textPainter = _TextPainter(textSpan);
    final textSize = textPainter.size;
    final textPaddings = style.limitStyle.labelTextPadding;
    final textOffset = Offset(textPaddings.left, yCenter - textSize.height / 2);
    final labelHeight = textPaddings.vertical + textSize.height;
    final labelRadius = labelHeight / 2;

    canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        0,
        yCenter - labelHeight / 2,
        textPaddings.horizontal + textSize.width,
        yCenter + labelHeight / 2,
        topRight: Radius.circular(labelRadius),
        bottomRight: Radius.circular(labelRadius),
      ),
      style.limitStyle.labelPaint,
    );

    textPainter.paint(canvas, textOffset);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // paintGrid(canvas, size);
    paintAxis(canvas, size);
    paintChartLine(canvas, size);
    paintChartLimitLine(canvas, size);
    paintChartLimitLabel(canvas, size);
  }

  @override
  bool shouldRepaint(covariant LineChartPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
