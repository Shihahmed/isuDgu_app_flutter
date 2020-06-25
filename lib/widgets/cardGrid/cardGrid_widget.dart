import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:isudgu_app/Providers/SubjectListProvider.dart';
import 'package:isudgu_app/Providers/accauntsProvider.dart';
import 'package:isudgu_app/Providers/dropdownValueListProvider.dart';
import 'package:isudgu_app/Providers/themeProvider.dart';
import 'package:isudgu_app/widgets/appBar/accauntDialogs_class.dart';
import 'package:isudgu_app/widgets/cardGrid/newCard_widget.dart';
import 'package:provider/provider.dart';

class CardGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AccauntsProvider>(
        builder: (context, accauntsProvider, child) {
      return Consumer<DropdownValueListProvider>(
          builder: (context, dropdownValueListProvider, child) {
        return Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
          return Consumer<SubjectListProvider>(
              builder: (context, subjectListProvider, child) {
            final Dialogs dialog = new Dialogs();

            Future<bool> haveInternet() async {
              var connectivityResult =
                  await (Connectivity().checkConnectivity());
              if (connectivityResult == ConnectivityResult.mobile) {
                return true;
              } else if (connectivityResult == ConnectivityResult.wifi) {
                return true;
              } else {
                await dialog.noInternetDialog(context  , themeProvider);

                if (await haveInternet() == false) {
                  await haveInternet();
                } else {
                  return true;
                }
              }
            }

            refresh() async {
              if (await haveInternet() == true) {
                if (subjectListProvider.subjectList.isNotEmpty) {
                  subjectListProvider.subjectList = [];
                }

                await subjectListProvider.updateSubjectList(
                    dropdownValueListProvider, accauntsProvider.currentAccaunt);
              }
            }

            if (subjectListProvider.subjectList.isEmpty) {
              int q;
              if (accauntsProvider.currentAccaunt.isEmpty) {
                q = 1;
              }
              refresh();
            }

            if (subjectListProvider.subjectList.isEmpty) {
              return SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(),
                ]),
              );
            } else {
              return SliverGrid.count(
                mainAxisSpacing: 15,
                childAspectRatio: (0.85),
                crossAxisCount: 2,
                children: List.generate(subjectListProvider.subjectList.length,
                    (index) {
                  return newCard(subjectListProvider.subjectList[index], themeProvider);
                }),
              );
            }
          });
        });
      });
    });
  }
}
