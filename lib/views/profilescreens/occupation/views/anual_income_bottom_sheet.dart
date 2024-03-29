import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';

class AnnualIncomeBottomSheet extends StatefulWidget {
  final AnnualIncome? income;

  const AnnualIncomeBottomSheet({Key? key, this.income}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AnnualIncomeBottomSheetState();
  }
}

class AnnualIncomeBottomSheetState extends State<AnnualIncomeBottomSheet> {
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
                              //incomes[index]
                              AppHelper.getStringFromEnum(
                                  AnnualIncome.values[index]),
                              style: MmmTextStyles.bodyMediumSmall(
                                  textColor:
                                      AnnualIncome.values[index] == widget.income
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
                      Navigator.of(context).pop(AnnualIncome.values[index]);
                      print(AnnualIncome.values[index]);
                    },
                  );
                },
                itemCount: AnnualIncome.values.length - 1,
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
