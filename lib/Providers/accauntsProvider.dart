import 'package:flutter/foundation.dart';

class AccauntsProvider extends ChangeNotifier {

  List<Map<String, String>> _accauntsList = [
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

  Map<String, String> _currentAccaunt = {
    'fName': 'Эмиров',
    'sName': 'Шихахмед',
    'lName': 'Мурадович',
    'password': '02715' //10519
  };

  List<Map<String, String>> get accauntsList => _accauntsList;

  void addToAccauntsList(Map<String, String> newAccaunt){

    _accauntsList.add(newAccaunt);
    notifyListeners();

  }

  void deleteFromAccauntsListByIndex(int index){

    _accauntsList.removeAt(index);
    notifyListeners();

  }

  Map<String, String> get currentAccaunt => _currentAccaunt;

  set currentAccaunt(Map<String, String> newCurentAccaunt){

    _currentAccaunt = newCurentAccaunt;
    notifyListeners();

  }

  void update(){
    _accauntsList = _accauntsList;
    notifyListeners();
  }

}
