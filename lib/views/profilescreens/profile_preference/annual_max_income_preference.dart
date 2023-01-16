import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';

class AnnualMaxIncomePreference extends StatefulWidget {
  final List<AnualIncome> list;
  final List<AnualIncome> listMax;
  final int minimumSelectedIndex;
  const AnnualMaxIncomePreference(
      {Key? key,
      required this.list,
      required this.listMax,
      required this.minimumSelectedIndex})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AnnualMaxIncomePreferenceScreen(list, listMax, minimumSelectedIndex);
  }
}

class AnnualMaxIncomePreferenceScreen extends State<AnnualMaxIncomePreference> {
  List<AnualIncome> list;
  List<AnualIncome> listMax;
  int minimumSelectedIndex;
  AnnualMaxIncomePreferenceScreen(
      this.list, this.listMax, this.minimumSelectedIndex);
  List<String> incomes = [
    'No Income',
    '1 lakh',
    '2 lakh',
    '3 lakh',
    '4 lakh',
    '5 lakh',
    '7.5 lakh',
    '10 lakh',
    '15 lakh',
    '20 lakh',
    '25 lakh',
    '35 lakh',
    '50 lakh',
    '75 lakh',
    '1 crore',
    '1 crore and above'
  ];

  @override
  Widget build(BuildContext context) {
    if (this.list.length > 0) {}
    print(this.minimumSelectedIndex);
    return Container(
        padding: kMargin16,
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MmmButtons.backButton(context),
            SizedBox(
              height: 24,
            ),
            Text(
              'Select Annual Income:',
              style: MmmTextStyles.bodyMedium(textColor: kDark5),
            ),
            SizedBox(
              height: 8,
            ),
            Divider(
              color: kLight4,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              //height: 210,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.only(top: 8),
                    title: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                      incomes.sublist(
                                          this.minimumSelectedIndex)[index],
                                      style: MmmTextStyles.bodyMediumSmall(
                                          textColor: isSelected(AnualIncome
                                                      .values
                                                      .sublist(this
                                                          .minimumSelectedIndex)[
                                                  index])
                                              ? kPrimary
                                              : kModalPrimary))),
                              isSelected(AnualIncome.values.sublist(
                                      this.minimumSelectedIndex)[index])
                                  ? Icon(
                                      Icons.check,
                                      color: kPrimary,
                                    )
                                  : Container(
                                      height: 24,
                                    )
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Divider(
                            color: kLight4,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        setSelected(AnualIncome.values
                            .sublist(this.minimumSelectedIndex)[index]);
                      });
                      // Navigator.of(context).pop(MaritalStatus.values[index]);
                    },
                  );
                },
                itemCount:  incomes.sublist(
                    this.minimumSelectedIndex).length,
                // separatorBuilder: (context, index) {
                //   return Divider(
                //     color: kLight4,
                //   );
                // },
              ),
            ),
            MmmButtons.primaryButton("Done", () {
              Navigator.of(context).pop(this.listMax);
            })
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ));
  }

  bool isSelected(AnualIncome value) {
    for (var item in listMax) {
      if (item == value) {
        return true;
      }
    }
    return false;
  }

  void setSelected(AnualIncome value) {
    print(list);
    print(listMax);
    this.listMax = [value];
    // bool isFound = false;
    // int index = 0;
    // for (var item in list) {
    //   if (item == value) {
    //     isFound = true;
    //     index = list.indexOf(item);
    //   }
    // }
    // if (!isFound) {
    //   this.list.add(value);
    // } else {
    //   this.list.removeAt(index);
    // }
  }
}
