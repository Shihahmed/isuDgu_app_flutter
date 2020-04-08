import 'package:flutter/material.dart';

final nameController = TextEditingController();
final fnameController = TextEditingController();
final lnameController = TextEditingController();
final passController = TextEditingController();

bool showWaiting = true;

List<Map<String, String>> subjectList = [];

String dropdownValue = '';
List<String> dropdownValueList = [];

Map<String, String> newAccauntMap ;

Map<String, String> curentAccaunt = {
  'fName': 'Эмиров',
  'sName': 'Шихахмед',
  'lName': 'Мурадович',
  'password': '02715' //10519
};

List<Map<String, String> > accauntsList = [
  {
  'fName': 'Эмиров',
  'sName': 'Шихахмед',
  'lName': 'Мурадович',
  'password': '02715', //10519
  'degree': 'бакалавриат'
 },
 {
  'fName': 'Эмиров',
  'sName': 'Шихахмед',
  'lName': 'Мурадович',
  'password': '10519', //10519
  'degree': 'магистратура'
 }
 
];



 List<String> actionsPopUp = <String>[ 'Обновить' , 'Сменить тему', 'Сменить аккаунт'];
