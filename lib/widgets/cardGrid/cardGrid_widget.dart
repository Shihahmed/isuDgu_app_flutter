import 'package:flutter/material.dart';
import 'package:isudgu_app/Providers/SubjectListProvider.dart';
import 'package:isudgu_app/Providers/accauntsProvider.dart';
import 'package:isudgu_app/Providers/dropdownValueListProvider.dart';
import 'package:isudgu_app/widgets/cardGrid/newCard_widget.dart';
import 'package:provider/provider.dart';

class CardGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AccauntsProvider>(
        builder: (context, accauntsProvider, child) {
      return Consumer<DropdownValueListProvider>(
          builder: (context, dropdownValueListProvider, child) {
        return Consumer<SubjectListProvider>(
            builder: (context, subjectListProvider, child) {
          refresh() async {
            subjectListProvider.showWaiting = true;
            await subjectListProvider.updateSubjectList(
                dropdownValueListProvider, accauntsProvider.currentAccaunt);
            subjectListProvider.showWaiting = false;
          }

          if (subjectListProvider.subjectList.length < 1) {
            refresh();
          }

          if (subjectListProvider.showWaiting) {
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
                return newCard(subjectListProvider.subjectList[index]);
              }),
            );
          }
        });
      });
    });
  }
}
