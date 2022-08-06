import 'package:flutter/material.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';

class OccupationPreferenceSheet extends StatefulWidget {
  final List<String?> selected;
  final List<Occupation> list;
  const OccupationPreferenceSheet(
      {Key? key, required this.selected, required this.list})
      : super(key: key);

  @override
  _OccupationPreferenceSheetState createState() =>
      _OccupationPreferenceSheetState();
}

class _OccupationPreferenceSheetState extends State<OccupationPreferenceSheet> {
  List<Occupation> filtered = [];

  //String titleRednew = '';

  @override
  void initState() {
    filtered = widget.list;
    super.initState();
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
              'Select Occupation:',
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
                  this.filtered = widget.list.where((element) {
                    return element.category
                        .toLowerCase()
                        .contains(value.toLowerCase());
                  }).toList();
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
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  hintText: "Search Occupation",
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
                itemBuilder: (context, indexCategory) {
                  return ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.only(top: 8),
                    title: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            children: [
                              Text(filtered[indexCategory].category,
                                  style: MmmTextStyles.bodyMedium(
                                      textColor:
                                          // widget.selected == filtered[indexCategory]
                                          //    ? kPrimary:
                                          kPrimary)),
                              ListView.builder(
                                  itemCount: filtered[indexCategory]
                                      .subCategory
                                      .length,
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemBuilder: (context, indexSubcategory) {
                                    return ListTile(
                                      title: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      filtered[indexCategory]
                                                          .subCategory[
                                                              indexSubcategory]
                                                          .title,
                                                      style: MmmTextStyles.bodyMediumSmall(
                                                          textColor: isSelected(filtered[
                                                                      indexCategory]
                                                                  .subCategory[
                                                                      indexSubcategory]
                                                                  .title)
                                                              ? kPrimary
                                                              : kDark5)),
                                                ),
                                                isSelected(filtered[
                                                            indexCategory]
                                                        .subCategory[
                                                            indexSubcategory]
                                                        .title)
                                                    ? Icon(
                                                        Icons.check,
                                                        color: kPrimary,
                                                      )
                                                    : Container(
                                                        height: 24,
                                                      )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        //  setState(() {
                                        //    Navigator.of(context).pop(filtered[
                                        //            indexCategory]
                                        //        .subCategory[indexSubcategory]);
                                        //  });
                                        setState(() {
                                          setSelected(filtered[indexCategory]
                                              .subCategory[indexSubcategory]
                                              .title);
                                        });
                                      },
                                    );
                                  })
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
              Navigator.of(context).pop(this.widget.selected);
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

  bool isSelected(String? value) {
    for (var item in widget.selected) {
      if (item == value) {
        return true;
      }
    }
    return false;
  }

  void setSelected(String? value) {
    bool isFound = false;
    int index = 0;
    for (var item in widget.selected) {
      if (item == value) {
        isFound = true;
        index = widget.selected.indexOf(item);
      }
    }
    if (!isFound) {
      this.widget.selected.add(value);
    } else {
      this.widget.selected.removeAt(index);
    }
  }
}
