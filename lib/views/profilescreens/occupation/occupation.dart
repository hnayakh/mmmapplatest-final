import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';

import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/text_field.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/profilescreens/family/family.dart';

import 'education_bottom_sheet.dart';
import 'occupation_bloc.dart';
import 'occupation_bottom_sheet.dart';
import 'occupation_event.dart';
import 'occupation_state.dart';

class Occupations extends StatelessWidget {
  final UserRepository userRepository;

  const Occupations({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OccupationBloc(userRepository),
      child: OccupationScreen(),
    );
  }
}

class OccupationScreen extends StatefulWidget {
  OccupationScreen({Key? key}) : super(key: key);

  @override
  _OccupationScreenState createState() => _OccupationScreenState();
}

class _OccupationScreenState extends State<OccupationScreen> {
  var titleRedOcc = '';

  var titleRedEdu = '';

  final TextEditingController orgNameController = TextEditingController();

  final TextEditingController annIncomeController = TextEditingController();

  final TextEditingController countryController = TextEditingController();

  final TextEditingController stateController = TextEditingController();

  final TextEditingController cityController = TextEditingController();

  String? occupation;

  String? education;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('Career'),
      //  floatingActionButton: FloatingActionButton(
      //    child: MmmIcons.rightArrowEnabled(),
      //   onPressed: () {
      //      BlocProvider.of<OccupationBloc>(context).add(UpdateCareer(
      //         orgNameController.text.trim(),
      //         annIncomeController.text.trim(),
      //          countryController.text.trim(),
      //         stateController.text.trim(),
      //         cityController.text.trim()));
      //   },
      //    backgroundColor: gray5,
      //  ),
      body: BlocConsumer<OccupationBloc, OccupationState>(
        listener: (context, state) {
          if (state is MoveToFamily) {
            navigateToFamily(context);
          }
        },
        builder: (context, state) {
          initData(context);
          return Stack(
            children: [
              SingleChildScrollView(
                padding: kMargin16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 24,
                        ),
                        MmmButtons.categoryButtons(
                            'Occupation',
                            occupation != null
                                ? '${occupation!}'
                                : 'Select your occupation',
                            'Select your occupation',
                            'images/rightArrow.svg', action: () {
                          selectOccupation(context);
                        }),
                        SizedBox(
                          height: 24,
                        ),
                        MmmTextFileds.textFiledWithLabelStar('Annual Income',
                            'Enter your annual income', annIncomeController),
                        SizedBox(
                          height: 24,
                        ),
                        MmmTextFileds.textFiledWithLabelStar(
                            'Employeed in',
                            'Enter name of your organisation',
                            orgNameController),
                        SizedBox(
                          height: 24,
                        ),
                        MmmButtons.categoryButtons(
                            'Highest Education',
                            education != null
                                ? '${education!}'
                                : 'Select your highest education',
                            'Select your highest education',
                            'images/rightArrow.svg', action: () {
                          selectEducation(context);
                        }),
                      ],
                    ),
                    SizedBox(
                      height: 48,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Current location of groom’s',
                              style: MmmTextStyles.bodyMedium(
                                  textColor: kModalPrimary),
                            ),
                          ],
                        ),
                        MmmTextFileds.textFiledWithLabelStar('Country',
                            'Select your country', countryController),
                        SizedBox(
                          height: 24,
                        ),
                        MmmTextFileds.textFiledWithLabelStar(
                            'State', 'Select your state', stateController),
                        SizedBox(
                          height: 24,
                        ),
                        MmmTextFileds.textFiledWithLabelStar(
                            'City', 'Select your city', cityController),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 24,
                  right: 24,
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<OccupationBloc>(context).add(UpdateCareer(
                          orgNameController.text.trim(),
                          annIncomeController.text.trim(),
                          countryController.text.trim(),
                          stateController.text.trim(),
                          cityController.text.trim()));
                    },
                    child: MmmIcons.rightArrowDisabled(),
                  )),
              state is OnLoading
                  ? MmmWidgets.buildLoader(context)
                  : Container(),
            ],
          );
        },
      ),
    );
  }

  void initData(BuildContext context) {
    this.education = BlocProvider.of<OccupationBloc>(context).education;
    this.occupation = BlocProvider.of<OccupationBloc>(context).occupation;
  }

  void selectOccupation(BuildContext context) async {
    var list = BlocProvider.of<OccupationBloc>(context)
        .userRepository
        .masterData
        .listOccupation;
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => OccupationBottomSheet(
              list: list,
              titleRed: titleRedOcc,
            ));

    if (result != null && result is SimpleMasterData) {
      BlocProvider.of<OccupationBloc>(context)
          .add(OnOccupationSelected(result.title));
      titleRedOcc = result.title;
    }
  }

  void selectEducation(BuildContext context) async {
    var list = BlocProvider.of<OccupationBloc>(context)
        .userRepository
        .masterData
        .listEducation;
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => EducationBottomSheet(
              list: list,
              titleRed: titleRedEdu,
            ));
    if (result != null && result is Education) {
      BlocProvider.of<OccupationBloc>(context)
          .add(OnEducationSelected(result.title));
      titleRedEdu = result.title;
    }
  }

  void navigateToFamily(BuildContext context) {
    var userRepo = BlocProvider.of<OccupationBloc>(context).userRepository;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FamilyScreen(
              userRepository: userRepo,
            )));
  }
}
