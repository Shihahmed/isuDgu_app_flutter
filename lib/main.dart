import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isudgu_app/Providers/accauntsProvider.dart';
import 'package:isudgu_app/Providers/dropdownValueListProvider.dart';
import 'package:isudgu_app/Providers/themeProvider.dart';
import 'package:isudgu_app/widgets/appBar/accauntDialogs_class.dart';
import 'package:isudgu_app/widgets/cardGrid/cardGrid_widget.dart';
import 'package:isudgu_app/widgets/appBar/appBar_widget.dart';
import 'package:isudgu_app/widgets/startPage/startPage_widget.dart';
import 'package:provider/provider.dart';

import 'Providers/SubjectListProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //disable orientations change
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: themeProvider.primaryColor,
            primarySwatch: themeProvider.primaryColor,
          ),
          home: new HomePage(),
        );
      }),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final Dialogs dialog = new Dialogs();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SubjectListProvider()),
        ChangeNotifierProvider(create: (context) => AccauntsProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(
            create: (context) => DropdownValueListProvider()),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return Scaffold(
          backgroundColor: themeProvider.scafoldBackgroundColor,
          body: Consumer<AccauntsProvider>(
              builder: (context, accauntsProvider, child) {
            if (accauntsProvider.currentAccaunt == null) {
              return Container();
            } else if (accauntsProvider.currentAccaunt.length < 1) {
              return StartPage(accauntsProvider,themeProvider);
            } else {
              return SafeArea(
                child: CustomScrollView(
                  slivers: <Widget>[
                    AppBarWidget(),
                    CardGrid(),
                  ],
                ),
              );
            }
          }),
        );
      }),
    );
  }
}
