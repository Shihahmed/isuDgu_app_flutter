import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:isudgu_app/Providers/SubjectListProvider.dart';
import 'package:isudgu_app/Providers/accauntsProvider.dart';
import 'package:isudgu_app/Providers/dropdownValueListProvider.dart';
import 'package:isudgu_app/widgets/appBar/accauntDialogs_class.dart';
import 'package:provider/provider.dart';

class SemestrDropDownButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AccauntsProvider>(
        builder: (context, accauntsProvider, child) {
      return Consumer<SubjectListProvider>(
          builder: (context, subjectListProvider, child) {
        return Consumer<DropdownValueListProvider>(
            builder: (context, dropdownValueListProvider, child) {
          final Dialogs dialog = new Dialogs();

          Future<bool> haveInternet() async {
            var connectivityResult = await (Connectivity().checkConnectivity());
            if (connectivityResult == ConnectivityResult.mobile) {
              return true;
            } else if (connectivityResult == ConnectivityResult.wifi) {
              return true;
            } else {
              await dialog.noInternetDialog(context);

              if (await haveInternet() == false) {
                await haveInternet();
              } else {
                return true;
              }
            }
          }

          return DropdownButton(
            value: dropdownValueListProvider.dropdownValue,
            iconEnabledColor: Colors.black,
            underline: Container(),
            onChanged: (String newValue) async {
              if (await haveInternet() == true) {
                dropdownValueListProvider.dropdownValue = newValue;

                if (subjectListProvider.subjectList.isNotEmpty) {
                  subjectListProvider.subjectList = [];
                }

                await subjectListProvider.updateSubjectList(
                    dropdownValueListProvider, accauntsProvider.currentAccaunt);
              }
            },
            items: dropdownValueListProvider.dropdownValueList
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value + " семестр",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
              );
            }).toList(),
          );
        });
      });
    });
  }
}
