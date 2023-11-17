import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'post.dart'; // Make sure this import points to where your Post class is defined

class PostBarChart extends StatelessWidget {
  final List<Post> posts;

  const PostBarChart({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Convert posts to series list for the chart
    List<charts.Series<Post, String>> seriesList = [
      charts.Series<Post, String>(
        id: 'Upvotes',
        domainFn: (Post post, _) => post.title,
        measureFn: (Post post, _) => post.numUpVotes,
        data: posts,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      ),
      charts.Series<Post, String>(
        id: 'Downvotes',
        domainFn: (Post post, _) => post.title,
        measureFn: (Post post, _) => post.numDownVotes,
        data: posts,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      ),
    ];

    // Wrap BarChart with a Scaffold to provide AppBar
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Stats'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(), // Go back to previous screen
        ),
      ),
      body: charts.BarChart(
        seriesList,
        animate: true,
        barGroupingType: charts.BarGroupingType.grouped,
        vertical: false, // Makes it a horizontal bar chart
      ),
    );
  }
}
