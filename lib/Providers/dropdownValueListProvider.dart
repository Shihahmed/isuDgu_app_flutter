import 'package:flutter/foundation.dart';
import 'package:isudgu_app/script.dart';

class DropdownValueListProvider extends ChangeNotifier{

    String _dropdownValue = '';
    List<String> _dropdownValueList = [];

    String get dropdownValue => _dropdownValue;

    set dropdownValue(String value){
      _dropdownValue = value;
      notifyListeners();
    }

  

    List<String> get dropdownValueList => _dropdownValueList;

    void maxDropdownValue(String value){

      _dropdownValueList.clear();
      for(int i = 1; i<= int.parse(value); i++ ){
          
        _dropdownValueList.add( i.toString() );

      }

      notifyListeners();
    }

    void clear(){
      _dropdownValue = "";
      _dropdownValueList.clear();
      notifyListeners();
    }


}