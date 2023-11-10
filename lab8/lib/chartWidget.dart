import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'post.dart'; // Assuming Post class is in post.dart

class VotesChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool animate;

  VotesChart({required this.seriesList, this.animate = true});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      vertical: false, // Sets bars to be horizontal
      barGroupingType: charts.BarGroupingType.grouped,
      domainAxis: const charts.OrdinalAxisSpec(
        showAxisLine: true,
        renderSpec: charts.SmallTickRendererSpec(
          labelRotation: 60, // Rotate domain labels
          labelAnchor: charts.TickLabelAnchor.after, // Move domain labels below bars
          labelJustification: charts.TickLabelJustification.inside,
          // Adjust the label style to match the image
          labelStyle: charts.TextStyleSpec(
            color: charts.MaterialPalette.white, // Titles color
            fontSize: 10, // Size in Pts.
          ),
          // Axis line style
          lineStyle: charts.LineStyleSpec(
            color: charts.MaterialPalette.white, // Axis line color
          ),
        ),
      ),
      primaryMeasureAxis: const charts.NumericAxisSpec(
        showAxisLine: true,
        renderSpec: charts.GridlineRendererSpec(
          // Tick and label style
          labelStyle: charts.TextStyleSpec(
            color: charts.MaterialPalette.white, // Numbers color
            fontSize: 10, // Size in Pts.
          ),
          // Axis line style
          lineStyle: charts.LineStyleSpec(
            color: charts.MaterialPalette.white, // Axis line color
          ),
        ),
      ),
      // Customize the bar width
      defaultRenderer: charts.BarRendererConfig(
        maxBarWidthPx: 10, // Adjust bar width
      ),
      // Optionally remove axis margin to extend bars across the chart area.
      layoutConfig: charts.LayoutConfig(
        leftMarginSpec: charts.MarginSpec.fixedPixel(0),
        topMarginSpec: charts.MarginSpec.fixedPixel(0),
        rightMarginSpec: charts.MarginSpec.fixedPixel(0),
        bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
      ),
    );
  }

  static List<charts.Series<Post, String>> createSampleData(List<Post> data) {
    return [
      charts.Series<Post, String>(
        id: 'Up Votes',
        domainFn: (Post post, _) => post.title,
        measureFn: (Post post, _) => post.numUpVotes,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        data: data,
      ),
      charts.Series<Post, String>(
        id: 'Down Votes',
        domainFn: (Post post, _) => post.title,
        measureFn: (Post post, _) => post.numDownVotes,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        data: data,
      ),
    ];
  }
}
