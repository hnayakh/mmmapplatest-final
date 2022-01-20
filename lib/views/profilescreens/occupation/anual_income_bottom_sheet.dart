import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';

class AnnualIncomeBottomSheet extends StatefulWidget {
  final AnualIncome? income;

  const AnnualIncomeBottomSheet({Key? key, this.income}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AnnualIncomeBottomSheetState();
  }
}

class AnnualIncomeBottomSheetState extends State<AnnualIncomeBottomSheet> {
  List<String> incomes = [
    'Less Than 1Lacs',
    '1 to 3Lacs',
    '3 to 5Lacs',
    '5 to 7Lacs',
    '7 to 10Lacs',
    '10 to 12Lacs',
    'More than 12Lacs'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [MmmButtons.backButton(context)],
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              'Select Annual Salary:',
              style: MmmTextStyles.bodyMedium(textColor: kDark5),
            ),
            SizedBox(
              height: 16,
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
                          Text(
                              //describeEnum(AnualIncome.values[index])
                              incomes[index],
                              style: MmmTextStyles.bodyMediumSmall(
                                  textColor:
                                      AnualIncome.values[index] == widget.income
                                          ? kPrimary
                                          : kModalPrimary)),
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
                      Navigator.of(context).pop(AnualIncome.values[index]);
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
            )
          ],
        ),
        padding: kMargin16,
        height: 530,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ));
  }
}
