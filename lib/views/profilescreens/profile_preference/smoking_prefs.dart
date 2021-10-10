import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

import 'package:flutter/material.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';

class SmokingPrefs extends StatefulWidget {
  final SmokingHabit? eatingHabit;

  const SmokingPrefs({Key? key, this.eatingHabit}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SmokingPrefsScreen();
  }
}

class SmokingPrefsScreen extends State<SmokingPrefs> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: kMargin16,
        height: 320,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MmmButtons.backButton(context),
            SizedBox(
              height: 24,
            ),
            Text(
              'Select Smoking Habit:',
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
                          Text(describeEnum(SmokingHabit.values[index]),
                              style: MmmTextStyles.bodyMediumSmall(
                                  textColor: SmokingHabit.values[index] ==
                                      widget.eatingHabit
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
                      Navigator.of(context).pop(SmokingHabit.values[index]);
                    },
                  );
                },
                itemCount: SmokingHabit.values.length,
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
