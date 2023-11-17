import 'package:flutter/material.dart';
import 'post.dart';
import 'post_data_table.dart';
import 'post_bar_chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Network App',
      home: HomeScreen(), // Create a HomeScreen widget
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Post> posts; // Posts list is managed here

  @override
  void initState() {
    super.initState();
    posts = Post.generateData();
  }

  void updatePosts(Post updatedPost) {
    setState(() {
      int index = posts.indexWhere((p) => p.title == updatedPost.title);
      if (index != -1) {
        posts[index] = updatedPost;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts DataTable'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.bar_chart),
            onPressed: () => _navigateToChart(context), // Use the context from Scaffold
          ),
        ],
      ),
      body: PostsDataTable(
        posts: posts,
        onPostUpdated: updatePosts, // Pass the callback here
      ),
    );
  }

  void _navigateToChart(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PostBarChart(posts: posts), // Pass the posts to the chart page
      ),
    );
  }
}
