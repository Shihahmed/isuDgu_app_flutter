import 'package:flutter/material.dart';
import 'package:isudgu_app/Providers/SubjectListProvider.dart';
import 'package:isudgu_app/Providers/accauntsProvider.dart';
import 'package:isudgu_app/Providers/themeProvider.dart';
import 'package:provider/provider.dart';

class AboutStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SubjectListProvider>(
        builder: (context, subjectListProvider, child) {
      if (subjectListProvider.subjectList.isEmpty)
        return Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(
                  themeProvider.progressCircleColor),
              strokeWidth: 7,
            ),
          );
        });
      else
        return Consumer<AccauntsProvider>(
            builder: (context, accauntsProvider, child) {
          return Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
            Color _fontColor = themeProvider.subtitleFontColor;
            return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    "Направление: " + accauntsProvider.currentAccaunt["degree"],
                    style: TextStyle(color: _fontColor),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    "Факультет: ",
                    style: TextStyle(color: _fontColor),
                  ),
                  Text(
                    accauntsProvider.currentAccaunt["faculty"],
                    style: TextStyle(color: _fontColor),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    "Кафедра: ",
                    style: TextStyle(color: _fontColor),
                  ),
                  Text(
                    accauntsProvider.currentAccaunt["department"],
                    overflow: TextOverflow.fade,
                    style: TextStyle(color: _fontColor),
                  ),
                ]);
          });
        });
    });
  }
}
