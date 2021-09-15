import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/stackviewscreens/stackview/stack_view.dart';
import 'package:makemymarry/views/stackviewscreens/stackview/stack_view_bloc.dart';

class GridViewofStack extends StatefulWidget {
  const GridViewofStack({Key? key}) : super(key: key);

  @override
  _GridViewofStackState createState() => _GridViewofStackState();
}

class _GridViewofStackState extends State<GridViewofStack> {
  int? index;

  late StateCityResponse states;

  late StateCityResponse city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1,
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        itemBuilder: (BuildContext context, int index) {
                          initData(index);
                          return Container();

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
                          //   return MmmWidgets.stackUserprofileWidget(
                          //       context: context,
                          //       age: calculateAge(index),
                          //       imageUrl: imageUrl,
                          //       name: name,
                          //       userCity: userCity.name,
                          //       userState: userState.name);
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
                            MmmWidgets.bottomBarUnits('images/menu.svg', 'More',
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
      ),
    );
  }

  void navigateToStackView() {
    var userRepo = BlocProvider.of<StackViewBloc>(context).userRepository;
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => StackView(
              userRepository: userRepo,
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
    DateTime birthDate = DateTime.parse(dob);
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
