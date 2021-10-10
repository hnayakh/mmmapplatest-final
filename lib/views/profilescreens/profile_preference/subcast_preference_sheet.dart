import 'package:flutter/material.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';

class SubCastPreferenceSheet extends StatefulWidget {
  final List<dynamic> selected;
  final List<CastSubCast> list;
  const SubCastPreferenceSheet(
      {Key? key, required this.selected, required this.list})
      : super(key: key);

  @override
  _SubCastPreferenceSheetState createState() => _SubCastPreferenceSheetState();
}

class _SubCastPreferenceSheetState extends State<SubCastPreferenceSheet> {
  List<CastSubCast> filtered = [];

  @override
  void initState() {
    this.filtered = List.of(widget.list, growable: true);
    //for (int i = 1; i < filtered.length; i++) {
    //   filtered.addAll(filtered[i]);
    //  }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kMargin16,
      height: MediaQuery.of(context).size.height - 74,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
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
            'Select SubCaste}:',
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
                //   this.filtered = filtered
                //        .where((element) => element.name
                //             .toLowerCase()
                //             .contains(value.toLowerCase()))
                //          .toList();
                for (int i = 0; i < filtered.length; i++) {
                  filtered[i].subCasts = filtered[i]
                      .subCasts
                      .where((element) =>
                          element.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                }
                if (value == '') {
                  this.filtered = List.of(widget.list, growable: true);
                }
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
                hintText: "Search SubCaste}",
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
                            Text(widget.list[indexCategory].cast,
                                style: MmmTextStyles.bodyMedium(
                                    textColor:
                                        // widget.selected == filtered[indexCategory]
                                        //    ? kPrimary:
                                        kPrimary)),
                            ListView.builder(
                                itemCount:
                                    filtered[indexCategory].subCasts.length,
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
                                                            .subCasts[
                                                        indexSubcategory],
                                                    style: MmmTextStyles.bodyMediumSmall(
                                                        textColor: isSelected(
                                                                filtered[indexCategory]
                                                                        .subCasts[
                                                                    indexSubcategory])
                                                            ? kPrimary
                                                            : kDark5)),
                                              ),
                                              isSelected(filtered[indexCategory]
                                                          .subCasts[
                                                      indexSubcategory])
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
                                      setState(() {
                                        // Navigator.of(context).pop(
                                        //    filtered[indexCategory]
                                        //        .subCategory[indexSubcategory]);
                                        setState(() {
                                          setSelected(filtered[indexCategory]
                                              .subCasts[indexSubcategory]);
                                        });
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
                  // onTap: () {
                  //   Navigator.of(context).pop(filtered[index]);
                  //  },
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
    );
  }

  bool isSelected(dynamic value) {
    for (var item in widget.selected) {
      if (item == value) {
        return true;
      }
    }
    return false;
  }

  void setSelected(dynamic value) {
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
