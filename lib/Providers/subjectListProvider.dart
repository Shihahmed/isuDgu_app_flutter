import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:isudgu_app/Providers/dropdownValueListProvider.dart';
import 'package:isudgu_app/script.dart';

//Provider for work with CardGrid

class SubjectListProvider extends ChangeNotifier{


  //For progress indicator in AppBar
  bool _showWaiting = false;//true

  set showWaiting(bool b) {

    _showWaiting = b;
    notifyListeners();

  }
  
  bool get showWaiting => _showWaiting;
  //_
  

  List<Map<String, String>> _subjectList = [];
  

  List<Map<String, String>> get subjectList{
    return _subjectList;
  }

  set subjectList(List<Map<String, String>> newSubjectList){
    _subjectList = newSubjectList;
    notifyListeners();
  }

  void addToSubjectList(Map<String, String> newSubject){
    _subjectList.add(newSubject);
    notifyListeners();
  }

  void updateSubjectList(DropdownValueListProvider dropdownValueListProvider) async{

    _subjectList = await Parser().parseHtml(dropdownValueListProvider);
    print(_subjectList[0]);

    notifyListeners();
    
  }

  


  


}