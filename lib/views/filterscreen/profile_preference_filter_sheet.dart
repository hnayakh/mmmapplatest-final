import 'package:flutter/material.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';

class ProfilePreferenceFilterSheet extends StatefulWidget {
  final int? selectedProfilePreference;
  const ProfilePreferenceFilterSheet(
      {Key? key, required this.selectedProfilePreference})
      : super(key: key);

  @override
  _ProfilePreferenceFilterSheetState createState() =>
      _ProfilePreferenceFilterSheetState();
}

class _ProfilePreferenceFilterSheetState
    extends State<ProfilePreferenceFilterSheet> {
  final List<String> profileby = [
    'Doesnot Matter',
    'Self',
    'Son',
    'Daughter',
    'Brother',
    'Sister',
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
              'Select Profile Preference:',
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
                          Text(profileby[index],
                              style: MmmTextStyles.bodyMediumSmall(
                                  textColor: index ==
                                          this.widget.selectedProfilePreference
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
                    value: index == this.widget.selectedProfilePreference
                        ? true
                        : false,
                  );
                },
                itemCount: profileby.length,
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
