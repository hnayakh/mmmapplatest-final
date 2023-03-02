import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';

class SmokingPrefs extends StatefulWidget {
  final List<SmokingHabit> list;

  const SmokingPrefs({Key? key, required this.list}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SmokingPrefsScreen(list);
  }
}

class SmokingPrefsScreen extends State<SmokingPrefs> {
  List<SmokingHabit> list;

  SmokingPrefsScreen(this.list);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: kMargin16,
        height: MediaQuery.of(context).size.height * 0.65,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(describeEnum(SmokingHabit.values[index]),
                                  style: MmmTextStyles.bodyMediumSmall(
                                      textColor:
                                          isSelected(SmokingHabit.values[index])
                                              ? kPrimary
                                              : kModalPrimary)),
                              isSelected(SmokingHabit.values[index])
                                  ? Icon(
                                      Icons.check,
                                      color: kPrimary,
                                    )
                                  : Container(
                                      height: 24,
                                    ),
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
                        setSelected(SmokingHabit.values[index]);
                      });
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

  bool isSelected(SmokingHabit value) {
    for (var item in list) {
      if (item == value) {
        return true;
      }
    }
    return false;
  }

  void setSelected(SmokingHabit value) {
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
