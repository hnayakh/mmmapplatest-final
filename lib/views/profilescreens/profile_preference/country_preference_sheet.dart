import 'package:flutter/material.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';

class SelectCountryPreferenceSheet extends StatefulWidget {
  final List<CountryModel> list;
  final CountryModel? countryModel;

  const SelectCountryPreferenceSheet(
      {Key? key, required this.list, this.countryModel})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SelectCountryPreferenceSheetState();
  }
}

class SelectCountryPreferenceSheetState
    extends State<SelectCountryPreferenceSheet> {
  List<CountryModel> filtered = [];

  @override
  void initState() {
    this.filtered = List.of(widget.list, growable: true);
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
              'Select Country:',
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
                      .where((element) => element.name
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
                  hintText: "Search Country",
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
                          Text(filtered[index].name,
                              style: MmmTextStyles.bodyMediumSmall(
                                  textColor: isSelected(filtered[index])
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
                      Navigator.of(context).pop(filtered[index]);
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
            )
          ],
        ),
        padding: kMargin16,
        height: MediaQuery.of(context).size.height - 74,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ));
  }

  bool isSelected(CountryModel? value) {
    if (widget.countryModel!.name == value!.name) {
      return true;
    }

    return false;
  }
}
