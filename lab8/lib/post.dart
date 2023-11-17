import 'package:charts_flutter/flutter.dart' as charts;

class Post {
  String title;
  int numUpVotes;
  int numDownVotes;

  Post({required this.title, this.numUpVotes = 0, this.numDownVotes = 0});

  static List<Post> generateData() {
    return [
      Post(title: "Post 1", numUpVotes: 10, numDownVotes: 10),
      Post(title: "Post 2", numUpVotes: 15, numDownVotes: 5),
      Post(title: "Post 3", numUpVotes: 5, numDownVotes: 15),
      Post(title: "Post 4", numUpVotes: 20, numDownVotes: 0),
      Post(title: "Post 5", numUpVotes: 0, numDownVotes: 20),
    ];
  }

  static List<charts.Series<VoteData, String>> createChartData(List<Post> posts) {
    final upVotesData = posts.map((post) => VoteData(post.title, post.numUpVotes)).toList();
    final downVotesData = posts.map((post) => VoteData(post.title, post.numDownVotes)).toList();

    return [
      charts.Series<VoteData, String>(
        id: 'Up Votes',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (VoteData votes, _) => votes.title,
        measureFn: (VoteData votes, _) => votes.votes,
        data: upVotesData,
      ),
      charts.Series<VoteData, String>(
        id: 'Down Votes',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (VoteData votes, _) => votes.title,
        measureFn: (VoteData votes, _) => votes.votes,
        data: downVotesData,
      ),
    ];
  }
}

class VoteData {
  final String title;
  final int votes;

  VoteData(this.title, this.votes);
}
