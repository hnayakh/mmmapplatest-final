import 'package:flutter/material.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';

class EducationPreferenceSheet extends StatefulWidget {
  final List<Education> list;
  final List<Education?> eduModel;
  const EducationPreferenceSheet(
      {Key? key, required this.list, required this.eduModel})
      : super(key: key);

  @override
  _EducationPreferenceSheetState createState() =>
      _EducationPreferenceSheetState();
}

class _EducationPreferenceSheetState extends State<EducationPreferenceSheet> {
  List<Education> filtered = [];

  @override
  void initState() {
    super.initState();

    this.filtered = List.of(widget.list, growable: true);
  }

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
              'Select education:',
              style: MmmTextStyles.bodyMedium(textColor: kDark5),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              style: MmmTextStyles.bodyRegular(textColor: kDark5),
              cursorColor: kDark5,
              onChanged: (value) {
                setState(() {
                  this.filtered = widget.list
                      .where((element) => element.title
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: kDark2, width: 1),
                      borderRadius: BorderRadius.circular(8)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: kInputBorder, width: 1)),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  hintText: "Search religion",
                  isDense: true,
                  filled: true,
                  fillColor: kLight4,
                  hintStyle: MmmTextStyles.bodyRegular(textColor: kDark2)),
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
                          Row(
                            children: [
                              Expanded(
                                child: Text(filtered[index].title,
                                    style: MmmTextStyles.bodyMediumSmall(
                                        textColor: isSelected(filtered[index])
                                            ? kPrimary
                                            : kModalPrimary)),
                              ),
                              isSelected(filtered[index])
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
                      // Navigator.of(context).pop(filtered[index]);
                      setState(() {
                        setSelected(filtered[index]);
                      });
                    },
                  );
                },
                itemCount: filtered.length,
                // separatorBuilder: (context, index) {
                //   return Divider(
                //     color: kLight4,
                //   );
                // },
              ),
            ),
            MmmButtons.primaryButton("Done", () {
              Navigator.of(context).pop(this.widget.eduModel);
            })
          ],
        ),
        padding: kMargin16,
        height: MediaQuery.of(context).size.height - 74,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ));
  }

  bool isSelected(Education? value) {
    for (var item in widget.eduModel) {
      if (item!.title == value!.title) {
        return true;
      }
    }
    return false;
  }

  void setSelected(Education? value) {
    bool isFound = false;
    int index = 0;
    for (var item in widget.eduModel) {
      if (item!.title == value!.title) {
        isFound = true;
        index = widget.eduModel.indexOf(item);
      }
    }
    if (!isFound) {
      this.widget.eduModel.add(value);
    } else {
      this.widget.eduModel.removeAt(index);
    }
  }
}
