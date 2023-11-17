import 'package:flutter/material.dart';
import 'post.dart'; // Assuming your Post class is in post.dart

class PostsDataTable extends StatefulWidget {
  final List<Post> posts; // Add this line
  final Function(Post) onPostUpdated; // Callback function

  // Add a constructor to accept posts
  const PostsDataTable({Key? key, required this.posts, required this.onPostUpdated}) : super(key: key);

  @override
  _PostsDataTableState createState() => _PostsDataTableState();
}

class _PostsDataTableState extends State<PostsDataTable> {
  late List<Post> posts;

  int? sortColumnIndex;
  bool isAscending = true;

  @override
  void initState() {
    super.initState();
    posts = Post.generateData();
  }

  void _incrementVote(Post post, bool isUpvote) {
    setState(() {
      if (isUpvote) {
        post.numUpVotes++;
      } else {
        post.numDownVotes++;
      }
    });
    widget.onPostUpdated(post); // Notify the parent widget of the update
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      sortAscending: isAscending,
      sortColumnIndex: sortColumnIndex,
      columns: [
        DataColumn(
          label: Text('Title'),
          onSort: _onSort,
          numeric: false,
        ),
        DataColumn(
          label: Text('Upvotes'),
          onSort: _onSort,
          numeric: true,
        ),
        DataColumn(
          label: Text('Downvotes'),
          onSort: _onSort,
          numeric: true,
        ),
      ],
      rows: posts.map((post) => DataRow(cells: [
        DataCell(Text(post.title)),
        DataCell(Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${post.numUpVotes}'),
            IconButton(
              icon: Icon(Icons.arrow_upward),
              onPressed: () => _incrementVote(post, true),
            ),
          ],
        )),
        DataCell(Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${post.numDownVotes}'),
            IconButton(
              icon: Icon(Icons.arrow_downward),
              onPressed: () => _incrementVote(post, false),
            ),
          ],
        )),
      ])).toList(),
    );
  }

  void _onSort(int columnIndex, bool ascending) {
    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;

      if (columnIndex == 0) { // Title column
        posts.sort((a, b) => ascending
            ? a.title.compareTo(b.title)
            : b.title.compareTo(a.title));
      } else if (columnIndex == 1) { // numUpVotes column
        posts.sort((a, b) => ascending
            ? a.numUpVotes.compareTo(b.numUpVotes)
            : b.numUpVotes.compareTo(a.numUpVotes));
      } else if (columnIndex == 2) { // numDownVotes column
        posts.sort((a, b) => ascending
            ? a.numDownVotes.compareTo(b.numDownVotes)
            : b.numDownVotes.compareTo(a.numDownVotes));
      }
    });
  }
}
