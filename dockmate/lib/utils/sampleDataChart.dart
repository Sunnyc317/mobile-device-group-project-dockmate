// Sample data for datachart display (survey)

class Post {
  String title;
  int numUpVotes;
  int numDownVotes;

  Post(this.title, this.numUpVotes, this.numDownVotes);

  static List<Post> generateData() {
    return [
      Post("How satisfied are you with this app", 1, 10),
      Post("How likely will you recommend this app to friends?", 2, 12),
      Post("Are you willing to see adds in this app?", 3, 3),
      Post("Are you willing to pay for this app?", 4, 44),
    ];
  }
}
