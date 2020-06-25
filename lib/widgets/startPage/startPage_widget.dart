import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:isudgu_app/Providers/accauntsProvider.dart';
import 'package:isudgu_app/Providers/themeProvider.dart';
import 'package:isudgu_app/widgets/appBar/accauntDialogs_class.dart';

class StartPage extends StatelessWidget {

  AccauntsProvider accauntsProvider;
  ThemeProvider themeProvider;
  StartPage(this.accauntsProvider , this.themeProvider);

  final nameController = TextEditingController(text: "");
  final fnameController = TextEditingController(text: "");
  final lnameController = TextEditingController(text: "");
  final passController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    Color edgeColor;

    if (accauntsProvider.validation == 1) {
      edgeColor = Colors.red;
    } else {
      edgeColor = themeProvider.fontColor;
    }

    final Dialogs dialog = new Dialogs();

    Future<bool> haveInternet() async {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        return true;
      } else if (connectivityResult == ConnectivityResult.wifi) {
        return true;
      } else {
        await dialog.noInternetDialog(context , themeProvider);

        if (await haveInternet() == false) {
          await haveInternet();
        } else {
          return true;
        }
      }
    }

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.school,
                color: themeProvider.fontColor,
                size: 70,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Вход для студентов в информационную систему ДГУ",
                style: TextStyle(
                  color: themeProvider.fontColor,
                  fontSize: 17,
                ),
              ),
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
                        borderSide: BorderSide(color: edgeColor, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: edgeColor, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: edgeColor, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    counter: Container(),
                    hintStyle: TextStyle(color: themeProvider.subtitleFontColor),
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
                        borderSide: BorderSide(color: edgeColor, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: edgeColor, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: edgeColor, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    counter: Container(),
                    hintStyle: TextStyle(color: themeProvider.subtitleFontColor),
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
                        borderSide: BorderSide(color: edgeColor, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: edgeColor, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: edgeColor, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    counter: Container(),
                    labelStyle: TextStyle(color: themeProvider.fontColor),
                    hintStyle: TextStyle(color: themeProvider.subtitleFontColor),
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
                        borderSide: BorderSide(color: edgeColor, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: edgeColor, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: edgeColor, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    counter: Container(),
                    hintStyle: TextStyle(color: themeProvider.subtitleFontColor),
                    hintText: 'Номер зачетной книжки'),
              ),
              Builder(builder: (BuildContext context) {
                if (accauntsProvider.validation == 1) {
                  return Text(
                    'Неверные данные',
                    style: TextStyle(color: Colors.red),
                  );
                } else {
                  return SizedBox();
                }
              }),
              FlatButton(
                textColor: themeProvider.fontColor,
                onPressed: () async {
                  if (await haveInternet() == true) {
                    accauntsProvider.validation = 2;

                    Map<String, String> newAccauntMap = {
                      'fName': fnameController.text,
                      'sName': nameController.text,
                      'lName': lnameController.text,
                      'password': passController.text,
                    };

                    if (await accauntsProvider.validate(newAccauntMap)) {
                      newAccauntMap = await accauntsProvider
                          .reedAboutStudent(newAccauntMap);

                      accauntsProvider.addToAccauntsList(newAccauntMap);
                      accauntsProvider.currentAccaunt =
                          accauntsProvider.accauntsList[0];
                      accauntsProvider.saveAccaunts();
                      accauntsProvider.update();

                      fnameController.text = "";
                      nameController.text = "";
                      lnameController.text = "";
                      passController.text = "";

                      accauntsProvider.validation = 0;
                      
                    } else {
                      accauntsProvider.validation = 1;
                    }
                  }
                },
                child: Builder(builder: (BuildContext context) {
                  if (accauntsProvider.validation == 2) {
                    return Container(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(themeProvider.fontColor),
                        strokeWidth: 2,
                      ),
                    );
                  } else {
                    return Text(
                      "Войти",
                      style: TextStyle(color: themeProvider.fontColor),
                    );
                  }
                }),
                shape: OutlineInputBorder(
                    borderSide: BorderSide(color: themeProvider.fontColor),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
