import 'package:flutter/material.dart';
import 'post.dart';
import 'chartWidget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> posts = Post.generateData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Network App'),
        actions: [
          // Inside the HomePage class
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(title: const Text('Post Votes Chart')),
                    body: VotesChart(
                      seriesList: VotesChart.createSampleData(posts),
                      animate: true,
                    ),
                  ),
                ),
              );
            },
          ),

        ],
      ),
      body: SingleChildScrollView(
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Title')),
            DataColumn(label: Text('Up Votes')),
            DataColumn(label: Text('Down Votes')),
          ],
          rows: posts.map((post) => DataRow(cells: [
            DataCell(Text(post.title)),
            DataCell(Row(
              children: [
                Text('${post.numUpVotes} '),
                IconButton(
                  icon: const Icon(Icons.arrow_upward),
                  onPressed: () => setState(() => post.numUpVotes++),
                ),
              ],
            )),
            DataCell(Row(
              children: [
                Text('${post.numDownVotes} '),
                IconButton(
                  icon: const Icon(Icons.arrow_downward),
                  onPressed: () => setState(() => post.numDownVotes++),
                ),
              ],
            )),
          ])).toList(),
        ),
      ),
    );
  }
}
