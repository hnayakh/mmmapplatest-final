import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';

class AnnualIncomePreference extends StatefulWidget {
  final List<AnualIncome> list;

  const AnnualIncomePreference({Key? key, required this.list})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AnnualIncomePreferenceScreen(list);
  }
}

class AnnualIncomePreferenceScreen extends State<AnnualIncomePreference> {
  List<AnualIncome> list;
  AnnualIncomePreferenceScreen(this.list);
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
                                  child: Text(incomes[index],
                                      style: MmmTextStyles.bodyMediumSmall(
                                          textColor: isSelected(
                                                  AnualIncome.values[index])
                                              ? kPrimary
                                              : kModalPrimary))),
                              isSelected(AnualIncome.values[index])
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
                        setSelected(AnualIncome.values[index]);
                      });
                      // Navigator.of(context).pop(MaritalStatus.values[index]);
                    },
                  );
                },
                itemCount: AnualIncome.values.length,
                // separatorBuilder: (context, index) {
                //   return Divider(
                //     color: kLight4,
                //   );
                // },
              ),
            ),
            MmmButtons.primaryButton("Done", () {
              Navigator.of(context).pop(this.list);
            })
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ));
  }

  bool isSelected(AnualIncome value) {
    for (var item in list) {
      if (item == value) {
        return true;
      }
    }
    return false;
  }

  void setSelected(AnualIncome value) {
    bool isFound = false;
    int index = 0;
    for (var item in list) {
      if (item == value) {
        isFound = true;
        index = list.indexOf(item);
      }
    }
    if (!isFound) {
      this.list.add(value);
    } else {
      this.list.removeAt(index);
    }
  }
}
