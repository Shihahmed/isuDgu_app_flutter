import 'package:flutter/foundation.dart';
import 'package:isudgu_app/script.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AccauntsProvider extends ChangeNotifier {
  //test

  
  Future<SharedPreferences> _prefsAc = SharedPreferences.getInstance();

  SharedPreferences prefs;

  void loadAccaunts()async{
    prefs = await _prefsAc;
    List<String> buffer = prefs.getStringList('accauntsList') ?? [];

    buffer.forEach((acc) {
      List<String> accSplited = acc.split('-');
      Map<String,String> map = {
        'fName': accSplited[0],
        'sName': accSplited[1],
        'lName': accSplited[2],
        'password': accSplited[3],
        'degree': accSplited[4],
        'faculty': accSplited[5],
        'department': accSplited[6]
      };
      _accauntsList.add(map);
    });

    String _currentAccauntbuffer = prefs.getString('currentAccaunt') ?? '';
    if (_currentAccauntbuffer.length > 0){
       List<String> _currentAccauntbufferSplited = _currentAccauntbuffer.split('-');
    _currentAccaunt = {
        'fName': _currentAccauntbufferSplited[0],
        'sName': _currentAccauntbufferSplited[1],
        'lName': _currentAccauntbufferSplited[2],
        'password': _currentAccauntbufferSplited[3],
        'degree': _currentAccauntbufferSplited[4],
        'faculty': _currentAccauntbufferSplited[5],
        'department': _currentAccauntbufferSplited[6]
      };
    }else{_currentAccaunt = {};}

    notifyListeners();
    update();
   

  }

  void saveAccaunts(){
    List<String> buffer = [] ;

    _accauntsList.forEach((acc) {

      String str= acc['fName'] +'-'+acc['sName']+'-'+acc['lName']+'-'+acc['password']+'-'+acc['degree']+'-'+acc['faculty'] +'-'+acc['department'];

      buffer.add(str); 

     });
    String str = '';

    if (_currentAccaunt.length > 0){
     str += _currentAccaunt['fName'] +'-'+_currentAccaunt['sName']+'-'+_currentAccaunt['lName']+'-'+_currentAccaunt['password']+'-'+_currentAccaunt['degree']+'-'+_currentAccaunt['faculty'] +'-'+_currentAccaunt['department'];
    }

    prefs.setStringList('accauntsList', buffer);
    prefs.setString('currentAccaunt', str);
  }

  AccauntsProvider()  {
    {
      
      loadAccaunts();

    }
  }

  //_
  List<Map<String, String>> _accauntsList = [];

  Map<String, String> _currentAccaunt;

  int _validation = 0;

  int get validation => _validation;

  set validation(int validation) {
    _validation = validation;
    notifyListeners();
  }

  List<Map<String, String>> get accauntsList => _accauntsList;

  String correctName(String name){

    name = name.trim();
    String newName = name[0].toUpperCase();

    for(int i = 1; i<name.length;i++){
      newName += name[i].toLowerCase();
    }

    return newName;
    
  }

  void addToAccauntsList(Map<String, String> newAccaunt) {

    newAccaunt['fName'] = correctName(newAccaunt['fName']);
    newAccaunt['sName'] = correctName(newAccaunt['sName']);
    newAccaunt['lName'] = correctName(newAccaunt['lName']);

    _accauntsList.add(newAccaunt);
    notifyListeners();

  }

  void deleteFromAccauntsListByIndex(int index) {
    _accauntsList.removeAt(index);
    if(_accauntsList.isEmpty){
      currentAccaunt = {};
    }
    notifyListeners();
  }

  Map<String, String> get currentAccaunt => _currentAccaunt;

  set currentAccaunt(Map<String, String> newCurentAccaunt) {
    _currentAccaunt = newCurentAccaunt;
    notifyListeners();
  }

  void update() {
    _accauntsList = _accauntsList;
    notifyListeners();
  }

  Future<bool> validate(Map<String, String> newAccauntMap) async {
    return Parser().validate(newAccauntMap);
  }

  Future<Map<String, String>> reedAboutStudent(
      Map<String, String> newAccauntMap) async {
    return Parser().reedAboutStudent(newAccauntMap);
  }

}
