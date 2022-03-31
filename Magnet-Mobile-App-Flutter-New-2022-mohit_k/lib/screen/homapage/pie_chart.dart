
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class pie_chart extends StatefulWidget {
  final List<PieData> data;
  const pie_chart({Key? key, required this.data}) : super(key: key);

  @override
  _pie_chartState createState() => _pie_chartState();
}

class _pie_chartState extends State<pie_chart> {
  @override
  Widget build(BuildContext context) {
    return _buildRadiusPieChart();
  }

  /// Returns the circular charts with pie series.
  SfCircularChart _buildRadiusPieChart() {
    return SfCircularChart(
      // legend: Legend(isVisible:  true , position: LegendPosition.bottom) ,
      series: _getRadiusPieSeries(),
      onTooltipRender: (TooltipArgs args) {
        final NumberFormat format = NumberFormat.decimalPattern();
        args.text = args.dataPoints![args.pointIndex!.toInt()].x.toString() +
            ' : ' +
            format.format(args.dataPoints![args.pointIndex!.toInt()].y);
      },
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// Returns the pie series.
  List<PieSeries<PieData, num>> _getRadiusPieSeries() {
    return <PieSeries<PieData, num>>[
      PieSeries<PieData, num>(

        explode: false,
          dataSource: widget.data,
          xValueMapper: (PieData data, _) => data.x,
          yValueMapper: (PieData data, _) => data.y,
          pointRadiusMapper: (PieData data, _) => data.size,

          startAngle: 100,
          endAngle: 100,
          dataLabelSettings: const DataLabelSettings(
              isVisible: true, labelPosition: ChartDataLabelPosition.outside))
    ];
  }
}
class PieData {
  PieData(this.x, this.y, this.size);
  final double x;
  final double y;
  final String size;
}
