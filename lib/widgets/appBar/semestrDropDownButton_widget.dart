import 'dart:io';

import 'package:flutter/material.dart';
import 'package:isudgu_app/Providers/SubjectListProvider.dart';
import 'package:isudgu_app/Providers/accauntsProvider.dart';
import 'package:isudgu_app/Providers/dropdownValueListProvider.dart';
import 'package:isudgu_app/Providers/themeProvider.dart';
import 'package:isudgu_app/widgets/appBar/accauntDialogs_class.dart';
import 'package:provider/provider.dart';

class SemestrDropDownButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AccauntsProvider>(
        builder: (context, accauntsProvider, child) {
      return Consumer<SubjectListProvider>(
          builder: (context, subjectListProvider, child) {
        return Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
          return Consumer<DropdownValueListProvider>(
              builder: (context, dropdownValueListProvider, child) {
            final Dialogs dialog = new Dialogs();

            Future<bool> haveInternet() async {
              try {
                  final result = await InternetAddress.lookup('google.com');
                  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                    return true;
                  }
                } on SocketException catch (_) {
                  await dialog.noInternetDialog(context, themeProvider);

                  if (await haveInternet() == false) {
                    await haveInternet();
                  } else {
                    return true;
                  }
                }
            }

            return DropdownButton(
              dropdownColor: themeProvider.scafoldBackgroundColor,
              value: dropdownValueListProvider.dropdownValue,
              iconEnabledColor: themeProvider.fontColor,
              underline: Container(),
              onChanged: (String newValue) async {
                if (await haveInternet() == true) {
                  dropdownValueListProvider.dropdownValue = newValue;

                  if (subjectListProvider.subjectList.isNotEmpty) {
                    subjectListProvider.subjectList = [];
                  }

                  await subjectListProvider.updateSubjectList(
                      dropdownValueListProvider,
                      accauntsProvider.currentAccaunt);
                }
              },
              items: dropdownValueListProvider.dropdownValueList
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value + " семестр",
                    style: TextStyle(
                      color: themeProvider.fontColor,
                      fontSize: 17,
                    ),
                  ),
                );
              }).toList(),
            );
          });
        });
      });
    });
  }
}
