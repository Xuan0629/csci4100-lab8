import 'package:charts_flutter/flutter.dart' as charts;

class Post {
  String title;
  int numUpVotes;
  int numDownVotes;

  Post(this.title, this.numUpVotes, this.numDownVotes);

  static List<Post> generateData() {
    return [
      Post("Story 1", 10, 2),
      Post("Story 2", 5, 3),
      // Add more sample data
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
