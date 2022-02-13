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
    'No Income',
    '0-1 lakh',
    '1-2 lakh',
    '2-3 lakh',
    '3-4 lakh',
    '4-5 lakh',
    '5-7.5 lakh',
    '7.5-10 lakh',
    '10-15 lakh',
    '15-20 lakh',
    '20-25 lakh',
    '25-35 lakh',
    '35-50 lakh',
    '50-75 lakh',
    '75 lakh- 1 crore',
    '1 crore and above'
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
