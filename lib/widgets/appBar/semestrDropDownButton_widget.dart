import 'package:flutter/material.dart';
import 'package:isudgu_app/Providers/SubjectListProvider.dart';
import 'package:isudgu_app/Providers/accauntsProvider.dart';
import 'package:isudgu_app/Providers/dropdownValueListProvider.dart';
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
        return DropdownButton(
          value: dropdownValueListProvider.dropdownValue,
          iconEnabledColor: Colors.black,
          underline: Container(),
          onChanged: (String newValue) async{
            dropdownValueListProvider.dropdownValue = newValue;
            subjectListProvider.showWaiting = true;
            print("dropdown");
            print(accauntsProvider.currentAccaunt);
            await subjectListProvider.updateSubjectList(dropdownValueListProvider,accauntsProvider.currentAccaunt);
            

            subjectListProvider.showWaiting = false;
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
