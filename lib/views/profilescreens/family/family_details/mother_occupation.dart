import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';

class MotherOccupationBottomSheet extends StatefulWidget {
  final MotherOccupation? occupation;

  const MotherOccupationBottomSheet({Key? key, this.occupation})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MotherOccupationBottomSheetState();
  }
}

class MotherOccupationBottomSheetState
    extends State<MotherOccupationBottomSheet> {
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
              "Select Mother's Occupation:",
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
                          Text(
                              AppHelper.getStringFromEnum(
                                  MotherOccupation.values[index]),
                              style: MmmTextStyles.bodyMediumSmall(
                                  textColor: this.widget.occupation ==
                                          MotherOccupation.values[index]
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
                      Navigator.of(context).pop(MotherOccupation.values[index]);
                    },
                  );
                },
                itemCount: MotherOccupation.values.length,
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
