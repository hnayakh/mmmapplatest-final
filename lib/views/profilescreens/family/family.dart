import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/profilescreens/habbit/habits.dart';

import 'family_background/bloc/family_background_bloc.dart';
import 'family_background/views/family_background.dart';
import 'family_details/bloc/family_details_bloc.dart';
import 'family_details/views/family_details.dart';
import 'globals.dart' as globals;

class FamilyScreen extends StatefulWidget {
  final UserRepository userRepository;
  final bool toUpdate;
  final CountryModel? countryModel;
  final StateModel? stateModel;
  final StateModel? city;

  FamilyScreen(
      {Key? key,
      required this.userRepository,
      this.toUpdate = false,
      this.countryModel,
      this.stateModel,
      this.city})
      : super(key: key);

  @override
  _FamilyScreenState createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => FamilyBackgroundBloc(
                widget.userRepository,
                widget.countryModel,
                widget.stateModel,
                widget.city,
              ),
            ),
            BlocProvider(
              create: (context) => FamilyDetailsBloc(
                widget.userRepository,
              ),
            )
          ],
          child: Column(
            children: [
              Container(
                child: PreferredSize(
                  preferredSize: Size.fromHeight(120.0),
                  child: Container(
                    child: AppBar(
                      leading: Navigator.of(context).canPop()
                          ? Container(
                              margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                              decoration: BoxDecoration(
                                color: kLight2.withOpacity(0.60),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                boxShadow: [
                                  MmmShadow.elevationbBackButton(
                                      shadowColor: kShadowColorForWhite)
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                        height: 32,
                                        width: 32,
                                        alignment: Alignment.center,
                                        child: SvgPicture.asset(
                                          'images/arrowLeft.svg',
                                          height: 17.45,
                                          width: 17.45,
                                          color: gray3,
                                        )),
                                  ),
                                ),
                              ),
                            )
                          : null,
                      toolbarHeight: 74.0,
                      title: Text(
                        "Family",
                        style: MmmTextStyles.heading4(textColor: kLight2),
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      actions: !widget.toUpdate ? [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) =>
                                        Habit(userRepository: widget.userRepository),
                                  ),
                                );
                              },
                              // child: MmmIcons.rightArrowEnabled(),
                              child: Text('Skip >',
                                  style:
                                  TextStyle( fontFamily: 'MakeMyMarry', color: Colors.white, fontSize: 16)),
                            ),
                            SizedBox(width: 16,)
                          ],
                        ),
                      ] : [],
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.only(bottomRight: Radius.circular(32)),
                  gradient: LinearGradient(
                      colors: [kPrimary, kSecondary],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight),
                ),
              ),
              TabBar(
                controller: tabController,
                onTap: (pos) {
                  setState(() {});
                },
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 4.0,
                      color: kPrimary,
                    ),
                    insets: EdgeInsets.symmetric(horizontal: 16.0)),
                automaticIndicatorColorAdjustment: true,
                labelColor: kPrimary,
                labelStyle: MmmTextStyles.heading6(),
                unselectedLabelColor: kDark5,
                unselectedLabelStyle: MmmTextStyles.heading6(),
                tabs: [
                  Tab(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Family Background',
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Family Details',
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    FamilyBackground(
                      userRepository: widget.userRepository,
                      onComplete: onComplete,
                      countryModel: widget.countryModel,
                      stateModel: widget.stateModel,
                      city: widget.city,
                      toUpdate: widget.toUpdate,
                    ),
                    FamilyDetails(
                      userRepository: widget.userRepository,
                      onComplete: onComplete,
                      toUpdate: widget.toUpdate,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onComplete() async {
    if (this.tabController.index == 0) {
      setState(() {
        globals.familyBackgroundComplete = true;
        this.tabController.index = 1;
      });
    } else if (this.tabController.index == 1) {
      setState(
        () {
          globals.familyDetailsComplete = true;
          this.tabController.index = 0;
        },
      );
    }
    if (globals.familyDetailsComplete && globals.familyBackgroundComplete) {
      globals.familyDetailsComplete = false;
      globals.familyBackgroundComplete = false;
      if (widget.toUpdate) {
        Navigator.of(context).pop();
      } else {
        await widget.userRepository
            .updateRegistartionStep(widget.userRepository.useDetails!.id, 7);
        widget.userRepository.updateRegistrationStep(7);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Habit(
              userRepository: widget.userRepository,
            ),
          ),
        );
      }
    }
  }
}
