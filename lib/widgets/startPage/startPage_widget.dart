import 'package:flutter/material.dart';
import 'package:isudgu_app/Providers/SubjectListProvider.dart';
import 'package:isudgu_app/Providers/accauntsProvider.dart';
import 'package:isudgu_app/Providers/dropdownValueListProvider.dart';
import 'package:isudgu_app/storage.dart';
import 'package:isudgu_app/widgets/cardGrid/newCard_widget.dart';
import 'package:provider/provider.dart';

class StartPage extends StatelessWidget {

  //TODO: now its all usless
  //constructor
  AccauntsProvider accauntsProvider;
  StartPage(this.accauntsProvider);

  @override
  Widget build(BuildContext context) {
    return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.school,
                      color: Colors.black,
                      size: 70,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Вход для студентов в информационную систему ДГУ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
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
                    ValidationErrorWidget(accauntsProvider),
                    FlatButton(
                      onPressed: () async {

                        accauntsProvider.showError = false;
                        
                        Map<String, String> newAccauntMap = {
                          'fName': fnameController.text,
                          'sName': nameController.text,
                          'lName': lnameController.text,
                          'password': passController.text,
                        };

                        if (await accauntsProvider.validate(newAccauntMap)){

                          newAccauntMap = await accauntsProvider.reedAboutStudent(newAccauntMap);

                          accauntsProvider.addToAccauntsList(newAccauntMap);
                          accauntsProvider.currentAccaunt = newAccauntMap;
                          accauntsProvider.update();

                          fnameController.text = "";
                          nameController.text = "";
                          lnameController.text = "";
                          passController.text = "";

                        }else{

                          accauntsProvider.showError = true;

                        }
                        

                      },
                      child: Text(
                        "Войти",
                        style: TextStyle(color: Colors.black),
                      ),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class ValidationErrorWidget extends StatelessWidget {
  AccauntsProvider accauntsProvider;
  ValidationErrorWidget(this.accauntsProvider);

  @override
  Widget build(BuildContext context) {
    if (accauntsProvider.showError == true) {
      return Text(
        'Неверные данные',
        style: TextStyle(color: Colors.red),
      );
    } else {
      return SizedBox();
    }
  }
}
