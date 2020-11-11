import 'package:flutter/material.dart';

class TweetWidget extends StatelessWidget {
  String name;
  String atName;
  String time;
  String description;
  Image img;
  int numComments;
  int numRetweets;
  int numLikes;

  TweetWidget({
    this.name,
    this.atName,
    this.time,
    this.description,
    this.img,
    this.numRetweets,
    this.numLikes,
    this.numComments,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          NameBar(name, atName, time),
          TextContent(description),
          img,
          FunctionBar(numComments, numRetweets, numLikes),
        ],
      ),
    );
  }
}

class NameBar extends StatelessWidget {
  String name;
  String atName;
  String time;

  NameBar(this.name, this.atName, this.time);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.only(right: 3),
              child: Text(name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  )),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 3),
              child: Text(
                atName,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 3),
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
        Icon(Icons.expand_more, color: Colors.grey[600]),
      ]),
    );
  }
}

class TextContent extends StatelessWidget {
  String description;

  TextContent(this.description);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(bottom: 5),
      child: Text(description),
    );
  }
}

class FunctionBar extends StatelessWidget {
  int numComments;
  int numRetweets;
  int numLikes;

  FunctionBar(this.numComments, this.numRetweets, this.numLikes);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.chat_bubble_outline, color: Colors.grey[500]),
          Text(
            numComments.toString(),
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
            ),
          ),
          Spacer(),
          Icon(Icons.repeat, color: Colors.grey[500]),
          Text(
            numRetweets.toString(),
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
            ),
          ),
          Spacer(),
          Icon(Icons.favorite_border, color: Colors.grey[500]),
          Text(
            numLikes.toString(),
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
            ),
          ),
          Spacer(),
          Icon(Icons.bookmark_border, color: Colors.grey[500]),
          Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }
}
