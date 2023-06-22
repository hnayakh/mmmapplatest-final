import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_field.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/profilescreens/about/bloc/about_bloc.dart';
import 'package:makemymarry/views/profilescreens/about/bloc/about_event.dart';
import 'package:makemymarry/views/profilescreens/about/views/marital_status_bottom_sheet.dart';

import '../../religion/views/religion.dart';
import '../bloc/about_state.dart';
import 'height_status_bottom_sheet.dart';
import 'no_of_childeren_bottom_sheet.dart';

class About extends StatelessWidget {
  final UserRepository userRepository;
  final bool toUpdate;

  const About({Key? key, required this.userRepository, this.toUpdate = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AboutBloc(userRepository),
      child: AboutScreen(
        toUpdate: toUpdate,
      ),
    );
  }
}

class AboutScreen extends StatefulWidget {
  final bool toUpdate;
  AboutScreen({Key? key, required this.toUpdate}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  late UserDetails userDetails;
  late String name;

  @override
  Widget build(BuildContext context) {
    this.userDetails =
        BlocProvider.of<AboutBloc>(context).userRepository.useDetails!;

    if (this.userDetails.registrationStep > 2) {
      BlocProvider.of<AboutBloc>(context).editNameController.text =
          userDetails.name;
      BlocProvider.of<AboutBloc>(context).add(OnAboutDataLoad(userDetails.id));
    }

    return Scaffold(
      appBar: MmmButtons.appBarCurved('Basic Details', context: widget.toUpdate ? context : null),
      body: BlocConsumer<AboutBloc, AboutState>(
        listener: (context, state) {
          if (state is OnError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: kError,
            ));
          }
          if (state is OnNavigationToHabits) {
            navigateToReligion();
          }
          if (state is OnNavigationToMyProfiles) {
            navigateToMyProfile();
          }
        },
        builder: (context, state) {
          if (state is OnLoading) {
            return MmmWidgets.buildLoader(context);
          } else if (state is AboutIdleState) {
            return Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      child: buildForm(state),
                    ),
                  ),
                  Positioned(
                    bottom: 24,
                    right: 24,
                    child: widget.toUpdate
                        ? InkWell(
                            onTap: () {
                              BlocProvider.of<AboutBloc>(context)
                                  .add(OnAboutDone(widget.toUpdate));
                            },
                            child: MmmIcons.saveIcon(),
                          )
                        : InkWell(
                            onTap: () {
                              BlocProvider.of<AboutBloc>(context)
                                  .add(OnAboutDone(widget.toUpdate));
                            },
                            child: MmmIcons.rightArrowEnabled(),
                          ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buildForm(AboutIdleState state) {
    var hintText = state.heightStatus != null
        ? AppHelper.getHeight((state.heightStatus ?? 48) - 48)
        : 'Select your height';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

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
                  BlocProvider.of<AboutBloc>(context).editNameController.text !=
                          ""
                      ? BlocProvider.of<AboutBloc>(context).editNameController
                      : BlocProvider.of<AboutBloc>(context).nameController,
                  onTextChange: (value) {
                BlocProvider.of<AboutBloc>(context).add(OnNameChanged(value));
              }, textCapitalization: TextCapitalization.words, maxLength: 50),
              SizedBox(
                height: 24,
              ),
              MmmButtons.categoryButtons(
                  'Date of Birth',
                  state.dateOfBirth != null
                      ? AppHelper.getReadableDob(
                          AppHelper.serverFormatDate(state.dateOfBirth!))
                      : 'dd MMM yyyy',
                  'dd MMM yyyy',
                  'images/Calendar.svg', action: () {
                FocusManager.instance.primaryFocus?.unfocus();
                showDate(context);
              }),
              SizedBox(
                height: 24,
              ),
              MmmButtons.categoryButtons(
                  'Marital Status',
                  state.maritalStatus != null
                      ? AppHelper.getStringFromEnum(state.maritalStatus)
                      : 'Select your marital status',
                  'Select your marital status',
                  'images/rightArrow.svg', action: () {
                FocusManager.instance.primaryFocus?.unfocus();
                showMaritalStatusBottomSheet(state.maritalStatus);
              }),
              state.maritalStatus != MaritalStatus.NeverMarried
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                          margin: EdgeInsets.fromLTRB(1, 5, 0, 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Transform.scale(
                                scale: 1.2,
                                child: Radio(
                                    activeColor: kPrimary,
                                    value: ChildrenStatus.YesLivingTogether,
                                    groupValue: state.childrenStatus,
                                    onChanged: (val) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      BlocProvider.of<AboutBloc>(context).add(
                                          OnChildrenSelected(ChildrenStatus
                                              .YesLivingTogether));
                                    }),
                              ),
                              Text('Yes Living Together',
                                  style:
                                      TextStyle( fontFamily: 'MakeMyMarry', fontSize: 14, color: kDark5)),
                              Transform.scale(
                                scale: 1.2,
                                child: Radio(
                                    activeColor: kPrimary,
                                    value: ChildrenStatus.YesNotLivingTogether,
                                    groupValue: state.childrenStatus,
                                    onChanged: (val) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      BlocProvider.of<AboutBloc>(context).add(
                                          OnChildrenSelected(ChildrenStatus
                                              .YesNotLivingTogether));
                                    }),
                              ),
                              SizedBox(width: 1),
                              Text('Yes Not Living\nTogether',
                                  style:
                                      TextStyle( fontFamily: 'MakeMyMarry', fontSize: 14, color: kDark5)),
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
                                    groupValue: state.childrenStatus,
                                    onChanged: (val) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      BlocProvider.of<AboutBloc>(context).add(
                                          OnChildrenSelected(
                                              ChildrenStatus.No));
                                    }),
                              ),
                              Text(
                                'No',
                                style:
                                    MmmTextStyles.bodySmall(textColor: kDark5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container(),
              //  this.maritalStatus != MaritalStatus.NeverMarried
              state.maritalStatus != MaritalStatus.NeverMarried &&
                      state.childrenStatus != ChildrenStatus.No
                  ? Column(
                      children: [
                        SizedBox(
                          height: 24,
                        ),
                        MmmButtons.categoryButtons(
                            "No of children",
                            state.noOfChildren != null
                                ? //'${describeEnum(this.noOfChildren!)}'
                                AppHelper.getStringFromEnum(state.noOfChildren)
                                : 'Select number of children',
                            'Select number of children',
                            'images/rightArrow.svg', action: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          showChildrenBottomSheet(state.noOfChildren);
                        })
                      ],
                    )
                  : Container(),
              SizedBox(
                height: 24,
              ),
              MmmButtons.categoryButtons("Height", hintText,
                  'Select your height', 'images/rightArrow.svg', action: () {
                FocusManager.instance.primaryFocus?.unfocus();
                showHeightStatusBottomSheet(state.heightStatus);
              }),
              SizedBox(
                height: 24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Disability',
                    style: MmmTextStyles.bodyRegular(textColor: kDark5),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Transform.scale(
                          scale: 1.1,
                          child: Radio(
                              activeColor: kPrimary,
                              value: AbilityStatus.Normal,
                              groupValue: state.abilityStatus,
                              onChanged: (val) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                BlocProvider.of<AboutBloc>(context).add(
                                    OnDisabilitySelected(AbilityStatus.Normal));
                              }),
                        ),
                        //SizedBox(
                        // width: 8,
                        //  ),
                        Text('Normal',
                            style: TextStyle( fontFamily: 'MakeMyMarry', fontSize: 15, color: kDark5)),

                        Transform.scale(
                          scale: 1.1,
                          child: Radio(
                              activeColor: kPrimary,
                              value: AbilityStatus.PhysicallyChallenged,
                              groupValue: state.abilityStatus,
                              onChanged: (val) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                BlocProvider.of<AboutBloc>(context).add(
                                    OnDisabilitySelected(
                                        AbilityStatus.PhysicallyChallenged));
                              }),
                        ),
                        Text('Physically Challenged',
                            style: TextStyle( fontFamily: 'MakeMyMarry', fontSize: 15, color: kDark5)),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                              // width: 22,
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 76,
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Future showDate(BuildContext context) async {
    DateTime currentTime = DateTime.now();
    var lastDate = this.userDetails.gender == Gender.Male.index
        ? DateTime(currentTime.year - 21, currentTime.month, currentTime.day)
        : DateTime(currentTime.year - 18, currentTime.month, currentTime.day);
    var newDate = await showDatePicker(
      context: context,
      initialDate: lastDate,
      firstDate: DateTime(1970),
      lastDate: lastDate,
    );
    if (newDate != null) {
      BlocProvider.of<AboutBloc>(context).add(OnDOBSelected(newDate));
    }
  }

  void showMaritalStatusBottomSheet(MaritalStatus? status) async {
    var result = await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => MaritalStatusBottomSheet(
        selectedMaritalStatus: status,
      ),
    );

    if (result != null && result is MaritalStatus) {
      BlocProvider.of<AboutBloc>(context).add(OnMaritalStatusSelected(result));
    }
  }

  void showHeightStatusBottomSheet(int? heightStatus) async {
    var result = await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => HeightStatusBottomSheet(
              selectedHeightStatus: (heightStatus ?? 48) - 48,
            ));

    if (result != null && result is int) {
      BlocProvider.of<AboutBloc>(context)
          .add(OnHeightStatusSelected(result + 48));
    }
  }

  void navigateToReligion() {
    var userRepo = BlocProvider.of<AboutBloc>(context).userRepository;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Religion(
          userRepository: userRepo,
        ),
      ),
    );
  }

  void navigateToMyProfile() {
    Navigator.of(context).pop();
  }

  void showChildrenBottomSheet(NoOfChildren? noOfChildren) async {
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
