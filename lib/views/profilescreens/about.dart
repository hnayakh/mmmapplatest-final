import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:makemymarry/bloc/about/about_bloc.dart';
import 'package:makemymarry/bloc/about/about_event.dart';
import 'package:makemymarry/bloc/about/about_state.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_field.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:makemymarry/views/profilescreens/height_status_bottom_sheet.dart';
import 'package:makemymarry/views/profilescreens/marital_status_bottom_sheet.dart';

import 'habits.dart';

class About extends StatelessWidget {
  final UserRepository userRepository;

  const About({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AboutBloc(userRepository),
      child: AboutScreen(),
    );
  }
}

class AboutScreen extends StatefulWidget {
  AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  TextEditingController namecontroller = TextEditingController();
  ChildrenStatus? childrenStatus;
  AbilityStatus? abilityStatus;

  String maritalStatusHintText = 'Select your maritial status';
  MaritalStatus? maritalStatus;

  String heightStatusHintText = 'Select your height';
  String dobHintText = 'DD/MM/YYYY';

  HeightStatus? heightStatus;
  final dateFormat = DateFormat('yyyy-mm-dd');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('About'),

      //preferredSize: Size(MediaQuery.of(context).size.width, 0.0),
      floatingActionButton: FloatingActionButton(
        child: MmmIcons.rightArrowDisabled(),
        onPressed: () {
          // BlocProvider.of<AboutBloc>(context).add(OnNavigationButtonClicked(
          // namecontroller.text.trim(),
          // ms,
          //  height,
          // childrenStatus,
          // abilityStatus,
          // dob)
          //  );
        },
        backgroundColor: gray5,
      ),
      body: BlocConsumer<AboutBloc, AboutState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          initData();
          return SingleChildScrollView(
            child: Container(
              padding: kMargin16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 24,
                  ),
                  MmmTextFileds.textFiledWithLabelStar(
                      'Name of Son/Daughter/Sister/Brother',
                      "Enter Son's name",
                      namecontroller),
                  SizedBox(
                    height: 24,
                  ),
                  MmmButtons.categoryButtons(
                      'Date of birth', dobHintText, 'images/Calendar.svg',
                      action: () {
                    showDate(context);
                  }),
                  SizedBox(
                    height: 24,
                  ),
                  MmmButtons.categoryButtons(
                      'Marital Status',
                      maritalStatusHintText,
                      'images/rightArrow.svg', action: () {
                    showMaritalStatusBottomSheet();
                  }),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    child: Text(
                      'Children',
                      style: MmmTextStyles.bodyRegular(textColor: kDark5),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: 1.2,
                          child: Radio(
                              activeColor: kPrimary,
                              value: ChildrenStatus.Yes,
                              groupValue: childrenStatus,
                              onChanged: (val) {
                                BlocProvider.of<AboutBloc>(context).add(
                                    OnChildrenSelected(ChildrenStatus.Yes));
                              }),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Yes',
                          style: MmmTextStyles.bodySmall(textColor: kDark5),
                        ),
                        SizedBox(
                          width: 22,
                        ),
                        Transform.scale(
                          scale: 1.2,
                          child: Radio(
                              activeColor: kPrimary,
                              value: ChildrenStatus.No,
                              groupValue: childrenStatus,
                              onChanged: (val) {
                                BlocProvider.of<AboutBloc>(context)
                                    .add(OnChildrenSelected(ChildrenStatus.No));
                              }),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'No',
                          style: MmmTextStyles.bodySmall(textColor: kDark5),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  MmmButtons.categoryButtons(
                      'Height', heightStatusHintText, 'images/rightArrow.svg',
                      action: () {
                    showHeightStatusBottomSheet();
                  }),
                  SizedBox(
                    height: 24,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        child: Text(
                          'Disability',
                          style: MmmTextStyles.bodyRegular(textColor: kDark5),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Transform.scale(
                              scale: 1.2,
                              child: Radio(
                                  activeColor: kPrimary,
                                  value: AbilityStatus.Normal,
                                  groupValue: abilityStatus,
                                  onChanged: (val) {
                                    BlocProvider.of<AboutBloc>(context).add(
                                        OnDisabilitySelected(
                                            AbilityStatus.Normal));
                                  }),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Normal',
                              style: MmmTextStyles.bodySmall(textColor: kDark5),
                            ),
                            SizedBox(
                              width: 22,
                            ),
                            Transform.scale(
                              scale: 1.2,
                              child: Radio(
                                  activeColor: kPrimary,
                                  value: AbilityStatus.PhysicallyChallenged,
                                  groupValue: abilityStatus,
                                  onChanged: (val) {
                                    BlocProvider.of<AboutBloc>(context).add(
                                        OnDisabilitySelected(AbilityStatus
                                            .PhysicallyChallenged));
                                  }),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Physically Challenged',
                              style: MmmTextStyles.bodySmall(textColor: kDark5),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future showDate(BuildContext context) async {
    var newDate = await showDatePicker(
        context: context,
        initialDate: DateTime(2001, 1, 1),
        firstDate: DateTime(1970),
        lastDate: DateTime(2001));
    if (newDate != null) {
      this.dobHintText = dateFormat.format(newDate);
      BlocProvider.of<AboutBloc>(context).add(OnDOBSelected(dobHintText));
    }
  }

  void showMaritalStatusBottomSheet() async {
    var result = await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => MaritalStatusBottomSheet(
              selectedMaritalStatus: maritalStatus,
            ));

    if (result != null && result is MaritalStatus) {
      this.maritalStatusHintText = describeEnum(result);
      BlocProvider.of<AboutBloc>(context).add(OnMaritalStatusSelected(result));
    }
  }

  void showHeightStatusBottomSheet() async {
    var result = await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => HeightStatusBottomSheet(
              selectedHeightStatus: heightStatus,
            ));

    if (result != null && result is HeightStatus) {
      this.heightStatusHintText = describeEnum(result);
      BlocProvider.of<AboutBloc>(context).add(OnHeightStatusSelected(result));
    }
  }

  void navigateToHabits() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HabitScreen()));
  }

  void initData() {
    this.maritalStatus = BlocProvider.of<AboutBloc>(context).maritalStatus;
    this.heightStatus = BlocProvider.of<AboutBloc>(context).heightStatus;
    this.childrenStatus = BlocProvider.of<AboutBloc>(context).childrenStatus;
    this.abilityStatus = BlocProvider.of<AboutBloc>(context).abilityStatus;
    //this.dobHintText = BlocProvider.of<AboutBloc>(context).dob;
  }
}
