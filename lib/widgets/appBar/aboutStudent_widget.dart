import 'package:flutter/material.dart';
import 'package:isudgu_app/Providers/SubjectListProvider.dart';
import 'package:isudgu_app/Providers/accauntsProvider.dart';
import 'package:provider/provider.dart';

class AboutStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SubjectListProvider>(
        builder: (context, subjectListProvider, child) {
      if (subjectListProvider.showWaiting)
        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 7,
          ),
        );
      else
        return Consumer<AccauntsProvider>(
            builder: (context, accauntsProvider, child) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text("Направление: " + accauntsProvider.currentAccaunt["degree"]),
                SizedBox(
                  height: 3,
                ),
                Text("Факультет: "),
                Text(accauntsProvider.currentAccaunt["faculty"]),
                SizedBox(
                  height: 3,
                ),
                Text("Кафедра: "),
                Text(accauntsProvider.currentAccaunt["department"],
                  overflow: TextOverflow.fade,
                ),
              ]);
        });
    });
  }
}
