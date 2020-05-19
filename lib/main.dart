import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isudgu_app/Providers/accauntsProvider.dart';
import 'package:isudgu_app/Providers/dropdownValueListProvider.dart';
import 'package:isudgu_app/widgets/appBar/accauntDialogs_class.dart';
import 'package:isudgu_app/widgets/cardGrid/cardGrid_widget.dart';
import 'package:isudgu_app/widgets/appBar/appBar_widget.dart';
import 'package:provider/provider.dart';

import 'Providers/SubjectListProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.grey,
        primarySwatch: Colors.grey,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SubjectListProvider()),
          ChangeNotifierProvider(create: (context) => AccauntsProvider()),
          ChangeNotifierProvider(
              create: (context) => DropdownValueListProvider()),
        ],
        child: _MyHomePageState(),
      ),
    );
  }
}

class _MyHomePageState extends StatelessWidget {
  final Dialogs dialog = new Dialogs();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              AppBarWidget(),
              CardGrid(),
            ],
          ),
        ));
  }
}
