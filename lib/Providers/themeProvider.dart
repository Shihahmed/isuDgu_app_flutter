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
  Color _progressCircleColor;

  Color get fontColor => _fontColor;
  Color get subtitleFontColor => _subtitleFontColor;
  Color get scafoldBackgroundColor => _scafoldBackgroundColor;
  Color get cardBackgroundColor => _cardBackgroundColor;
  Color get primaryColor => _primaryColor;
  Color get progressCircleColor => _progressCircleColor;

  void setWhiteTheme(){
    _fontColor = Colors.black;
    _subtitleFontColor = Colors.black87;
    _scafoldBackgroundColor = Colors.white;
    _cardBackgroundColor = Color.fromRGBO(242, 242, 240, 1);
    _primaryColor = Colors.grey;
    _progressCircleColor = Colors.grey;

    notifyListeners();
  }
  
  void setDarkTheme(){
    _fontColor = Colors.white;
    _subtitleFontColor = Color.fromRGBO(171, 178, 191, 1);
    _scafoldBackgroundColor = Color.fromRGBO(33, 37, 43, 1);
    _cardBackgroundColor = Color.fromRGBO(54, 61, 70, 1);  // 55, 55, 55 
    _primaryColor = Colors.grey;
    _progressCircleColor = Color.fromRGBO(54, 61, 70, 1);
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