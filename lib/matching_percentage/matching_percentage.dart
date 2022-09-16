import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/matching_percentage/matching_percentage_bloc.dart';
import 'package:makemymarry/matching_percentage/matching_percentage_event.dart';
import 'package:makemymarry/matching_percentage/matching_percentage_state.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:makemymarry/views/home/menu/account_menu_bloc.dart';
import 'package:makemymarry/views/profile_loader/profile_loader.dart';
import 'package:makemymarry/views/profilescreens/bio/bio.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/sidebar_about_screen.dart';

class MatchingPercentageScreen extends StatefulWidget {
  final UserRepository userRepository;
  final matchingPercentage;
  const MatchingPercentageScreen(
      {Key? key, required this.userRepository, this.matchingPercentage})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MatchingPercentageScreenState();
  }
}

class MatchingPercentageScreenState extends State<MatchingPercentageScreen> {
  int matchingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    context.read<MatchingPercentageBloc>().add(MatchProfile());
    return Scaffold(
        appBar:
            MmmButtons.appBarCurved('Matching Percentage', context: context),
        body: SingleChildScrollView(
          child: BlocConsumer<MatchingPercentageBloc, MatchingPercentageState>(
            listener: (context, state) {},
            builder: (context, state) {
              var percent = BlocProvider.of<MatchingPercentageBloc>(context)
                  .matchingPercentage;
              var image =
                  BlocProvider.of<MatchingPercentageBloc>(context).images;
              var matchingFieldList =
                  BlocProvider.of<MatchingPercentageBloc>(context)
                      .matchingFieldList;
              var differentFieldList =
                  BlocProvider.of<MatchingPercentageBloc>(context)
                      .differentFieldList;
              // print("percent$percent");
              // print("percent$image");
              // print("percent$matchingFieldList");
              // print("percent$differentFieldList");

              // get enum data for matchingFieldList>>>>>
              for (int j = 0; j < matchingFieldList.length; j++) {
                if (matchingFieldList[j]['filed'] == 'challenged') {
                  var aStr = matchingFieldList[j]['value']
                      .replaceAll(new RegExp(r'[^0-9]'), '');
                  int value = int.parse(aStr);
                  var val = AbilityStatus.values[value];
                  matchingFieldList[j]['value'] = val.toString().split('.')[1];
                }
              }
              // get enum data for differentFieldList>>>>>
              for (int j = 0; j < differentFieldList.length; j++) {
                if (differentFieldList[j]['filed'] == 'smokingHabits') {
                  var aStr = differentFieldList[j]['value']
                      .replaceAll(new RegExp(r'[^0-9]'), '');
                  int value = int.parse(aStr);
                  var val = SmokingHabit.values[value];
                  differentFieldList[j]['value'] = val.toString().split('.')[1];
                } else if (differentFieldList[j]['filed'] == 'drinkingHabits') {
                  var aStr = differentFieldList[j]['value']
                      .replaceAll(new RegExp(r'[^0-9]'), '');
                  int value = int.parse(aStr);
                  var val = DrinkingHabit.values[value];
                  differentFieldList[j]['value'] = val.toString().split('.')[1];
                } else if (differentFieldList[j]['filed'] == 'dietaryHabits') {
                  var aStr = differentFieldList[j]['value']
                      .replaceAll(new RegExp(r'[^0-9]'), '');
                  int value = int.parse(aStr);
                  var val = EatingHabit.values[value];
                  differentFieldList[j]['value'] = val.toString().split('.')[1];
                } else if (differentFieldList[j]['filed'] == 'maxIncome') {
                  var aStr = differentFieldList[j]['value']
                      .replaceAll(new RegExp(r'[^0-9]'), '');
                  int value = int.parse(aStr);
                  var val = AnualIncome.values[value];
                  differentFieldList[j]['value'] = val.toString().split('.')[1];
                } else if (differentFieldList[j]['filed'] == 'minIncome') {
                  var aStr = differentFieldList[j]['value']
                      .replaceAll(new RegExp(r'[^0-9]'), '');
                  int value = int.parse(aStr);
                  var val = AnualIncome.values[value];
                  differentFieldList[j]['value'] = val.toString().split('.')[1];
                }
              }

              return Container(
                padding: kMargin16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                    ),
                    Stack(children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.17,
                        width: MediaQuery.of(context).size.width * 0.244,
                        //color: Colors.orangeAccent,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(width: 0.1),
                          CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.122,
                            child: ClipOval(
                              child: Image.network(
                                'images/stackviewImage.jpg',
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 0.1),
                          Container(
                            height: 45,
                            width: 45,
                            child: Center(
                              child: SvgPicture.asset(
                                "images/heart.svg",
                                color: Colors.white,
                                height: 62,
                                width: 62,
                              ),
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: MmmDecorations.primaryGradient(),
                                border: Border.all(
                                    color: Colors.white, width: 1.2)),
                          ),
                          SizedBox(width: 0.1),
                          CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.122,
                            child: ClipOval(
                              child: Image.network(
                                '$image',
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                    Column(
                      children: [
                        Text(
                          'You Match Percentage with Alia is $percent%',
                          style: MmmTextStyles.heading4(textColor: kPrimary),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        LinearProgressIndicator(
                          backgroundColor: Colors.grey.shade400,
                          minHeight: 5,
                          value: percent.toDouble() / 100.0,
                          semanticsLabel: 'Linear progress indicator',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // ListTile(
                    //   title: Text("ok"),
                    //   subtitle: Text("ok"),
                    // ),
                    // if (matchingFieldList.isEmpty && differentFieldList.isEmpty)
                    //   Center(
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(50.0),
                    //       child: Text(
                    //         "No information available!",
                    //         style: MmmTextStyles.heading4(),
                    //       ),
                    //     ),
                    //   ),
                    if (matchingFieldList.isNotEmpty)
                      Column(
                        children: List.generate(matchingFieldList.length, (i) {
                          return TextFormField(
                            // autovalidateMode: AutovalidateMode.disabled,
                            enabled: false,
                            // autofocus: false,
                            readOnly: true,
                            initialValue:
                                matchingFieldList[i]['value'].toString(),
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText:
                                    matchingFieldList[i]['filed'].toString(),
                                suffixIcon:
                                    Icon(Icons.verified, color: Colors.green)),
                          );
                        }),
                      ),

                    if (differentFieldList.isNotEmpty)
                      Column(
                        children: List.generate(differentFieldList.length, (i) {
                          return TextFormField(
                            // autovalidateMode: AutovalidateMode.disabled,
                            enabled: false,
                            // autofocus: false,
                            readOnly: true,
                            initialValue:
                                differentFieldList[i]['value'].toString(),
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText:
                                    differentFieldList[i]['filed'].toString(),
                                suffixIcon:
                                    Icon(Icons.cancel, color: Colors.red)),
                          );
                        }),
                      ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // TextFormField(
                    //   initialValue: "5'5 to 6'0",
                    //   decoration: const InputDecoration(
                    //     border: UnderlineInputBorder(),
                    //     labelText: 'Height',
                    //     suffixIcon: Icon(Icons.cancel, color: Colors.red),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // TextFormField(
                    //   initialValue: "Never Married",
                    //   decoration: const InputDecoration(
                    //       border: UnderlineInputBorder(),
                    //       labelText: 'Maritial Status',
                    //       suffixIcon:
                    //           Icon(Icons.verified, color: Colors.green)),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // TextFormField(
                    //   initialValue: "Private Sector",
                    //   decoration: const InputDecoration(
                    //       border: UnderlineInputBorder(),
                    //       labelText: 'Working With',
                    //       suffixIcon:
                    //           Icon(Icons.verified, color: Colors.green)),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // TextFormField(
                    //   initialValue: "Hindu",
                    //   decoration: const InputDecoration(
                    //       border: UnderlineInputBorder(),
                    //       labelText: 'Religion',
                    //       suffixIcon:
                    //           Icon(Icons.verified, color: Colors.green)),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // TextFormField(
                    //   initialValue: "Hindi",
                    //   decoration: const InputDecoration(
                    //       border: UnderlineInputBorder(),
                    //       labelText: 'Mother Toungue',
                    //       suffixIcon:
                    //           Icon(Icons.verified, color: Colors.green)),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // TextFormField(
                    //   initialValue: "India",
                    //   decoration: const InputDecoration(
                    //       border: UnderlineInputBorder(),
                    //       labelText: 'Country living in',
                    //       suffixIcon:
                    //           Icon(Icons.verified, color: Colors.green)),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // TextFormField(
                    //   initialValue: "Engineering",
                    //   decoration: const InputDecoration(
                    //       border: UnderlineInputBorder(),
                    //       labelText: 'Education',
                    //       suffixIcon:
                    //           Icon(Icons.verified, color: Colors.green)),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // TextFormField(
                    //   initialValue: "Great",
                    //   decoration: const InputDecoration(
                    //       border: UnderlineInputBorder(),
                    //       labelText: 'Family Values',
                    //       suffixIcon:
                    //           Icon(Icons.verified, color: Colors.green)),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // TextFormField(
                    //   initialValue: "Vegeterian",
                    //   decoration: const InputDecoration(
                    //       border: UnderlineInputBorder(),
                    //       labelText: 'LifeStyle',
                    //       suffixIcon:
                    //           Icon(Icons.verified, color: Colors.green)),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // TextFormField(
                    //   initialValue: "Above INR 10Lakhs",
                    //   decoration: const InputDecoration(
                    //       border: UnderlineInputBorder(),
                    //       labelText: 'Annaual Income',
                    //       suffixIcon:
                    //           Icon(Icons.verified, color: Colors.green)),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
