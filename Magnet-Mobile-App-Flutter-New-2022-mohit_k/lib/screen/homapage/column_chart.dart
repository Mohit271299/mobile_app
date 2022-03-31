import 'package:flutter/material.dart';
import 'package:magnet_update/screen/homapage/spline_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class column_chart_graph extends StatefulWidget {
  final List<ColumnData> data;

  const column_chart_graph({Key? key, required this.data}) : super(key: key);

  @override
  _column_chart_graphState createState() => _column_chart_graphState();
}

class _column_chart_graphState extends State<column_chart_graph> {
  TooltipBehavior? _tooltipBehavior;
  SplineType? _spline;

  @override
  void initState() {
    _spline = SplineType.natural;

    _tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildDefaultColumnChart();
  }

  /// Get default column chart
  SfCartesianChart _buildDefaultColumnChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(),

      series: <ChartSeries>[
        ColumnSeries<ColumnData, String>(
          // splineType: _spline,
          dataSource: widget.data,
          xValueMapper: (ColumnData data, _) => data.x,
          yValueMapper: (ColumnData data, _) => data.y1,

        ),ColumnSeries<ColumnData, String>(
          // splineType: _spline,
          dataSource: widget.data,
          xValueMapper: (ColumnData data, _) => data.x,
          yValueMapper: (ColumnData data, _) => data.y2,

        ),

      ],
      tooltipBehavior: _tooltipBehavior,
    );
  }
}

  /// Get default column series
class ColumnData {
  ColumnData(this.x,this.y1,this.y2);
  final num? y1;
  final num? y2;
  final String? x;
}
