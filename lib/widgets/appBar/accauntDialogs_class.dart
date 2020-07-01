import 'dart:io';

import 'package:flutter/material.dart';
import 'package:isudgu_app/Providers/accauntsProvider.dart';
import 'package:isudgu_app/Providers/themeProvider.dart';
import 'package:provider/provider.dart';

class Dialogs {
  accaunts(BuildContext context, AccauntsProvider accauntsProvider,
      ThemeProvider themeProvider) {
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
                try {
                  final result = await InternetAddress.lookup('google.com');
                  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                    return true;
                  }
                } on SocketException catch (_) {
                  await dialog.noInternetDialog(context, themeProvider);

                  if (await haveInternet() == false) {
                    await haveInternet();
                  } else {
                    return true;
                  }
                }
              }
              List<Widget> accauntsWidjetsList = [];
               accauntsProvider.accauntsList.forEach((element) {
                accauntsWidjetsList.add( Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                        color: themeProvider.cardBackgroundColor,
                        child: ListTile(
                            title: Text(
                                element["fName"],
                                style: TextStyle(color: themeProvider.fontColor)),
                            subtitle: Text(
                                element["degree"],
                                style: TextStyle(
                                    color: themeProvider.subtitleFontColor)),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: themeProvider.fontColor,
                              ),
                              onPressed: () async {
                                await new Dialogs().deleteDialog(context,
                                    accauntsProvider, themeProvider, 0);
                                accauntsProvider2.update();
                                if (accauntsProvider.accauntsList.length < 1) {
                                  Navigator.pop(context);
                                }
                              },
                            ),
                            onTap: () async {
                              if (await haveInternet() == true) {
                                accauntsProvider.currentAccaunt = element;

                                accauntsProvider.saveAccaunts();
                                accauntsProvider2.update();
                                Navigator.pop(context);
                              }
                            },
                          ),
                      ));
                });
              return AlertDialog(
                backgroundColor: themeProvider.scafoldBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                content: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: accauntsWidjetsList
                          ),
                        ],
                      ),
                    ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      await new Dialogs()
                          .newAccaunt(context, accauntsProvider, themeProvider);
                      accauntsProvider2.update();
                    },
                    child: Text(
                      "Новый",
                      style: TextStyle(color: themeProvider.fontColor),
                    ),
                  ),
                  FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Отмена",
                      style: TextStyle(color: themeProvider.fontColor),
                    ),
                  ),
                ],
              );
            }),
          );
        });
  }

  newAccaunt(BuildContext context, AccauntsProvider accauntsProvider2,
      ThemeProvider themeProvider) {
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
                edgeColor = themeProvider.fontColor;
              }

              final Dialogs dialog = new Dialogs();

              Future<bool> haveInternet() async {
                try {
                  final result = await InternetAddress.lookup('google.com');
                  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                    return true;
                  }
                } on SocketException catch (_) {
                  await dialog.noInternetDialog(context, themeProvider);

                  if (await haveInternet() == false) {
                    await haveInternet();
                  } else {
                    return true;
                  }
                }
              }

              return AlertDialog(
                  backgroundColor: themeProvider.scafoldBackgroundColor,
                  content: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Text("Вход в информационную систему ДГУ",
                            style: TextStyle(color: themeProvider.fontColor)),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          style: TextStyle(color: themeProvider.fontColor),
                          controller: fnameController,
                          scrollPadding: EdgeInsets.all(15),
                          autocorrect: false,
                          maxLength: 20,
                          decoration: InputDecoration(
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: edgeColor, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: edgeColor, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: edgeColor, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              counter: Container(),
                              hintStyle: TextStyle(
                                  color: themeProvider.subtitleFontColor),
                              hintText: 'Фамилия'),
                        ),
                        TextField(
                          style: TextStyle(color: themeProvider.fontColor),
                          controller: nameController,
                          autocorrect: false,
                          maxLength: 20,
                          decoration: InputDecoration(
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: edgeColor, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: edgeColor, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: edgeColor, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              counter: Container(),
                              hintStyle: TextStyle(
                                  color: themeProvider.subtitleFontColor),
                              hintText: 'Имя'),
                        ),
                        TextField(
                          style: TextStyle(color: themeProvider.fontColor),
                          controller: lnameController,
                          autocorrect: false,
                          maxLength: 20,
                          decoration: InputDecoration(
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: edgeColor, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: edgeColor, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: edgeColor, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              counter: Container(),
                              labelStyle:
                                  TextStyle(color: themeProvider.fontColor),
                              hintStyle: TextStyle(
                                  color: themeProvider.subtitleFontColor),
                              hintText: 'Отчество'),
                        ),
                        TextField(
                          style: TextStyle(color: themeProvider.fontColor),
                          keyboardType: TextInputType.numberWithOptions(),
                          controller: passController,
                          autocorrect: false,
                          maxLength: 10,
                          decoration: InputDecoration(
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: edgeColor, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: edgeColor, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: edgeColor, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              counter: Container(),
                              hintStyle: TextStyle(
                                  color: themeProvider.subtitleFontColor),
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

                            accauntsProvider.validation = 0;

                            Navigator.pop(context);
                          } else {
                            accauntsProvider.validation = 1;
                          }
                        }
                      },
                      child: Text(
                        "Добавить",
                        style: TextStyle(color: themeProvider.fontColor),
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
                        style: TextStyle(color: themeProvider.fontColor),
                      ),
                    ),
                  ]);
            }),
          );
        });
  }

  deleteDialog(BuildContext context, AccauntsProvider accauntsProvider,
      ThemeProvider themeProvider, int index) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: themeProvider.scafoldBackgroundColor,
            title: Text(
              "Удалить аккаунт?",
              style: TextStyle(color: themeProvider.fontColor),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  accauntsProvider.deleteFromAccauntsListByIndex(index);
                  accauntsProvider.saveAccaunts();
                  Navigator.pop(context);
                },
                child: Text(
                  "Удалить",
                  style: TextStyle(color: themeProvider.fontColor),
                ),
              ),
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Отмена",
                  style: TextStyle(color: themeProvider.fontColor),
                ),
              ),
            ],
          );
        });
  }

  noInternetDialog(BuildContext context, ThemeProvider themeProvider) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: themeProvider.scafoldBackgroundColor,
            title: Text(
              "Нет соединения с интернетом",
              style: TextStyle(color: themeProvider.fontColor),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Повторить",
                  style: TextStyle(color: themeProvider.fontColor),
                ),
              ),
            ],
          );
        });
  }
}
