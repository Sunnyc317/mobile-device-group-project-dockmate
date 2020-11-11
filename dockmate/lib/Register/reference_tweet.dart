import 'package:flutter/material.dart';
import 'avatar.dart';
import 'tweetWidget.dart';

class Tweet extends StatelessWidget {
  String shortName;
  Color clr;
  String name;
  String atName;
  String time;
  String description;
  Image img;
  int numComments; 
  int numRetweets;  
  int numLikes;

  Tweet(
      {this.shortName,
      this.clr, 
      this.name,
      this.atName,
      this.time,
      this.description,
      this.img, 
      this.numComments, 
      this.numLikes, 
      this.numRetweets});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 5, right: 5, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Avatar(shortName, clr),
          TweetWidget(
            name: name,
            atName: atName,
            time: time,
            description: description, 
            img: img,
            numComments: numComments, 
            numRetweets: numRetweets, 
            numLikes: numLikes, 
          ),
        ],
      ),
    );
  }
}
