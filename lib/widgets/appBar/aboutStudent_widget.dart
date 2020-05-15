import 'package:flutter/material.dart';
import 'package:isudgu_app/Providers/SubjectListProvider.dart';
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
        return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text("Направление: бакалавриат"),
              SizedBox(
                height: 3,
              ),
              Text("Факультет: "),
              Text("Математики и компьютерных наук"),
              SizedBox(
                height: 3,
              ),
              Text("Кафедра: "),
              Text(
                "Прикладная математика и информатика",
                overflow: TextOverflow.fade,
              ),
            ]);
    });
  }
}
