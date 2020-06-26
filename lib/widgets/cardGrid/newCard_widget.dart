import 'package:flutter/material.dart';
import 'package:isudgu_app/Providers/themeProvider.dart';

Color calculateColor(String str) {
  if (str == '–') {
    return Colors.grey;
  }

  if (str.indexOf("(") != -1) {
    str = str.substring(str.indexOf("(") + 1, str.indexOf(")"));
  }

  int mark = int.parse(str);

  if (mark < 51) {
    return Colors.red;
  } else if (mark < 66) {
    return Color.fromRGBO(237, 189, 57, 1);
  } else if (mark < 85) {
    return Colors.green[400];
  }

  return Colors.green;
}

Widget newCard(Map<String, String> subject, ThemeProvider themeProvider) {
  var col = themeProvider.fontColor;
  var frontCardColor = themeProvider.scafoldBackgroundColor;
  var backCardColor =
      themeProvider.cardBackgroundColor; //  Color.fromRGBO(242, 242, 240, 1);

  Map<String, Color> markColor = {
    'mod1': calculateColor(subject['mod1']),
    'mod2': calculateColor(subject['mod2']),
    'mod3': calculateColor(subject['mod3']),
    'mod4': calculateColor(subject['mod4']),
    'kurs': calculateColor(subject['kurs']),
    'zachet': calculateColor(subject['zachet']),
    'exam': calculateColor(subject['exam'])
  };

  return Card(
    child: Padding(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        subject["discipline"],
                        overflow: TextOverflow.fade,
                        style: TextStyle(color: col, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),

              Container(
                height: 3,
              ), //space

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Text("1",
                              style: TextStyle(color: themeProvider.fontColor)),
                          Text(
                            subject["mod1"],
                            style: TextStyle(
                              color: markColor["mod1"],
                            ),
                          ),
                        ],
                      ),
                      color: frontCardColor,
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Text("2",
                              style: TextStyle(color: themeProvider.fontColor)),
                          Text(
                            subject["mod2"],
                            style: TextStyle(
                              color: markColor["mod2"],
                            ),
                          ),
                        ],
                      ),
                      color: frontCardColor,
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Text("3",
                              style: TextStyle(color: themeProvider.fontColor)),
                          Text(
                            subject["mod3"],
                            style: TextStyle(
                              color: markColor["mod3"],
                            ),
                          ),
                        ],
                      ),
                      color: frontCardColor,
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Text("4",
                              style: TextStyle(color: themeProvider.fontColor)),
                          Text(
                            subject["mod4"],
                            style: TextStyle(
                              color: markColor["mod4"],
                            ),
                          ),
                        ],
                      ),
                      color: frontCardColor,
                    ),
                  ),
                  Builder(builder: (context) {
                    if (subject.containsKey("mod5")  && subject["mod5"] != "") {
                      return Expanded(
                        child: Card(
                          child: Column(
                            children: <Widget>[
                              Text("5",
                                  style: TextStyle(
                                      color: themeProvider.fontColor)),
                              Text(
                                subject["mod5"],
                                style: TextStyle(
                                  color: markColor["mod4"],
                                ),
                              ),
                            ],
                          ),
                          color: frontCardColor,
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  })
                ],
              ),

              SizedBox(
                height: 3,
              ), //space

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(3),
                        child: Column(
                          children: <Widget>[
                            Text("зачет",
                                style:
                                    TextStyle(color: themeProvider.fontColor)),
                            Text(
                              subject["zachet"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: markColor["zachet"],
                              ),
                            ),
                          ],
                        ),
                      ),
                      color: frontCardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(3),
                        child: Column(
                          children: <Widget>[
                            Text("экзамен",
                                style:
                                    TextStyle(color: themeProvider.fontColor)),
                            Text(
                              subject["exam"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: markColor["exam"],
                              ),
                            ),
                          ],
                        ),
                      ),
                      color: frontCardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ],
              ),

              Builder(builder: (context) {
                if (subject["kurs"] == "–") {
                  return SizedBox();
                } else {
                  return Expanded(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("курсовая: ",
                                style:
                                    TextStyle(color: themeProvider.fontColor)),
                            Text(
                              subject["kurs"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: markColor["kurs"],
                              ),
                            ),
                          ],
                        ),
                      ),
                      color: frontCardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  );
                }
              })
            ]),
      ),
    ),
    margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
    color: backCardColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
  );
}
