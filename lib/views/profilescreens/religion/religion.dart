import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/text_styles.dart';

import 'package:makemymarry/views/profilescreens/religion/religion_bloc.dart';
import 'package:makemymarry/views/profilescreens/religion/religion_bottom_sheet.dart';
import 'package:makemymarry/views/profilescreens/religion/religion_event.dart';

import 'cast_bottom_sheet.dart';
import 'religion_state.dart';

class Religion extends StatelessWidget {
  final UserRepository userRepository;

  const Religion({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReligionBloc(userRepository),
      child: ReligionScreen(),
    );
  }
}

class ReligionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ReligionScreenState();
  }
}

class ReligionScreenState extends State<ReligionScreen> {
  String religiontext = 'Select your religion';

  String casttext = 'Select your cast';

  String subcasttext = 'Select your sub cast';

  String mothertonguetext = 'Select your mother tongue';

  String gothratext = 'Select your gothra';

  SimpleMasterData? religion;
  SimpleMasterData? subCaste;
  CastSubCast? cast;
  SimpleMasterData? motherTongue;
  dynamic gothra;
  int? isManglik;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('Religion'),
      floatingActionButton: FloatingActionButton(
        child: MmmIcons.rightArrowDisabled(),
        onPressed: () {
          navigateToCarrer();
        },
        backgroundColor: gray5,
      ),
      body: BlocConsumer<ReligionBloc, ReligionState>(
        builder: (context, state) {
          initData();
          return Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: kMargin16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 24,
                      ),
                      MmmButtons.categoryButtons(
                          'Religion',
                          religion != null
                              ? '${religion!.title}'
                              : 'Select your religion',
                          'images/rightArrow.svg', action: () {
                        selectReligion(context);
                      }),
                      SizedBox(
                        height: 24,
                      ),
                      MmmButtons.categoryButtons(
                          'Caste',
                          cast != null ? '${cast!.cast}' : 'Select your caste',
                          'images/rightArrow.svg', action: () {
                        selectCast(context);
                      }),
                      SizedBox(
                        height: 24,
                      ),
                      MmmButtons.categoryButton('Sub-Caste',
                          'Select your sub-caste', 'images/rightArrow.svg'),
                      SizedBox(
                        height: 24,
                      ),
                      MmmButtons.categoryButton('Mother Tongue',
                          'Select your mother tongue', 'images/rightArrow.svg'),
                      SizedBox(
                        height: 24,
                      ),
                      MmmButtons.categoryButton('Gothra', 'Select your gothra',
                          'images/rightArrow.svg'),
                      SizedBox(
                        height: 24,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 8),
                            child: Text(
                              'Manglik',
                              style:
                                  MmmTextStyles.bodyRegular(textColor: kDark5),
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Transform.scale(
                                  scale: 1.2,
                                  child: Radio(
                                      activeColor: Colors.pinkAccent,
                                      value: 1,
                                      groupValue: isManglik,
                                      onChanged: (val) {}),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Yes',
                                  style: MmmTextStyles.bodySmall(
                                      textColor: kDark5),
                                ),
                                SizedBox(
                                  width: 22,
                                ),
                                Transform.scale(
                                  scale: 1.2,
                                  child: Radio(
                                      activeColor: Colors.pinkAccent,
                                      value: 0,
                                      groupValue: isManglik,
                                      onChanged: (val) {}),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'No',
                                  style: MmmTextStyles.bodySmall(
                                      textColor: kDark5),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              state is OnReligionLoading
                  ? Center(
                      child: Image.asset(
                        "images/app_loader2.gif",
                        width: 96,
                        height: 96,
                      ),
                    )
                  : Container()
            ],
          );
        },
        listener: (context, state) {},
      ),
    );
  }

  void navigateToCarrer() {
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => Occupation()));
  }

  void initData() {
    this.isManglik = BlocProvider.of<ReligionBloc>(context).isManglik ? 1 : 0;
    this.gothra = BlocProvider.of<ReligionBloc>(context).gothra;
    this.motherTongue = BlocProvider.of<ReligionBloc>(context).motherTongue;
    this.cast = BlocProvider.of<ReligionBloc>(context).cast;
    this.subCaste = BlocProvider.of<ReligionBloc>(context).subCaste;
    this.religion = BlocProvider.of<ReligionBloc>(context).religion;
  }

  void selectReligion(BuildContext context) async {
    var list = BlocProvider.of<ReligionBloc>(context)
        .userRepository
        .masterData
        .listReligion;
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => ReligionBottomSheet(list: list));
    if (result != null && result is SimpleMasterData) {
      BlocProvider.of<ReligionBloc>(context).add(OnReligionSelected(result));
    }
  }

  void selectCast(BuildContext context) async {
    var list = BlocProvider.of<ReligionBloc>(context)
        .userRepository
        .masterData
        .listCastSubCast;
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => CastBottomSheet(
              list: list,
              selected: cast,
            ));
    if (result != null && result is CastSubCast) {
      BlocProvider.of<ReligionBloc>(context).add(OnCastSelected(result));
    }
  }
}
