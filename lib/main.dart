import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:isudgu_app/script.dart';
import 'package:isudgu_app/storage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.grey,
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Dialog dialog = new Dialog();

  void refresh() async {
    _showWaitingTrue();
    subjectList = await Parser().parseHtml();

    changeState();
    _showWaitingFalse();
  }

  void initRefresh() async {
    subjectList = await Parser().parseHtml();

    changeState();
  }

  void changeState() {
    setState(() {
      subjectList = subjectList;
    });
  }

  void _showWaitingTrue() {
    setState(() {
      showWaiting = true;
    });
  }

  void _showWaitingFalse() {
    setState(() {
      showWaiting = false;
    });
  }

  void showAccountsDialog() async {
    await dialog.accaunts(context);

    refresh();
  }

  @override
  void initState() {
    super.initState();

    refresh();
  }

  void choiseAction(String choise) {
    if (choise == 'Обновить') {
      refresh();
    } else if (choise == 'Сменить тему') {
    } else if (choise == 'Сменить аккаунт') {
      showAccountsDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            brightness: Brightness.light,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.school,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Эмиров Ш. М.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                DropdownButton(
                  value: dropdownValue,
                  iconEnabledColor: Colors.black,
                  underline: Container(),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                      refresh();
                    });
                  },
                  items: dropdownValueList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value + " семестр",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            pinned: true,
            backgroundColor: Color.fromRGBO(242, 242, 247, 1),
            expandedHeight: 175.0,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const <StretchMode>[],
              background: Padding(
                padding: const EdgeInsets.all(25.0),
                child: aboutSteudent(),
              ),
            ),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: choiseAction,
                itemBuilder: (BuildContext context) {
                  return actionsPopUp.map((String choise) {
                    return PopupMenuItem<String>(
                      value: choise,
                      child: Text(choise),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          cardGrid(),
        ],
      )),
    );
  }
}

Widget aboutSteudent() {
  if (showWaiting)
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 7,
      ),
    );
  else
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text("Направление: бакалавриат"),
          SizedBox(
            height: 3,
          ),
          Text("Факультет: "),
          Text("Математики и компьютерных наук"),
          SizedBox(
            height: 3,
          ),
          Text("Кафедра: "),
          Text(
            "Прикладная математика и информатика",
            overflow: TextOverflow.fade,
          ),
        ]);
}

Widget cardGrid() {
  if (showWaiting)
    return SliverList(
      delegate: SliverChildListDelegate([
        Center(
          child: SizedBox(),
        ),
      ]),
    );
  else
    return SliverGrid.count(
      mainAxisSpacing: 15,
      childAspectRatio: (0.85),
      crossAxisCount: 2,
      children: List.generate(subjectList.length, (index) {
        return newCard(subjectList[index]);
      }),
    );
}

class Dialog {
  accaunts(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            content: ListView.builder(
                itemCount: accauntsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(accauntsList[index]["fName"]),
                    subtitle: Text(accauntsList[index]["degree"]),
                    onTap: () {
                      curentAccaunt = accauntsList[index];
                      dropdownValue = '';
                      dropdownValueList.clear();
                      Navigator.pop(context);
                    },
                  );
                }),
            actions: <Widget>[
              FlatButton(
                onPressed: () => new Dialog().newAccaunt(context),
                child: Text(
                  "Новый",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Отмена",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          );
        });
  }

  newAccaunt(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text("Вход в информационную систему ДГУ"),
                      SizedBox(height: 20,),
                      TextField(
                        controller: fnameController,
                        scrollPadding: EdgeInsets.all(15),
                        autocorrect: false,
                        maxLength: 20,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                            counter: Container(),
                            hintText: 'Фамилия'),
                      ),
                      TextField(
                        controller: nameController,
                        autocorrect: false,
                        maxLength: 20,
                        decoration: InputDecoration(
                            
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                            counter: Container(),
                            hintText: 'Имя'),
                      ),
                      TextField(
                        controller: lnameController,
                        autocorrect: false,
                        maxLength: 20,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                            counter: Container(),
                            hintText: 'Отчество'),
                      ),
                      TextField(
                        controller: passController,
                        autocorrect: false,
                        maxLength: 10,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                            counter: Container(),
                            hintText: 'Номер зачетной книжки'),
                      ),
                    ],
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: ()async{
                    newAccauntMap = {
                                      'fName': fnameController.text,
                                      'sName': nameController.text,
                                      'lName': lnameController.text,
                                      'password': passController.text,
                                      'degree': 'бакалавриат' //10519
                                    };

                    accauntsList.add(newAccauntMap);
                  },
                  child: Text(
                    "Добавить",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Отмена",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ]);
        });
  }
}

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

Widget newCard(Map<String, String> subject) {
  var col = Colors.black;
  var frontCardColor = Colors.white;
  var backCardColor = Color.fromRGBO(242, 242, 247, 1);

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
                          Text("1"),
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
                          Text("2"),
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
                          Text("3"),
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
                          Text("4"),
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
                ],
              ),

              Container(
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
                            Text("зачет"),
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
                            Text("экзамен"),
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
            ]),
      ),
    ),
    margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
    color: backCardColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
  );
}
