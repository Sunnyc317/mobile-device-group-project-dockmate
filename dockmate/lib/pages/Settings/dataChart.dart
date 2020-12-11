import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dockmate/utils/sampleDataChart.dart';

// Displays survey result as horizontal bar chart
class NewsChart extends StatefulWidget {
  final String title;
  final List<Post> posts;
  NewsChart({this.title, this.posts});
  @override
  _NewsChartState createState() => _NewsChartState();
}

class _NewsChartState extends State<NewsChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 500.0,
          child: charts.BarChart(
            [
              charts.Series<Post, String>(
                id: 'Upvote',
                colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
                domainFn: (Post gf, _) => gf.title,
                measureFn: (Post gf, _) => gf.numUpVotes,
                data: widget.posts,
              ),
              charts.Series<Post, String>(
                id: 'Downvote',
                colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
                domainFn: (Post gf, _) => gf.title,
                measureFn: (Post gf, _) => gf.numDownVotes,
                data: widget.posts,
              ),
            ],
            animate: true,
            vertical: true,
            domainAxis: charts.OrdinalAxisSpec(
                renderSpec: charts.SmallTickRendererSpec(
                    minimumPaddingBetweenLabelsPx: 0,
                    labelAnchor: charts.TickLabelAnchor.centered,
                    labelStyle: charts.TextStyleSpec(
                      fontSize: 10,
                      color: charts.MaterialPalette.black,
                    ),
                    labelRotation: 60,
                    // Change the line colors to match text color.
                    lineStyle: charts.LineStyleSpec(
                        color: charts.MaterialPalette.black))),
          ),
        ),
      ),
    );
  }
}
