import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';

class IdproofBottomSheet extends StatefulWidget {
  final IdProofType? selectedIdProof;
  const IdproofBottomSheet({Key? key, required this.selectedIdProof})
      : super(key: key);
  @override
  _IdproofBottomSheetState createState() => _IdproofBottomSheetState();
}

class _IdproofBottomSheetState extends State<IdproofBottomSheet> {
  List<String> ids = [
    'Passport',
    'Voter Id Card',
    'Aadhaar Card',
    'Driving Licence',
    'Pan Card'
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
              'Select Id Proof:',
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
                              ids[index]
                              //describeEnum(IdProofType.values[index])
                              ,
                              style: MmmTextStyles.bodyMediumSmall(
                                  textColor: IdProofType.values[index] ==
                                          widget.selectedIdProof
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
                      Navigator.of(context).pop(IdProofType.values[index]);
                    },
                  );
                },
                itemCount: IdProofType.values.length,
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
