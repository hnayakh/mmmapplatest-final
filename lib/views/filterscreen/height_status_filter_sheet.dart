import 'package:flutter/material.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';

class HeightStatusFilterSheet extends StatefulWidget {
  final dynamic selectedHeightStatus;

  HeightStatusFilterSheet({Key? key, this.selectedHeightStatus})
      : super(key: key);

  @override
  _HeightStatusFilterSheetState createState() =>
      _HeightStatusFilterSheetState();
}

class _HeightStatusFilterSheetState extends State<HeightStatusFilterSheet> {
  bool _checked = false;

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
              'Select Height:',
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
                              index == 0
                                  ? '${AppHelper.getHeightsFilter()[index]}'
                                  : '${AppHelper.getHeightsFilter()[index].toStringAsFixed(1)} ft',
                              style: MmmTextStyles.bodyMediumSmall(
                                  textColor:
                                      index == this.widget.selectedHeightStatus
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
                    //  Navigator.of(context).pop(index);
                    // },
                    onChanged: (bool? value) {
                      // setState(() {
                      //   _checked = value!;
                      //  });
                      Navigator.of(context).pop(index);
                    },
                    value: index == this.widget.selectedHeightStatus
                        ? true
                        : false,
                  );
                },
                itemCount: AppHelper.getHeights().length,
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
