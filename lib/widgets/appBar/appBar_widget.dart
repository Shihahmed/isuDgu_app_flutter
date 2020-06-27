import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isudgu_app/Providers/SubjectListProvider.dart';
import 'package:isudgu_app/Providers/accauntsProvider.dart';
import 'package:isudgu_app/Providers/dropdownValueListProvider.dart';
import 'package:isudgu_app/Providers/themeProvider.dart';
import 'package:isudgu_app/widgets/appBar/accauntDialogs_class.dart';

import 'package:isudgu_app/widgets/appBar/aboutStudent_widget.dart';
import 'package:isudgu_app/widgets/appBar/semestrDropDownButton_widget.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatelessWidget {
  final Dialogs dialogs = new Dialogs();

  final List<String> actionsPopUp = <String>['Сменить тему', 'Сменить аккаунт'];

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return SliverAppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.school,
              color: themeProvider.fontColor,
            ),
            SizedBox(
              width: 5,
            ),
            Consumer<AccauntsProvider>(
                builder: (context, accauntsProvider, child) {
              if (accauntsProvider.currentAccaunt.length > 0) {
                return Text(
                  accauntsProvider.currentAccaunt['fName'] +
                      ' ' +
                      accauntsProvider.currentAccaunt['sName'][0] +
                      '. ' +
                      accauntsProvider.currentAccaunt['lName'][0] +
                      '.',
                  style: TextStyle(
                    color: themeProvider.fontColor,
                    fontSize: 17,
                  ),
                );
              } else {
                return SizedBox();
              }
            }),
            SizedBox(
              width: 10,
            ),
            SemestrDropDownButton(),
          ],
        ),
        pinned: true,
        backgroundColor: themeProvider.scafoldBackgroundColor,
        expandedHeight: 175.0,
        flexibleSpace: FlexibleSpaceBar(
          stretchModes: const <StretchMode>[],
          background: Padding(
            padding: const EdgeInsets.all(25.0),
            child: AboutStudent(),
          ),
        ),
        actions: <Widget>[
          Builder(
            builder: (BuildContext context) {
              return Consumer<AccauntsProvider>(
                  builder: (context, accauntsProvider, child) {
                return Consumer<DropdownValueListProvider>(
                    builder: (context, dropdownValueListProvider, child) {
                  return Consumer<ThemeProvider>(
                      builder: (context, themeProvider, child) {
                    return Consumer<SubjectListProvider>(
                        builder: (context, subjectListProvider, child) {
                      refresh() async {
                        subjectListProvider.subjectList = [];
                        await subjectListProvider.updateSubjectList(
                            dropdownValueListProvider,
                            accauntsProvider.currentAccaunt);
                      }

                      return PopupMenuButton<String>(
                        icon: Icon(
                          Icons.more_vert,
                          color: themeProvider.fontColor,
                        ),
                        color: themeProvider.scafoldBackgroundColor,
                        onSelected: (String choise) async {
                          if (choise == 'Сменить тему') {
                            themeProvider.changeTheme();
                            themeProvider.saveTheme();
                          } else if (choise == 'Сменить аккаунт') {
                            await dialogs.accaunts(
                                context, accauntsProvider, themeProvider);

                            subjectListProvider.subjectList = [];
                            dropdownValueListProvider.clear();
                            await subjectListProvider.updateSubjectList(
                                dropdownValueListProvider,
                                accauntsProvider.currentAccaunt);
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return actionsPopUp.map((String choise) {
                            return PopupMenuItem<String>(
                              value: choise,
                              child: Text(
                                choise,
                                style:
                                    TextStyle(color: themeProvider.fontColor),
                              ),
                            );
                          }).toList();
                        },
                      );
                    });
                  });
                });
              });
            },
          ),
        ],
      );
    });
  }
}
