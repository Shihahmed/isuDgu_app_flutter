import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier{

  ThemeProvider()  {
    {
      
      loadTheme();

    }
  }

  Future<SharedPreferences> _prefsTh = SharedPreferences.getInstance();

  SharedPreferences prefs;

  void loadTheme()async{

    prefs = await _prefsTh;
    _theme = prefs.getBool('theme') ?? true;

    if (_theme == false){
      setDarkTheme();
    }else{
      setWhiteTheme();
    }

    notifyListeners();
   

  }

  void saveTheme()async{

    prefs.setBool('theme', _theme);

  }
  
  Color _fontColor;
  Color _subtitleFontColor;
  Color _scafoldBackgroundColor;
  Color _cardBackgroundColor;
  Color _primaryColor;

  Color get fontColor => _fontColor;
  Color get subtitleFontColor => _subtitleFontColor;
  Color get scafoldBackgroundColor => _scafoldBackgroundColor;
  Color get cardBackgroundColor => _cardBackgroundColor;
  Color get primaryColor => _primaryColor;

  void setWhiteTheme(){
    _fontColor = Colors.black;
    _subtitleFontColor = Colors.grey;
    _scafoldBackgroundColor = Colors.white;
    _cardBackgroundColor = Color.fromRGBO(242, 242, 240, 1);
    _primaryColor = Colors.grey;

    notifyListeners();
  }
  
  void setDarkTheme(){
    _fontColor = Colors.white;
    _subtitleFontColor = Colors.grey;
    _scafoldBackgroundColor = Colors.black;
    _cardBackgroundColor = Color.fromRGBO(34, 34, 34, 1); // 55, 55, 55 
    _primaryColor = Colors.grey;
    notifyListeners();
  }

  bool _theme;

   set  theme(bool newTheme){

    _theme = newTheme;
    notifyListeners();

  }

  void changeTheme(){
    if (_theme == true){
      _theme = false;
      setDarkTheme();
      notifyListeners();
    }else{
      _theme = true;
      setWhiteTheme();
      notifyListeners();
    }
  }
}