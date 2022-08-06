import 'package:flutter/material.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';

class DisabilityPreferenceFilterSheet extends StatefulWidget {
  final int? selectedDisabilityPreference;
  const DisabilityPreferenceFilterSheet(
      {Key? key, required this.selectedDisabilityPreference})
      : super(key: key);

  @override
  _DisabilityPreferenceFilterSheetState createState() =>
      _DisabilityPreferenceFilterSheetState();
}

class _DisabilityPreferenceFilterSheetState
    extends State<DisabilityPreferenceFilterSheet> {
  final List<String> disabilityType = [
    'Doesnot Matter',
    'Normal',
    'Physically Challenged',
  ];
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
              'Select Disability:',
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
                          Text(disabilityType[index],
                              style: MmmTextStyles.bodyMediumSmall(
                                  textColor: index ==
                                          this
                                              .widget
                                              .selectedDisabilityPreference
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
                    onChanged: (bool? value) {
                      Navigator.of(context).pop(index);
                    },
                    value: index == this.widget.selectedDisabilityPreference
                        ? true
                        : false,
                  );
                },
                itemCount: disabilityType.length,
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
