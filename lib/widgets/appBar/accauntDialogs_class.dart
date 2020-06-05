import 'package:flutter/material.dart';
import 'package:isudgu_app/Providers/accauntsProvider.dart';
import 'package:isudgu_app/storage.dart';
import 'package:provider/provider.dart';
import 'package:isudgu_app/widgets/startPage/startPage_widget.dart';

class Dialogs {
  accaunts(BuildContext context, AccauntsProvider accauntsProvider2) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return ChangeNotifierProvider(
            create: (context) => AccauntsProvider(),
            child: Consumer<AccauntsProvider>(
                builder: (context, accauntsProvider, child) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                content: ListView.builder(
                    itemCount: accauntsProvider2.accauntsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(
                            accauntsProvider2.accauntsList[index]["fName"]),
                        subtitle: Text(
                            accauntsProvider2.accauntsList[index]["degree"]),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.clear,
                          ),
                          onPressed: () async {
                            print("жжж");

                            await new Dialogs().deleteDialog(
                                context, accauntsProvider2, index);
                            accauntsProvider.update();
                            if (accauntsProvider.accauntsList.length < 1) {
                              Navigator.pop(context);
                            }
                          },
                        ),
                        onTap: () {
                          accauntsProvider2.currentAccaunt =
                              accauntsProvider2.accauntsList[index];

                          Navigator.pop(context);
                        },
                      );
                    }),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      await new Dialogs()
                          .newAccaunt(context, accauntsProvider2);
                      accauntsProvider.update();
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
                        controller: passController,
                        autocorrect: false,
                        maxLength: 10,
                        decoration: InputDecoration(
                            isDense: true,
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            counter: Container(),
                            hintText: 'Номер зачетной книжки'),
                      ),

                      ValidationErrorWidget(accauntsProvider2),

                    ],
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () async {
                    accauntsProvider2.showError = false;

                    Map<String, String> newAccauntMap = {
                      'fName': fnameController.text,
                      'sName': nameController.text,
                      'lName': lnameController.text,
                      'password': passController.text,
                      'faculty': '',
                      'department': ''
                    };

                    if (await accauntsProvider2.validate(newAccauntMap)) {
                      newAccauntMap = await accauntsProvider2
                          .reedAboutStudent(newAccauntMap);

                      accauntsProvider2.addToAccauntsList(newAccauntMap);
                      accauntsProvider2.currentAccaunt = newAccauntMap;
                      accauntsProvider2.update();

                      fnameController.text = "";
                      nameController.text = "";
                      lnameController.text = "";
                      passController.text = "";

                      Navigator.pop(context);
                    } else {
                      accauntsProvider2.showError = true;
                    }
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
}


