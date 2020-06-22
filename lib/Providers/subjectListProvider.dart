import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:isudgu_app/Providers/dropdownValueListProvider.dart';
import 'package:isudgu_app/script.dart';

//Provider for work with CardGrid

class SubjectListProvider extends ChangeNotifier{

  List<Map<String, String>> _subjectList =  [];
  

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

  Future<void> updateSubjectList(DropdownValueListProvider dropdownValueListProvider,Map<String, String> currentAccaunt) async{
    //if(currentAccaunt != {}){
      _subjectList = await Parser().parseHtml(currentAccaunt, dropdownValueListProvider);

      notifyListeners();
    //}
  }


}