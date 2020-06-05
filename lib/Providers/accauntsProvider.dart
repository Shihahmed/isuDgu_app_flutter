import 'package:flutter/foundation.dart';
import 'package:isudgu_app/script.dart';

class AccauntsProvider extends ChangeNotifier {

  List<Map<String, String>> _accauntsList = [
    /*
    {
      'fName': 'Эмиров',
      'sName': 'Шихахмед',
      'lName': 'Мурадович',
      'password': '02715', //10519
      'degree': 'бакалавриат',
      'faculty': 'Математики и компьютерных наук',
      'department': 'Прикладная математика и информатика'
    },
    {
      'fName': 'Эмиров',
      'sName': 'Шихахмед',
      'lName': 'Мурадович',
      'password': '10519', //10519
      'degree': 'магистратура',
      'faculty': 'Математики и компьютерных наук',
      'department': 'Прикладная математика и информатика--'
    }
    */
  ];

  Map<String, String> _currentAccaunt = {/*
    'fName': 'Эмиров',
    'sName': 'Шихахмед',
    'lName': 'Мурадович',
    'password': '02715', //10519
    'faculty': 'Математики и компьютерных наук',
    'department': 'Прикладная математика и информатика'
    */
  };

  bool _showError = false;

  bool get showError => _showError;

  set showError(bool showError){
    _showError = showError;
    notifyListeners();
  }

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

  Future<bool> validate(Map<String, String> newAccauntMap) async{

    return Parser().validate(newAccauntMap);

  }

  Future<Map<String, String>> reedAboutStudent( Map<String, String> newAccauntMap) async{

    return Parser().reedAboutStudent(newAccauntMap);

  }

}
