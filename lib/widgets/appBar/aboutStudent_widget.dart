import 'package:auto_size_text/auto_size_text.dart';
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
                  Row(
                    children: <Widget>[
                      AutoSizeText(
                        "Направление: ",
                        maxFontSize: 14,
                        style: TextStyle(
                            color: _fontColor, fontWeight: FontWeight.bold),
                      ),
                       AutoSizeText(
                    accauntsProvider.currentAccaunt["degree"],
                    style: TextStyle(
                        color: _fontColor, fontStyle: FontStyle.italic),
                    maxLines: 2,
                    maxFontSize: 14,
                  ),
                    ],
                  ),
                 
                  SizedBox(
                    height: 3,
                  ),
                  AutoSizeText(
                    "Факультет: ",
                    maxFontSize: 14,
                    style: TextStyle(
                        color: _fontColor, fontWeight: FontWeight.bold),
                  ),
                  AutoSizeText(
                    accauntsProvider.currentAccaunt["faculty"],
                    maxFontSize: 14,
                    style: TextStyle(
                        color: _fontColor, fontStyle: FontStyle.italic),
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  AutoSizeText(
                    "Кафедра: ",
                    maxFontSize: 14,
                    style: TextStyle(
                        color: _fontColor, fontWeight: FontWeight.bold),
                  ),
                  AutoSizeText(
                    accauntsProvider.currentAccaunt["department"],
                    maxFontSize: 14,
                    style: TextStyle(
                        color: _fontColor, fontStyle: FontStyle.italic),
                    maxLines: 2,
                  ),
                ]);
          });
        });
    });
  }
}
