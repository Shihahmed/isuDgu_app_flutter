import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:isudgu_app/Providers/accauntsProvider.dart';
import 'package:provider/provider.dart';
import 'package:isudgu_app/widgets/startPage/startPage_widget.dart';

class Dialogs {
  accaunts(BuildContext context, AccauntsProvider accauntsProvider) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return ChangeNotifierProvider(
            create: (context) => AccauntsProvider(),
            child: Consumer<AccauntsProvider>(
                builder: (context, accauntsProvider2, child) {
              final Dialogs dialog = new Dialogs();

              Future<bool> haveInternet() async {
                var connectivityResult =
                    await (Connectivity().checkConnectivity());
                if (connectivityResult == ConnectivityResult.mobile) {
                  return true;
                } else if (connectivityResult == ConnectivityResult.wifi) {
                  return true;
                } else {
                  await dialog.noInternetDialog(context);

                  if (await haveInternet() == false) {
                    await haveInternet();
                  } else {
                    return true;
                  }
                }
              }

              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                content: ListView.builder(
                    itemCount: accauntsProvider.accauntsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title:
                            Text(accauntsProvider.accauntsList[index]["fName"]),
                        subtitle: Text(
                            accauntsProvider.accauntsList[index]["degree"]),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.clear,
                          ),
                          onPressed: () async {
                            await new Dialogs()
                                .deleteDialog(context, accauntsProvider, index);
                            accauntsProvider2.update();
                            if (accauntsProvider.accauntsList.length < 1) {
                              Navigator.pop(context);
                            }
                          },
                        ),
                        onTap: () async {
                          if (await haveInternet() == true) {
                            accauntsProvider.currentAccaunt =
                                accauntsProvider.accauntsList[index];

                            accauntsProvider.saveAccaunts();
                            accauntsProvider2.update();
                            Navigator.pop(context);
                          }
                        },
                      );
                    }),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      await new Dialogs().newAccaunt(context, accauntsProvider);
                      accauntsProvider2.update();
                    },
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
            }),
          );
        });
  }

  newAccaunt(BuildContext context, AccauntsProvider accauntsProvider2) {
    final nameController = TextEditingController(text: "");
    final fnameController = TextEditingController(text: "");
    final lnameController = TextEditingController(text: "");
    final passController = TextEditingController(text: "");
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return ChangeNotifierProvider(
            create: (context) => AccauntsProvider(),
            child: Consumer<AccauntsProvider>(
                builder: (context, accauntsProvider, child) {

              Color edgeColor;

              if (accauntsProvider.validation == 1) {
                edgeColor = Colors.red;
              } else {
                edgeColor = Colors.grey;
              }

              final Dialogs dialog = new Dialogs();

              Future<bool> haveInternet() async {
                var connectivityResult =
                    await (Connectivity().checkConnectivity());
                if (connectivityResult == ConnectivityResult.mobile) {
                  return true;
                } else if (connectivityResult == ConnectivityResult.wifi) {
                  return true;
                } else {
                  await dialog.noInternetDialog(context);

                  if (await haveInternet() == false) {
                    await haveInternet();
                  } else {
                    return true;
                  }
                }
              }

              return AlertDialog(
                  content: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Text("Вход в информационную систему ДГУ"),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: fnameController,
                          scrollPadding: EdgeInsets.all(15),
                          autocorrect: false,
                          maxLength: 20,
                          decoration: InputDecoration(

                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: edgeColor, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              counter: Container(),
                              hintText: 'Фамилия'),
                        ),
                        TextField(
                          controller: nameController,
                          autocorrect: false,
                          maxLength: 20,
                          decoration: InputDecoration(
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: edgeColor, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              counter: Container(),
                              hintText: 'Имя'),
                        ),
                        TextField(
                          controller: lnameController,
                          autocorrect: false,
                          maxLength: 20,
                          decoration: InputDecoration(
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: edgeColor, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              counter: Container(),
                              hintText: 'Отчество'),
                        ),
                        TextField(
                          keyboardType: TextInputType.numberWithOptions(),
                          controller: passController,
                          autocorrect: false,
                          maxLength: 10,
                          decoration: InputDecoration(
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: edgeColor, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              counter: Container(),
                              hintText: 'Номер зачетной книжки'),
                        ),
                        Builder(builder: (BuildContext context) {
                          if (accauntsProvider.validation == 2) {
                            return LinearProgressIndicator();
                          } else if (accauntsProvider.validation == 1) {
                            return Text(
                              'Неверные данные',
                              style: TextStyle(color: Colors.red),
                            );
                          } else {
                            return SizedBox();
                          }
                        }),
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () async {
                        if (await haveInternet() == true) {
                          accauntsProvider.validation = 2;

                          Map<String, String> newAccauntMap = {
                            'fName': fnameController.text,
                            'sName': nameController.text,
                            'lName': lnameController.text,
                            'password': passController.text,
                            'faculty': '',
                            'department': ''
                          };

                          if (await accauntsProvider.validate(newAccauntMap)) {
                            newAccauntMap = await accauntsProvider2
                                .reedAboutStudent(newAccauntMap);

                            accauntsProvider2.addToAccauntsList(newAccauntMap);
                            accauntsProvider2.currentAccaunt =
                                accauntsProvider2.accauntsList.last;
                            accauntsProvider2.saveAccaunts();
                            accauntsProvider2.update();

                            fnameController.text = "";
                            nameController.text = "";
                            lnameController.text = "";
                            passController.text = "";

                            Navigator.pop(context);
                          } else {
                            accauntsProvider.validation = 1;
                          }
                        }
                      },
                      child: Text(
                        "Добавить",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        fnameController.text = "";
                        nameController.text = "";
                        lnameController.text = "";
                        passController.text = "";
                        accauntsProvider2.validation = 0;
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Отмена",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ]);
            }),
          );
        });
  }

  deleteDialog(
      BuildContext context, AccauntsProvider accauntsProvider, int index) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Удалить аккаунт?"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  accauntsProvider.deleteFromAccauntsListByIndex(index);
                  accauntsProvider.saveAccaunts();
                  Navigator.pop(context);
                },
                child: Text(
                  "Удалить",
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

  noInternetDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Нет соединения с интернетом"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Повторить",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          );
        });
  }
}
