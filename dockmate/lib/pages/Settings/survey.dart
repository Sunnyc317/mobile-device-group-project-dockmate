import 'package:flutter/material.dart';
import 'package:dockmate/pages/Settings/dataChart.dart';
import 'package:dockmate/utils/sampleDataChart.dart';

// Using datachart to conduct survey with upvotes and downvotes
class Survey extends StatefulWidget {
  Survey();

  @override
  _SurveyState createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  // List<Post> _grades;
  List<Post> _posts;

  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();

    setState(() {
      _posts = Post.generateData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tell us what you think!"),
          actions: [
            IconButton(
                icon: Icon(Icons.add_chart),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NewsChart(
                            title: "Survey Statistics",
                            posts: _posts,
                            // grades: _grades,
                          )));
                }),
          ],
        ),
        body: SingleChildScrollView(
            child: DataTable(
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          columns: [
            DataColumn(
              label: Text("Question"),
              tooltip: 'Question',
              numeric: false,
              onSort: (index, ascending) {
                setState(() {
                  _sortColumnIndex = index;
                  _sortAscending = ascending;
                  _posts.sort((a, b) {
                    if (ascending) {
                      return a.title.compareTo(b.title);
                    } else {
                      return b.title.compareTo(a.title);
                    }
                  });
                });
              },
            ),
            DataColumn(
              label: Icon(Icons.arrow_drop_up),
              tooltip: 'Upvote',
              numeric: true,
              onSort: (index, ascending) {
                setState(() {
                  _sortColumnIndex = index;
                  _sortAscending = ascending;
                  _posts.sort((a, b) {
                    if (ascending) {
                      return a.numUpVotes.compareTo(b.numUpVotes);
                    } else {
                      return b.numUpVotes.compareTo(a.numUpVotes);
                    }
                  });
                });
              },
            ),
            DataColumn(
              label: Icon(Icons.arrow_drop_down),
              tooltip: 'Downvote',
              numeric: true,
              onSort: (index, ascending) {
                setState(() {
                  _sortColumnIndex = 2;
                  _sortAscending = ascending;
                  _posts.sort((a, b) {
                    if (ascending) {
                      return a.numDownVotes.compareTo(b.numDownVotes);
                    } else {
                      return b.numDownVotes.compareTo(a.numDownVotes);
                    }
                  });
                });
              },
            )
          ],
          rows: _posts
              .map((post) => DataRow(
                    cells: <DataCell>[
                      DataCell(Text(post.title)),
                      DataCell(Row(
                        children: [
                          Text(post.numUpVotes.toString()),
                          IconButton(
                            icon: Icon(Icons.arrow_upward),
                            onPressed: () {
                              setState(() {
                                post.numUpVotes++;
                              });
                            },
                          )
                        ],
                      )),
                      DataCell(Row(
                        children: [
                          Text(post.numDownVotes.toString()),
                          IconButton(
                            icon: Icon(Icons.arrow_downward),
                            onPressed: () {
                              setState(() {
                                post.numDownVotes++;
                              });
                            },
                          )
                        ],
                      )),
                    ],
                  ))
              .toList(),
        )));
  }
}
