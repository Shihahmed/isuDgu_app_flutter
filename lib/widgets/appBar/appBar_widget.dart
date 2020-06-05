import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isudgu_app/Providers/SubjectListProvider.dart';
import 'package:isudgu_app/Providers/accauntsProvider.dart';
import 'package:isudgu_app/Providers/dropdownValueListProvider.dart';
import 'package:isudgu_app/widgets/appBar/accauntDialogs_class.dart';

import 'package:isudgu_app/widgets/appBar/aboutStudent_widget.dart';
import 'package:isudgu_app/widgets/appBar/semestrDropDownButton_widget.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatelessWidget {
  final Dialogs dialogs = new Dialogs();

  final List<String> actionsPopUp = <String>[
    'Обновить',
    'Сменить тему',
    'Сменить аккаунт'
  ];

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.school,
            color: Colors.black,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "Эмиров Ш. М.",
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          SemestrDropDownButton(),
        ],
      ),
      pinned: true,
      backgroundColor: Colors.white,
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
              return Consumer<SubjectListProvider>(
                  builder: (context, subjectListProvider, child) {
                    
                refresh() async {
                  subjectListProvider.showWaiting = true;
                  print("obnovit");
                  print(accauntsProvider.currentAccaunt);
                  await subjectListProvider.updateSubjectList(dropdownValueListProvider,accauntsProvider.currentAccaunt);

                  subjectListProvider.showWaiting = false;
                }

                return PopupMenuButton<String>(
                  onSelected: (String choise) async{
                    if (choise == 'Обновить') {
                      refresh();
                    } else if (choise == 'Сменить тему') {
                    } else if (choise == 'Сменить аккаунт') {
                      await dialogs.accaunts(context,accauntsProvider);
                      subjectListProvider.showWaiting = true;
                      dropdownValueListProvider.clear();
                      await subjectListProvider.updateSubjectList(dropdownValueListProvider,accauntsProvider.currentAccaunt);
                     

                      subjectListProvider.showWaiting = false;
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return actionsPopUp.map((String choise) {
                      return PopupMenuItem<String>(
                        value: choise,
                        child: Text(choise),
                      );
                    }).toList();
                  },
                );
              });
              });
            });
          },
        ),
      ],
    );
  }
}
