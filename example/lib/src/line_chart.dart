// Copyright (c) 2022, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:mdcharts/mdcharts.dart';
import 'package:rxdart/rxdart.dart';

import 'scaffolds/setup_scaffold.dart';
import 'widgets/dialog_list_tile.dart';
import 'widgets/number_list_tile.dart';

final _settings =
    BehaviorSubject<LineChartSettings>.seeded(const LineChartSettings());
final _style = BehaviorSubject<LineChartStyle>.seeded(const LineChartStyle());
final _data = BehaviorSubject<LineChartData>.seeded(LineChartData(
  gridType: LineChartGridType.undefined,
  data: {
    DateTime(2022, 02, 2): 10,
    DateTime(2022, 02, 4): 15,
    DateTime(2022, 02, 5): 19,
    DateTime(2022, 02, 6): 21,
    DateTime(2022, 02, 7): 17,
    DateTime(2022, 02, 8): 3,
    DateTime(2022, 02, 23): 73,
    DateTime(2022, 02, 24): 82,
    DateTime(2022, 02, 25): 83,
    DateTime(2022, 02, 26): 81,
    DateTime(2022, 02, 27): 77,
    DateTime(2022, 02, 28): 70,
  },
));

class LineChartExample extends StatelessWidget {
  const LineChartExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SetupScaffold(
      body: _Chart(),
      setupChildren: [
        _GeneralDataSetupGroup(),
        SetupDivider(),
        _GridTypeSetupGroup(),
        SetupDivider(),
        _DataTypeSetupGroup(),
        SetupDivider(),
        _GeneralSettingsSetupGroup(),
        SetupDivider(),
        _AxisDivisionsEdgesSetupGroup(),
        SetupDivider(),
        _LimitLabelSnapPositionSetupGroup(),
      ],
    );
  }
}

class _Chart extends StatelessWidget {
  const _Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LineChartSettings>(
      stream: _settings,
      initialData: _settings.value,
      builder: (context, settings) {
        return StreamBuilder<LineChartStyle>(
          stream: _style,
          initialData: _style.value,
          builder: (context, style) {
            return StreamBuilder<LineChartData>(
              stream: _data,
              initialData: _data.value,
              builder: (context, data) {
                return LineChart(
                  settings: settings.requireData,
                  style: style.requireData,
                  data: data.requireData,
                );
              },
            );
          },
        );
      },
    );
  }
}

class _GeneralDataSetupGroup extends StatelessWidget {
  const _GeneralDataSetupGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LineChartData>(
      stream: _data,
      initialData: _data.value,
      builder: (context, data) {
        return SetupGroup(
          title: 'General Data',
          children: [
            DialogListTile(
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              value: data.requireData.predefinedMaxValue?.toString(),
              onChanged: (value) {
                if (value == null) {
                  _data.add(data.requireData.copyWith(
                    allowNullPredefinedMaxValue: true,
                    predefinedMaxValue: null,
                  ));
                }

                final doubleValue = double.tryParse(value!);
                _data.add(
                    data.requireData.copyWith(predefinedMaxValue: doubleValue));
              },
              title: const Text('predefinedMaxValue'),
            ),
            DialogListTile(
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              value: data.requireData.limit?.toString(),
              onChanged: (value) {
                if (value == null) {
                  _data.add(data.requireData.copyWith(
                    allowNullLimit: true,
                    limit: null,
                  ));
                }

                final doubleValue = double.tryParse(value!);
                _data.add(data.requireData.copyWith(limit: doubleValue));
              },
              title: const Text('limit'),
            ),
            DialogListTile(
              value: data.requireData.limitText?.toString(),
              onChanged: (value) => _data.add(data.requireData.copyWith(
                allowNullLimitText: true,
                limitText: value,
              )),
              title: const Text('limitText'),
            ),
          ],
        );
      },
    );
  }
}

class _GridTypeSetupGroup extends StatelessWidget {
  const _GridTypeSetupGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LineChartData>(
      stream: _data,
      initialData: _data.value,
      builder: (context, data) {
        return SetupGroup(
          title: 'Grid Type',
          children: [
            for (var i = 0; i < LineChartGridType.values.length; i++)
              RadioListTile<LineChartGridType>(
                controlAffinity: ListTileControlAffinity.leading,
                groupValue: data.requireData.gridType,
                value: LineChartGridType.values[i],
                onChanged: (value) =>
                    _data.add(data.requireData.copyWith(gridType: value)),
                title: Text(LineChartGridType.values[i].name),
              ),
          ],
        );
      },
    );
  }
}

class _DataTypeSetupGroup extends StatelessWidget {
  const _DataTypeSetupGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LineChartData>(
      stream: _data,
      initialData: _data.value,
      builder: (context, data) {
        return SetupGroup(
          title: 'Grid Type',
          children: [
            for (var i = 0; i < LineChartDataType.values.length; i++)
              RadioListTile<LineChartDataType>(
                controlAffinity: ListTileControlAffinity.leading,
                groupValue: data.requireData.dataType,
                value: LineChartDataType.values[i],
                onChanged: (value) =>
                    _data.add(data.requireData.copyWith(dataType: value)),
                title: Text(LineChartDataType.values[i].name),
              ),
          ],
        );
      },
    );
  }
}

class _GeneralSettingsSetupGroup extends StatelessWidget {
  const _GeneralSettingsSetupGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LineChartSettings>(
      stream: _settings,
      initialData: _settings.value,
      builder: (context, settings) {
        final data = settings.requireData;

        return SetupGroup(
          title: 'General Settings',
          children: [
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              value: data.altitudeLine,
              onChanged: (value) =>
                  _settings.add(data.copyWith(altitudeLine: value == true)),
              title: const Text('altitudeLine'),
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              value: data.lineFilling,
              onChanged: (value) =>
                  _settings.add(data.copyWith(lineFilling: value == true)),
              title: const Text('lineFilling'),
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              value: data.lineShadow,
              onChanged: (value) =>
                  _settings.add(data.copyWith(lineShadow: value == true)),
              title: const Text('lineShadow'),
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              value: data.showAxisX,
              onChanged: (value) =>
                  _settings.add(data.copyWith(showAxisX: value == true)),
              title: const Text('showAxisX'),
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              value: data.showAxisXLabels,
              onChanged: (value) =>
                  _settings.add(data.copyWith(showAxisXLabels: value == true)),
              title: const Text('showAxisXLabels'),
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              value: data.showAxisY,
              onChanged: (value) =>
                  _settings.add(data.copyWith(showAxisY: value == true)),
              title: const Text('showAxisY'),
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              value: data.showAxisYLabels,
              onChanged: (value) =>
                  _settings.add(data.copyWith(showAxisYLabels: value == true)),
              title: const Text('showAxisYLabels'),
            ),
            IntListTile(
              value: data.xAxisDivisions,
              onChanged: (value) =>
                  _settings.add(data.copyWith(xAxisDivisions: value)),
              title: const Text('xAxisDivisions'),
            ),
            IntListTile(
              value: data.yAxisDivisions,
              onChanged: (value) =>
                  _settings.add(data.copyWith(yAxisDivisions: value)),
              title: const Text('yAxisDivisions'),
            ),
          ],
        );
      },
    );
  }
}

class _AxisDivisionsEdgesSetupGroup extends StatelessWidget {
  const _AxisDivisionsEdgesSetupGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LineChartSettings>(
      stream: _settings,
      initialData: _settings.value,
      builder: (context, settings) {
        final data = settings.requireData;

        return SetupGroup(
          title: 'Axis Division Edges',
          children: [
            for (var i = 0; i < AxisDivisionEdges.values.length; i++)
              RadioListTile<AxisDivisionEdges>(
                controlAffinity: ListTileControlAffinity.leading,
                groupValue: data.axisDivisionEdges,
                value: AxisDivisionEdges.values[i],
                onChanged: (value) =>
                    _settings.add(data.copyWith(axisDivisionEdges: value)),
                title: Text(AxisDivisionEdges.values[i].name),
              ),
          ],
        );
      },
    );
  }
}

class _LimitLabelSnapPositionSetupGroup extends StatelessWidget {
  const _LimitLabelSnapPositionSetupGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LineChartSettings>(
      stream: _settings,
      initialData: _settings.value,
      builder: (context, settings) {
        final data = settings.requireData;

        return SetupGroup(
          title: 'Limit Label Snap Position',
          children: [
            for (var i = 0; i < LimitLabelSnapPosition.values.length; i++)
              RadioListTile<LimitLabelSnapPosition>(
                controlAffinity: ListTileControlAffinity.leading,
                groupValue: data.limitLabelSnapPosition,
                value: LimitLabelSnapPosition.values[i],
                onChanged: (value) =>
                    _settings.add(data.copyWith(limitLabelSnapPosition: value)),
                title: Text(LimitLabelSnapPosition.values[i].name),
              ),
          ],
        );
      },
    );
  }
}
