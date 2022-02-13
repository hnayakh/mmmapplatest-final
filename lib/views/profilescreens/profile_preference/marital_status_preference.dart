import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';

class MaritalStatusPreference extends StatefulWidget {
  final List<MaritalStatus> list;

  const MaritalStatusPreference({Key? key, required this.list})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MaritalStatusPreferenceState(list);
  }
}

class MaritalStatusPreferenceState extends State<MaritalStatusPreference> {
  List<MaritalStatus> list;

  MaritalStatusPreferenceState(this.list);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: kMargin16,
        height: MediaQuery.of(context).size.height * 0.9,
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
                  return ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.only(top: 8),
                    title: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                      describeEnum(MaritalStatus.values[index]),
                                      style: MmmTextStyles.bodyMediumSmall(
                                          textColor: isSelected(
                                                  MaritalStatus.values[index])
                                              ? kPrimary
                                              : kModalPrimary))),
                              isSelected(MaritalStatus.values[index])
                                  ? Icon(
                                      Icons.check,
                                      color: kPrimary,
                                    )
                                  : Container(
                                      height: 24,
                                    )
                            ],
                          ),
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
                      setState(() {
                        setSelected(MaritalStatus.values[index]);
                      });
                      // Navigator.of(context).pop(MaritalStatus.values[index]);
                    },
                  );
                },
                itemCount: MaritalStatus.values.length,
                // separatorBuilder: (context, index) {
                //   return Divider(
                //     color: kLight4,
                //   );
                // },
              ),
            ),
            MmmButtons.primaryButton("Done", () {
              Navigator.of(context).pop(this.list);
            })
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ));
  }

  bool isSelected(MaritalStatus value) {
    for (var item in list) {
      if (item == value) {
        return true;
      }
    }
    return false;
  }

  void setSelected(MaritalStatus value) {
    bool isFound = false;
    int index = 0;
    for (var item in list) {
      if (item == value) {
        isFound = true;
        index = list.indexOf(item);
      }
    }
    if (!isFound) {
      this.list.add(value);
    } else {
      this.list.removeAt(index);
    }
  }
}
