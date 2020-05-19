import 'package:flutter/material.dart';
import 'package:isudgu_app/Providers/accauntsProvider.dart';
import 'package:isudgu_app/storage.dart';
import 'package:provider/provider.dart';

class Dialogs {
  accaunts(BuildContext context,AccauntsProvider accauntsProvider2) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return ChangeNotifierProvider(
            create: (context) => AccauntsProvider(),
            child: Consumer<AccauntsProvider>(
                builder: (context, accauntsProvider, child) {
                //accauntsProvider2.update();
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                content: ListView.builder(
                    itemCount: accauntsProvider2.accauntsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(accauntsProvider2.accauntsList[index]["fName"]),
                        subtitle: Text(accauntsProvider2.accauntsList[index]["degree"]),
                        onTap: () {

                          accauntsProvider2.currentAccaunt = accauntsProvider2.accauntsList[index];

                          Navigator.pop(context);
                          
                        },
                      );
                    }),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () async{ 
                      await new Dialogs().newAccaunt(context,accauntsProvider2);
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
          return ChangeNotifierProvider(
            create: (context) => AccauntsProvider(),
            child: Consumer<AccauntsProvider>(
                builder: (context, accauntsProvider, child) {
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
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
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
                  onPressed: () async {
                    
                    Map<String, String> newAccauntMap = {
                      'fName': fnameController.text,
                      'sName': nameController.text,
                      'lName': lnameController.text,
                      'password': passController.text,
                      'degree': 'бакалавриат'
                    };

                    accauntsProvider2.addToAccauntsList(newAccauntMap);
                    Navigator.pop(context);
                    fnameController.text = "";
                    nameController.text = "";
                    lnameController.text = "";
                    passController.text = "";

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
              }),
          );
        });
        
  }
}
