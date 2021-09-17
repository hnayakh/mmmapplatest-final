import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/datamodels/profile_data.dart';
import 'package:makemymarry/repo/user_repo.dart';

import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/text_styles.dart';

import 'package:makemymarry/utils/widgets_large.dart';

import 'package:makemymarry/views/stackviewscreens/stackview/stack_view_bloc.dart';
import 'package:makemymarry/views/stackviewscreens/stackview/stack_view_event.dart';
import 'package:makemymarry/views/stackviewscreens/stackview/stack_view_state.dart';

import '../grid_view_stack.dart';

class StackView extends StatelessWidget {
  final UserRepository userRepository;
  final List<int> likeInfoList;
  const StackView(
      {Key? key, required this.userRepository, required this.likeInfoList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StackViewBloc(userRepository, likeInfoList),
      child: StackViewScreen(),
    );
  }
}

class StackViewScreen extends StatefulWidget {
  const StackViewScreen({Key? key}) : super(key: key);

  @override
  _StackViewScreenState createState() => _StackViewScreenState();
}

class _StackViewScreenState extends State<StackViewScreen> {
  var index = 5;
  late var dob;
  late var profileIndex;
  bool firstTime = true;
  late List<int> likeInfoList;

  late List<ProfileDetails> profiledetails;

  late StateCityResponse states;

  late StateCityResponse city;

  late StateModel userState;

  late StateModel userCity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<StackViewBloc, StackViewState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          initData();
          return GestureDetector(
            onTap: () {
              //navigate to profileview screen
            },
            onVerticalDragEnd: (DragEndDetails details) {
              if (details.primaryVelocity! > 0) {
                // User swiped down
                BlocProvider.of<StackViewBloc>(context).add(SwipeDownEvent());
              } else if (details.primaryVelocity! < 0) {
                // User swiped up
                BlocProvider.of<StackViewBloc>(context).add(SwipeUpEvent());
              }
            },
            child: Container(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.amber,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: (Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(boxShadow: [
                              MmmShadow.elevationStack(),
                            ]),
                            padding: EdgeInsets.only(top: 8, bottom: 8),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  MmmWidgets.bottomBarUnits('images/Search.svg',
                                      'Search', index == 0 ? kPrimary : gray3,
                                      action: () {
                                    setColor(0);
                                  }),
                                  MmmWidgets.bottomBarUnits(
                                      'images/filter2.svg',
                                      'Filter',
                                      index == 1 ? kPrimary : gray3,
                                      action: () {
                                    setColor(1);
                                  }),
                                  MmmWidgets.bottomBarUnits(
                                      'images/connect.svg',
                                      'Connect',
                                      index == 2 ? kPrimary : gray3,
                                      action: () {
                                    setColor(2);
                                  }),
                                  MmmWidgets.bottomBarUnits(
                                      'images/Search.svg',
                                      'Notifications',
                                      index == 3 ? kPrimary : gray3,
                                      action: () {
                                    setColor(3);
                                  }),
                                  MmmWidgets.bottomBarUnits('images/menu.svg',
                                      'More', index == 4 ? kPrimary : gray3,
                                      action: () {
                                    setColor(4);
                                  })
                                ]),
                          ))),
                        ],
                      )
                    ],
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      alignment: Alignment.center,
                      //height: MediaQuery.of(context).size.height * 0.85,
                      decoration: BoxDecoration(
                        //border: Border.all(color: kBio),
                        borderRadius: BorderRadius.circular(16),
                        //boxShadow: [
                        //   MmmShadow.elevation3(shadowColor: kShadowColorForWhite)
                        // ]
                      ),
                      child: ClipRRect(
                        //borderRadius: BorderRadius.only(
                        //     bottomLeft: Radius.circular(16),
                        //     bottomRight: Radius.circular(16)),
                        child:
                            // Image.network(
                            //    BlocProvider.of<StackViewBloc>(context)
                            //       .userRepository
                            //       .listProfileDetails[profileIndex]
                            //       .imageUrl,
                            //   height: MediaQuery.of(context).size.height * 0.9,
                            //    width: MediaQuery.of(context).size.width,
                            //    fit: BoxFit.cover),
                            Image.asset(
                          'images/stackviewImage.jpg',
                          height: MediaQuery.of(context).size.height * 0.9,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.75),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: BoxDecoration(
                          //border: Border.,
                          color: kBlack.withOpacity(0.5),
                          //borderRadius: BorderRadius.only(
                          //    bottomLeft: Radius.circular(16),
                          //    bottomRight: Radius.circular(16)),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.78,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    //height: 26,
                                    child: Text(
                                      profiledetails[profileIndex].name ==
                                              'data not available'
                                          ? 'Kristen Stewart,24   '
                                          : '${profiledetails[profileIndex].name},${calculateAge()}  ',
                                      style: MmmTextStyles.heading5(
                                          textColor: gray6),
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    'images/Verified.svg',
                                    //height: 17.45,
                                    color: gray6,
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.07),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'images/location.svg',
                                      color: gray6,
                                    ),
                                    Container(
                                      child: Text(
                                        '  Pune, Maharashtra',
                                        //'${userCity.name}, ${userState.name}',
                                        style: MmmTextStyles.bodySmall(
                                            textColor: gray6),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          likeInfoList[profileIndex] == 0
                              ? MmmIcons.cancel(action: () {
                                  heartEvent(1);
                                })
                              : MmmIcons.heart(gray7, action: () {
                                  heartEvent(0);
                                }),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                      )
                    ],
                  ),
                  MmmButtons.swapViewButton(context, 'images/GridView.svg',
                      action: navigateToGridView)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void heartEvent(int likeInfo) {
    this.profileIndex = BlocProvider.of<StackViewBloc>(context).profileIndex;

    BlocProvider.of<StackViewBloc>(context).add(LikeOrUnlikeEvent(likeInfo));
  }

  int calculateAge() {
    this.profileIndex = BlocProvider.of<StackViewBloc>(context).profileIndex;
    DateTime currentDate = DateTime.now();
    this.dob = BlocProvider.of<StackViewBloc>(context)
        .userRepository
        .listProfileDetails[profileIndex]
        .dateOfBirth;
    DateTime birthDate = DateFormat('dd MMM yyyy').parse(dob);
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  void navigateToGridView() {
    var userRepo = BlocProvider.of<StackViewBloc>(context).userRepository;
    var likeInfoList = BlocProvider.of<StackViewBloc>(context).likeInfoList;
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => GridViewofStack(
              userRepository: userRepo,
              likeInfoList: likeInfoList,
            )));
  }

  void setColor(int indexCode) {
    setState(() {
      index = indexCode;
    });
  }

  void initData() {
    var userRepo = BlocProvider.of<StackViewBloc>(context).userRepository;

    this.profileIndex = BlocProvider.of<StackViewBloc>(context).profileIndex;
    this.likeInfoList = BlocProvider.of<StackViewBloc>(context).likeInfoList;
    this.profiledetails = BlocProvider.of<StackViewBloc>(context)
        .userRepository
        .listProfileDetails;
    print('data is here?heyyyyy');
    print(likeInfoList[0]);
    var i = profileIndex;
    print(profiledetails.length);
    print(profiledetails[i].name);
    print(profiledetails[i].dateOfBirth);
    print(profiledetails[i].height);

    print(profiledetails[i].maritalStatus);
    print(profiledetails[i].childrenStatus);
    print(profiledetails[i].abilityStatus);
    print(profiledetails[i].numberOfChildren);
    print(profiledetails[i].aboutMe);

    //   states = await BlocProvider.of<StackViewBloc>(context)
    //       .userRepository
//        .getStates(BlocProvider.of<StackViewBloc>(context)
//            .userRepository
//            .listProfileDetails[profileIndex]
//            .country);
//    userState = states.list[BlocProvider.of<StackViewBloc>(context)
    //       .userRepository
    //       .listProfileDetails[profileIndex]
    //       .state];
    //   city = await BlocProvider.of<StackViewBloc>(context)
    //       .userRepository
    //       .getCities(BlocProvider.of<StackViewBloc>(context)
    //           .userRepository
    //           .listProfileDetails[profileIndex]
    //          .state);
    //  userCity = city.list[BlocProvider.of<StackViewBloc>(context)
    //       .userRepository
//        .listProfileDetails[profileIndex]
//        .city];
  }
}
