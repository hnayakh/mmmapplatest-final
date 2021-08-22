import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:makemymarry/bloc/about/about_bloc.dart';
import 'package:makemymarry/bloc/about/about_event.dart';
import 'package:makemymarry/bloc/about/about_state.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_field.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/profilescreens/about/height_status_bottom_sheet.dart';
import 'package:makemymarry/views/profilescreens/about/marital_status_bottom_sheet.dart';

import '../habbit/habits.dart';
import 'no_of_childeren_bottom_sheet.dart';

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
  String dobHintText = 'dd MMM yyyy';
  NoOfChildren? noOfChildren;
  int? heightStatus;
  final dateFormat = DateFormat('dd MMM yyyy');
  late UserDetails userDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: MmmButtons.appBarCurved('About'),

      //preferredSize: Size(MediaQuery.of(context).size.width, 0.0),
      // floatingActionButton: FloatingActionButton(
      //   child: MmmIcons.rightArrowDisabled(),
      //   onPressed: () {
      //     BlocProvider.of<AboutBloc>(context).add(OnAboutDone(
      //       namecontroller.text.trim(),
      //     ));
      //   },
      //   backgroundColor: gray5,
      // ),
      body: BlocConsumer<AboutBloc, AboutState>(
        listener: (context, state) {
          if (state is OnError) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: kError,
            ));
          }
          if (state is OnNavigationToHabits) {
            navigateToHabits();
          }
        },
        builder: (context, state) {
          initData();
          return Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  child: buildForm(),
                ),
              ),
              Positioned(
                  bottom: 24,
                  right: 24,
                  child: InkWell(
                    onTap: (){
                      BlocProvider.of<AboutBloc>(context).add(OnAboutDone(
                                namecontroller.text.trim(),
                      ));
                    },
                    child: MmmIcons.rightArrowDisabled(),
                  )),
              state is OnLoading ? MmmWidgets.buildLoader(context) : Container()
            ],
          );
        },
      ),
    );
  }

  Widget buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MmmButtons.appBarCurved('About'),
        Container(
          padding: kMargin16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 8,
              ),
              MmmTextFileds.textFiledWithLabelStar(
                  userDetails.relationship == Relationship.Self
                      ? "Name"
                      : 'Name of ${describeEnum(userDetails.relationship)}',
                  userDetails.relationship == Relationship.Self
                      ? "Enter Name"
                      : 'Enter Name of ${describeEnum(userDetails.relationship)}',
                  namecontroller,textCapitalization: TextCapitalization.words),
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
              MmmButtons.categoryButtons('Marital Status',
                  maritalStatusHintText, 'images/rightArrow.svg', action: () {
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
                          value: ChildrenStatus.YesLivingTogether,
                          groupValue: childrenStatus,
                          onChanged: (val) {
                            BlocProvider.of<AboutBloc>(context).add(
                                OnChildrenSelected(
                                    ChildrenStatus.YesLivingTogether));
                          }),
                    ),
                    Text(
                      'Yes Living Together',
                      style: MmmTextStyles.bodySmall(textColor: kDark5),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Transform.scale(
                      scale: 1.2,
                      child: Radio(
                          activeColor: kPrimary,
                          value: ChildrenStatus.YesNotLivingTogether,
                          groupValue: childrenStatus,
                          onChanged: (val) {
                            BlocProvider.of<AboutBloc>(context).add(
                                OnChildrenSelected(
                                    ChildrenStatus.YesNotLivingTogether));
                          }),
                    ),
                    Text(
                      'Yes Not Living Together',
                      style: MmmTextStyles.bodySmall(textColor: kDark5),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
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
                    Text(
                      'No',
                      style: MmmTextStyles.bodySmall(textColor: kDark5),
                    ),
                  ],
                ),
              ),
              this.childrenStatus == ChildrenStatus.YesNotLivingTogether ||
                      this.childrenStatus == ChildrenStatus.YesLivingTogether
                  ? Column(
                      children: [
                        SizedBox(
                          height: 24,
                        ),
                        MmmButtons.categoryButtons(
                            "No of children",
                            this.noOfChildren != null
                                ? '${describeEnum(this.noOfChildren!)}'
                                : '',
                            'images/rightArrow.svg', action: () {
                          showChildrenBottomSheet(context);
                        })
                      ],
                    )
                  : Container(),
              SizedBox(
                height: 24,
              ),
              MmmButtons.categoryButtons(
                  "Height",
                  this.heightStatus != null
                      ? '${AppHelper.getHeights()[heightStatus!].toStringAsFixed(1)} ft'
                      : '',
                  'images/rightArrow.svg', action: () {
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
                                    OnDisabilitySelected(AbilityStatus.Normal));
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
                                    OnDisabilitySelected(
                                        AbilityStatus.PhysicallyChallenged));
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
        )
      ],
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

    if (result != null && result is int) {
      BlocProvider.of<AboutBloc>(context).add(OnHeightStatusSelected(result));
    }
  }

  void navigateToHabits() {
    var userRepo = BlocProvider.of<AboutBloc>(context).userRepository;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Habit(
              userRepository: userRepo,
            )));
  }

  void initData() {
    this.userDetails =
        BlocProvider.of<AboutBloc>(context).userRepository.useDetails!;
    this.maritalStatus = BlocProvider.of<AboutBloc>(context).maritalStatus;
    this.heightStatus = BlocProvider.of<AboutBloc>(context).heightStatus;
    this.childrenStatus = BlocProvider.of<AboutBloc>(context).childrenStatus;
    this.abilityStatus = BlocProvider.of<AboutBloc>(context).abilityStatus;
    this.noOfChildren = BlocProvider.of<AboutBloc>(context).noOfChildren;
    this.dobHintText = BlocProvider.of<AboutBloc>(context).dob != null
        ? BlocProvider.of<AboutBloc>(context).dob!
        : '';
  }

  void showChildrenBottomSheet(context) async {
    var result = await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => NoOfChildrenBottomSheet(
              noOfChildren: noOfChildren,
            ));

    if (result != null && result is NoOfChildren) {
      BlocProvider.of<AboutBloc>(context).add(OnChangeNoOfChildren(result));
    }
  }
}
