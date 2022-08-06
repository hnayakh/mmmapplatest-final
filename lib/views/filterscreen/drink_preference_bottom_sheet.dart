import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';

class DrinkStatusFilterSheet extends StatefulWidget {
  final DrinkingHabitFilter? selectedDrinkStatus;
  const DrinkStatusFilterSheet({Key? key, required this.selectedDrinkStatus})
      : super(key: key);

  @override
  _DrinkStatusFilterSheetState createState() => _DrinkStatusFilterSheetState();
}

class _DrinkStatusFilterSheetState extends State<DrinkStatusFilterSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: kMargin16,
        height: 440,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MmmButtons.backButton(context),
            SizedBox(
              height: 24,
            ),
            Text(
              'Select marital status:',
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
                  return CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                    contentPadding: const EdgeInsets.only(top: 8),
                    title: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                              DrinkingHabitFilter.values[index] ==
                                      DrinkingHabitFilter.DoesnotMatter
                                  ? 'Doesnot Matter'
                                  : describeEnum(
                                      DrinkingHabitFilter.values[index]),
                              style: MmmTextStyles.bodyMediumSmall(
                                  textColor:
                                      DrinkingHabitFilter.values[index] ==
                                              this.widget.selectedDrinkStatus
                                          ? kPrimary
                                          : kModalPrimary)),
                          SizedBox(
                              //height: 8,
                              ),
                          Divider(
                            color: kLight4,
                          ),
                        ],
                      ),
                    ),
                    // onTap: () {
                    //     Navigator.of(context).pop(MaritalStatus.values[index]);
                    //  },
                    onChanged: (bool? value) {
                      //setState(() {
                      //   _checked = value!;
                      //  });
                      Navigator.of(context)
                          .pop(DrinkingHabitFilter.values[index]);
                    },
                    value: DrinkingHabitFilter.values[index] ==
                            this.widget.selectedDrinkStatus
                        ? true
                        : false,
                  );
                },
                itemCount: DrinkingHabitFilter.values.length,
                // separatorBuilder: (context, index) {
                //   return Divider(
                //     color: kLight4,
                //   );
                // },
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ));
  }
}
