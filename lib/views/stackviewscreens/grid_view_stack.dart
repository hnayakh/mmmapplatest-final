import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/stackviewscreens/stackview/stack_view.dart';
import 'package:makemymarry/views/stackviewscreens/stackview/stack_view_bloc.dart';

import 'stackview/stack_view_state.dart';

class GridViewofStack extends StatelessWidget {
  final UserRepository userRepository;
  final List<int> likeInfoList;
  final int profileIndex;
  const GridViewofStack(
      {Key? key,
      required this.userRepository,
      required this.likeInfoList,
      required this.profileIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          StackViewBloc(userRepository, likeInfoList, profileIndex),
      child: GridViewofStackScreen(),
    );
  }
}

class GridViewofStackScreen extends StatefulWidget {
  const GridViewofStackScreen({Key? key}) : super(key: key);

  @override
  _GridViewofStackScreenState createState() => _GridViewofStackScreenState();
}

class _GridViewofStackScreenState extends State<GridViewofStackScreen> {
  int? index;

  late StateCityResponse states;

  late StateCityResponse city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<StackViewBloc, StackViewState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                          padding: kMargin16,
                          child: GridView.builder(
                            shrinkWrap: false,
                            itemCount: BlocProvider.of<StackViewBloc>(context)
                                .userRepository
                                .listProfileDetails
                                .length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 1,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemBuilder: (BuildContext context, int index) {
                              initData(index);

                              // var userState = states.list[
                              //     BlocProvider.of<StackViewBloc>(context)
                              //         .userRepository
                              //         .listProfileDetails[index]
                              //        .state];

                              //  var userCity = city.list[
                              //      BlocProvider.of<StackViewBloc>(context)
                              //         .userRepository
                              //         .listProfileDetails[index]
                              //        .city];
                              //   var name = BlocProvider.of<StackViewBloc>(context)
                              //      .userRepository
                              //       .listProfileDetails[index]
                              //       .name;
                              //   var imageUrl = BlocProvider.of<StackViewBloc>(context)
                              //       .userRepository
                              //       .listProfileDetails[index]
                              //        .imageUrl;
                              return MmmWidgets.stackUserprofileWidget(
                                  context: context,
                                  age: calculateAge(index),
                                  imageUrl: 'images/stackviewImage.jpg',
                                  name: BlocProvider.of<StackViewBloc>(context)
                                      .userRepository
                                      .listProfileDetails[index]
                                      .name,
                                  userCity: 'pune',
                                  userState: 'Maharashtra');
                            },
                          )),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: (Container(
                          height: 68,
                          decoration: BoxDecoration(boxShadow: [
                            MmmShadow.elevationStack(),
                          ]),
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MmmWidgets.bottomBarUnits(
                                    'images/Search.svg',
                                    'Search',
                                    index == 0 ? kPrimary : gray3, action: () {
                                  setColor(0);
                                }),
                                MmmWidgets.bottomBarUnits(
                                    'images/filter2.svg',
                                    'Filter',
                                    index == 1 ? kPrimary : gray3, action: () {
                                  setColor(1);
                                }),
                                MmmWidgets.bottomBarUnits(
                                    'images/connect.svg',
                                    'Connect',
                                    index == 2 ? kPrimary : gray3, action: () {
                                  setColor(2);
                                }),
                                MmmWidgets.bottomBarUnits(
                                    'images/Search.svg',
                                    'Notifications',
                                    index == 3 ? kPrimary : gray3, action: () {
                                  setColor(3);
                                }),
                                MmmWidgets.bottomBarUnits(
                                    'images/menu.svg',
                                    'More',
                                    index == 4 ? kPrimary : gray3, action: () {
                                  setColor(4);
                                })
                              ]),
                        ))),
                      ],
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  MmmButtons.swapViewButton(context, 'images/stack view.svg',
                      action: navigateToStackView),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  void navigateToStackView() {
    var userRepo = BlocProvider.of<StackViewBloc>(context).userRepository;
    var likeInfoList = BlocProvider.of<StackViewBloc>(context).likeInfoList;
    var profileIndex = BlocProvider.of<StackViewBloc>(context).profileIndex;
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => StackView(
              userRepository: userRepo,
              likeInfoList: likeInfoList,
              profileIndex: profileIndex,
            )));
  }

  void setColor(int indexCode) {
    setState(() {
      index = indexCode;
    });
  }

  int calculateAge(int index) {
    DateTime currentDate = DateTime.now();
    var dob = BlocProvider.of<StackViewBloc>(context)
        .userRepository
        .listProfileDetails[index]
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

  Future<void> initData(int index) async {
    // states = await BlocProvider.of<StackViewBloc>(context)
    //     .userRepository
    //    .getStates(BlocProvider.of<StackViewBloc>(context)
    //        .userRepository
    //       .listProfileDetails[index]
    //       .country);
    //  city = await BlocProvider.of<StackViewBloc>(context)
    //     .userRepository
    //     .getCities(BlocProvider.of<StackViewBloc>(context)
    //        .userRepository
    //        .listProfileDetails[index]
    //       .state);
  }
}
