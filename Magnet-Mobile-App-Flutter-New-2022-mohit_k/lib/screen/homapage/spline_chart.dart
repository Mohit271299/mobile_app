import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class spline_chart_graph extends StatefulWidget {
   final List<ChartData> data;
   spline_chart_graph({Key? key, required this.data}) : super(key: key);

  @override
  spline_chart_graphState createState() => spline_chart_graphState();
}

class spline_chart_graphState extends State<spline_chart_graph> {
  List<String>? _splineList;
  late String _selectedSplineType;
  SplineType? _spline;
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _selectedSplineType = 'natural';
    _spline = SplineType.natural;
    _splineList =
        <String>['natural', 'monotonic', 'cardinal', 'clamped'].toList();
    _tooltipBehavior = TooltipBehavior(
        enable: true,
        // borderColor: Colors.red,
        // borderWidth: 5,
        // color: Colors.lightBlue
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return _buildTypesSplineChart();
  }
  SfCartesianChart _buildTypesSplineChart() {
    return SfCartesianChart(
        // isTransposed: true,
        primaryXAxis: CategoryAxis(),
        // primaryYAxis: CategoryAxis(),
      tooltipBehavior: _tooltipBehavior,
        series: <ChartSeries>[
          SplineSeries<ChartData, String>(
              splineType: _spline,
              dataSource: widget.data,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,

          )

        ],

    );
    //   SfCartesianChart(
    //   // legend: Legend(isVisible: true, opacity: 0.7),
    //   plotAreaBorderWidth: 0,
    //   primaryXAxis: NumericAxis(
    //       // interval: 1,
    //
    //       majorGridLines: const MajorGridLines(width: 0),
    //       edgeLabelPlacement: EdgeLabelPlacement.shift),
    //   primaryYAxis: NumericAxis(
    //       labelFormat: '{value}%',
    //       axisLine: const AxisLine(width: 0),
    //       majorTickLines: const MajorTickLines(size: 0)),
    //   series: _getSplineTypesSeries(),
    //   tooltipBehavior: TooltipBehavior(enable: true),
    // );
  }

}

class purchase_chart_graph extends StatefulWidget {
  final List<ChartData> data;

  const purchase_chart_graph({Key? key, required this.data}) : super(key: key);

  @override
  _purchase_chart_graphState createState() => _purchase_chart_graphState();
}

class _purchase_chart_graphState extends State<purchase_chart_graph> {
  List<String>? _splineList;
  late String _selectedSplineType;
  SplineType? _spline;

  @override
  void initState() {
    _selectedSplineType = 'natural';
    _spline = SplineType.natural;
    _splineList =
        <String>['natural', 'monotonic', 'cardinal', 'clamped'].toList();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return _buildTypesSplineChart();
  }
  SfCartesianChart _buildTypesSplineChart() {
    return SfCartesianChart(
      // isTransposed: true,
      primaryXAxis: CategoryAxis(),
      primaryYAxis: CategoryAxis(),
      series: <ChartSeries>[
        SplineAreaSeries<ChartData, String>(
            splineType: _spline,
            dataSource: widget.data,
            borderColor:HexColor('#3B7AF1'),
            gradient: new LinearGradient(
                colors: [
                  HexColor('#3B7AF1'),
                  HexColor('#ffffff'),
                ],
                stops: [
                  0.0,
                  0.9
                ],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                tileMode: TileMode.clamp),
            borderWidth: 2,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y
        )

      ],
      tooltipBehavior:  TooltipBehavior(enable: true),
    );
  }
}


/// Private class for storing the spline series data points.
class ChartData {
  ChartData(this.y,this.x,);
  final num? y;
  final String? x;
}
