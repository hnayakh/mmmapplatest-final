import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/helper.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/matching_percentage/matching_percentage_bloc.dart';
import 'package:makemymarry/views/matching_percentage/matching_percentage_state.dart';

import '../../locator.dart';

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
              var name = BlocProvider.of<MatchingPercentageBloc>(context).name;
              var userImage =
                  BlocProvider.of<MatchingPercentageBloc>(context).userImage;
              var matchingFieldList =
                  BlocProvider.of<MatchingPercentageBloc>(context)
                      .matchingFieldList;
              var differentFieldList =
                  BlocProvider.of<MatchingPercentageBloc>(context)
                      .differentFieldList;

              List<String> incomes = [
                'No Income',
                '1 lakh',
                '2 lakh',
                '3 lakh',
                '4 lakh',
                '5 lakh',
                '7.5 lakh',
                '10 lakh',
                '15 lakh',
                '20 lakh',
                '25 lakh',
                '35 lakh',
                '50 lakh',
                '75 lakh',
                '1 crore',
                '1 crore and above'
              ];
              for (int j = 0; j < matchingFieldList.length; j++) {
                if (matchingFieldList[j]['filed'] == 'challenged') {
                  var aStr = matchingFieldList[j]['value']
                      .replaceAll(new RegExp(r'[^0-9]'), '');
                  int value;
                  try {
                    value = int.parse(aStr);
                  } catch (e) {
                    value = 0;
                  }
                  var val = AbilityStatus.values[value];
                  matchingFieldList[j]['value'] = val.toString().split('.')[1];
                }
                if (matchingFieldList[j]['filed'] == 'maritalStatus') {
                  var value = matchingFieldList[j]['value'];
                  matchingFieldList[j]['value'] = "";
                  value.split(',').forEach((e) {
                    var aStr = e.replaceAll(new RegExp(r'[^0-9]'), '');
                    int value;
                    try {
                      value = int.parse(aStr);
                    } catch (e) {
                      value = 0;
                    }
                    var val = AppHelper.getStringFromEnum(
                        MaritalStatus.values[value]);
                    matchingFieldList[j]['value'] +=
                        ((matchingFieldList[j]['value'].isEmpty ? "" : ", ") +
                            val.toString().split('.')[0]);
                  });
                }
                if (matchingFieldList[j]['filed'] == 'smokingHabits') {
                  var value = matchingFieldList[j]['value'];
                  matchingFieldList[j]['value'] = "";
                  value.split(',').forEach((e) {
                    var aStr = e.replaceAll(new RegExp(r'[^0-9]'), '');
                    int value;
                    try {
                      value = int.parse(aStr);
                    } catch (e) {
                      value = 0;
                    }
                    var val =
                        AppHelper.getStringFromEnum(SmokingHabit.values[value]);
                    matchingFieldList[j]['value'] +=
                        ((matchingFieldList[j]['value'].isEmpty ? "" : ", ") +
                            val.toString().split('.')[0]);
                  });
                }
                if (matchingFieldList[j]['filed'] == 'highestEducation') {
                  matchingFieldList[j]['value'] = matchingFieldList[j]['value']
                      .toString()
                      .split(",")
                      .where((e) => e.isNotNullEmpty)
                      .toList()
                      .map((e) => getIt<UserRepository>()
                          .masterData
                          .listEducation
                          .firstWhere((element) => element.text == e)
                          .title)
                      .toList()
                      .join(", ");
                } else if (matchingFieldList[j]['filed'] == 'drinkingHabits') {
                  var value = matchingFieldList[j]['value'];
                  matchingFieldList[j]['value'] = "";
                  value.split(',').forEach((e) {
                    var aStr = e.replaceAll(new RegExp(r'[^0-9]'), '');
                    int value;
                    try {
                      value = int.parse(aStr);
                    } catch (e) {
                      value = 0;
                    }
                    var val = AppHelper.getStringFromEnum(
                        DrinkingHabit.values[value]);
                    matchingFieldList[j]['value'] +=
                        ((matchingFieldList[j]['value'].isEmpty ? "" : ", ") +
                            val.toString().split('.')[0]);
                  });
                } else if (matchingFieldList[j]['filed'] == 'dietaryHabits') {
                  var value = matchingFieldList[j]['value'];
                  matchingFieldList[j]['value'] = "";
                  value.split(',').forEach((e) {
                    var aStr = e.replaceAll(new RegExp(r'[^0-9]'), '');
                    int value;
                    try {
                      value = int.parse(aStr);
                    } catch (e) {
                      value = 0;
                    }
                    var val =
                        AppHelper.getStringFromEnum(EatingHabit.values[value]);
                    matchingFieldList[j]['value'] +=
                        ((matchingFieldList[j]['value'].isEmpty ? "" : ", ") +
                            val.toString().split('.')[0]);
                  });
                } else if (matchingFieldList[j]['filed'] == 'maxIncome') {
                  var aStr = matchingFieldList[j]['value']
                      .replaceAll(new RegExp(r'[^0-9]'), '');
                  int value = int.parse(aStr);
                  var val = incomes[value];
                  matchingFieldList[j]['value'] = val;
                } else if (matchingFieldList[j]['filed'] == 'minIncome') {
                  var aStr = matchingFieldList[j]['value']
                      .replaceAll(new RegExp(r'[^0-9]'), '');
                  int value = int.parse(aStr);
                  var val = incomes[value];
                  matchingFieldList[j]['value'] = val;
                }
              }
              // get enum data for differentFieldList>>>>>
              for (int j = 0; j < differentFieldList.length; j++) {
                if (differentFieldList[j]['filed'] == 'smokingHabits') {
                  var value = differentFieldList[j]['value'];
                  differentFieldList[j]['value'] = "";
                  value.split(',').forEach((e) {
                    var aStr = e.replaceAll(new RegExp(r'[^0-9]'), '');
                    int value;
                    try {
                      value = int.parse(aStr);
                    } catch (e) {
                      value = 0;
                    }
                    var val =
                        AppHelper.getStringFromEnum(SmokingHabit.values[value]);
                    differentFieldList[j]['value'] +=
                        ((differentFieldList[j]['value'].isEmpty ? "" : ", ") +
                            val.toString().split('.')[0]);
                  });
                }if (differentFieldList[j]['filed'] == 'highestEducation') {
                  differentFieldList[j]['value'] = differentFieldList[j]['value']
                      .toString()
                      .split(",")
                      .where((e) => e.isNotNullEmpty)
                      .toList()
                      .map((e) => getIt<UserRepository>()
                      .masterData
                      .listEducation
                      .firstWhere((element) => element.text == e)
                      .title)
                      .toList()
                      .join(", ");
                } else if (differentFieldList[j]['filed'] == 'drinkingHabits') {
                  var value = differentFieldList[j]['value'];
                  differentFieldList[j]['value'] = "";
                  value.split(',').forEach((e) {
                    var aStr = e.replaceAll(new RegExp(r'[^0-9]'), '');
                    int value;
                    try {
                      value = int.parse(aStr);
                    } catch (e) {
                      value = 0;
                    }
                    var val = AppHelper.getStringFromEnum(
                        DrinkingHabit.values[value]);
                    differentFieldList[j]['value'] +=
                        ((differentFieldList[j]['value'].isEmpty ? "" : ", ") +
                            val.toString().split('.')[0]);
                  });
                } else if (differentFieldList[j]['filed'] == 'dietaryHabits') {
                  var value = differentFieldList[j]['value'];
                  differentFieldList[j]['value'] = "";
                  value.split(',').forEach((e) {
                    var aStr = e.replaceAll(new RegExp(r'[^0-9]'), '');
                    int value;
                    try {
                      value = int.parse(aStr);
                    } catch (e) {
                      value = 0;
                    }
                    var val =
                        AppHelper.getStringFromEnum(EatingHabit.values[value]);
                    differentFieldList[j]['value'] +=
                        ((differentFieldList[j]['value'].isEmpty ? "" : ", ") +
                            val.toString().split('.')[0]);
                  });
                } else if (differentFieldList[j]['filed'] == 'maxIncome') {
                  var aStr = differentFieldList[j]['value']
                      .replaceAll(new RegExp(r'[^0-9]'), '');
                  int value = int.parse(aStr);
                  var val = incomes[value];
                  differentFieldList[j]['value'] = val;
                } else if (differentFieldList[j]['filed'] == 'minIncome') {
                  var aStr = differentFieldList[j]['value']
                      .replaceAll(new RegExp(r'[^0-9]'), '');
                  int value = int.parse(aStr);
                  var val = incomes[value];
                  differentFieldList[j]['value'] = val;
                }
                if (differentFieldList[j]['filed'] == 'maritalStatus') {
                  var value = differentFieldList[j]['value'];
                  differentFieldList[j]['value'] = "";
                  value.split(',').forEach((e) {
                    var aStr = e.replaceAll(new RegExp(r'[^0-9]'), '');
                    int value;
                    try {
                      value = int.parse(aStr);
                    } catch (e) {
                      value = 0;
                    }
                    var val = AppHelper.getStringFromEnum(
                        MaritalStatus.values[value]);
                    differentFieldList[j]['value'] +=
                        ((differentFieldList[j]['value'].isEmpty ? "" : ", ") +
                            val.toString().split('.')[0]);
                  });
                }
                if (differentFieldList[j]['filed'] == 'challenged') {
                  var aStr = differentFieldList[j]['value']
                      .replaceAll(new RegExp(r'[^0-9]'), '');
                  int value;
                  try {
                    value = int.parse(aStr);
                  } catch (e) {
                    value = 0;
                  }
                  var val = AbilityStatus.values[value];
                  differentFieldList[j]['value'] = val.toString().split('.')[1];
                }
              }
              var minAgeIndex = matchingFieldList
                  .indexWhere((element) => element['filed'] == 'minAge');
              var maxAgeIndex = matchingFieldList
                  .indexWhere((element) => element['filed'] == 'maxAge');
              if (minAgeIndex >= 0 && maxAgeIndex >= 0) {
                var minAge = matchingFieldList[minAgeIndex]['value'];

                var maxAge = matchingFieldList[maxAgeIndex]['value'];

                matchingFieldList
                    .add({'filed': 'Age', 'value': '$minAge to $maxAge'});
                matchingFieldList
                    .removeWhere((element) => element['filed'] == 'minAge');
                matchingFieldList
                    .removeWhere((element) => element['filed'] == 'maxAge');
              }
              minAgeIndex = differentFieldList
                  .indexWhere((element) => element['filed'] == 'minAge');
              maxAgeIndex = differentFieldList
                  .indexWhere((element) => element['filed'] == 'maxAge');
              if (minAgeIndex >= 0 && maxAgeIndex >= 0) {
                var minAge = differentFieldList[minAgeIndex]['value'];

                var maxAge = differentFieldList[maxAgeIndex]['value'];

                differentFieldList
                    .add({'filed': 'Age', 'value': '$minAge to $maxAge'});

                differentFieldList
                    .removeWhere((element) => element['filed'] == 'minAge');
                differentFieldList
                    .removeWhere((element) => element['filed'] == 'maxAge');
              }

              var minHeightIndex = matchingFieldList
                  .indexWhere((element) => element['filed'] == 'minHeight');
              var maxHeightIndex = matchingFieldList
                  .indexWhere((element) => element['filed'] == 'maxHeight');
              if (minHeightIndex >= 0 && maxHeightIndex >= 0) {
                var minHeight = matchingFieldList[minHeightIndex]['value'];

                var maxHeight = matchingFieldList[maxHeightIndex]['value'];

                matchingFieldList.add(
                    {'filed': 'Height', 'value': '$minHeight - $maxHeight'});
                matchingFieldList
                    .removeWhere((element) => element['filed'] == 'minHeight');
                matchingFieldList
                    .removeWhere((element) => element['filed'] == 'maxHeight');
              }
              minHeightIndex = differentFieldList
                  .indexWhere((element) => element['filed'] == 'minHeight');
              maxHeightIndex = differentFieldList
                  .indexWhere((element) => element['filed'] == 'maxHeight');
              if (minHeightIndex >= 0 && maxHeightIndex >= 0) {
                var minHeight = differentFieldList[minHeightIndex]['value'];

                var maxHeight = differentFieldList[maxHeightIndex]['value'];

                differentFieldList.add({
                  'filed': 'Height',
                  'value':
                      '${AppHelper.heightString(double.parse(minHeight.toString()))} - ${AppHelper.heightString(double.parse(maxHeight.toString()))}'
                });

                differentFieldList
                    .removeWhere((element) => element['filed'] == 'minHeight');
                differentFieldList
                    .removeWhere((element) => element['filed'] == 'maxHeight');
              }
              return Container(
                padding: kMargin16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.244,
                          width: MediaQuery.of(context).size.width * 0.90,
                          //color: Colors.orangeAccent,
                        ),
                        Positioned(
                          left: 68,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.width * 0.122,
                                child: Container(
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  clipBehavior: Clip.hardEdge,
                                  child: Image.network(userImage,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.244,
                                      width: MediaQuery.of(context).size.width *
                                          0.244,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, obj, str) =>
                                          Container(
                                              color: Colors.grey,
                                              child: Icon(Icons.error))),
                                ),
                              ),
                              SizedBox(
                                width: 24,
                              ),
                              CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.width * 0.122,
                                child: Container(
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  clipBehavior: Clip.hardEdge,
                                  child: Image.network('$image',
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, obj, str) =>
                                          Container(
                                              color: Colors.grey,
                                              child: Icon(Icons.error))),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.width * 0.244,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              child: SvgPicture.asset(
                                "images/heart.svg",
                                color: Colors.pinkAccent,
                                height: 65,
                                width: 65,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      // width: 900.0,
                      margin: const EdgeInsets.symmetric(vertical: 16.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Color(0xffDDE1E6),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              'You Match Percentage with $name is $percent%',
                              style:
                                  MmmTextStyles.heading4(textColor: kPrimary),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: LinearProgressIndicator(
                              backgroundColor: Color(0xffFFC2CD),
                              minHeight: 7,
                              value: percent.toDouble() / 100.0,
                              semanticsLabel: 'Linear progress indicator',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (matchingFieldList.isNotEmpty)
                      Column(
                        children: List.generate(matchingFieldList.length, (i) {
                          return TextFormField(
                            enabled: false,
                            readOnly: true,
                            maxLines: null,
                            initialValue:
                                matchingFieldList[i]['value'].toString(),
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: AppHelper.getLabelOfComparitiveField(
                                  matchingFieldList[i]['filed'].toString()),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  "images/tick.svg",
                                  color: Colors.green,
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              // Icon(Icons.verified, color: Colors.green)
                            ),
                          );
                        }),
                      ),

                    if (differentFieldList.isNotEmpty)
                      Column(
                        children: List.generate(
                          differentFieldList.length,
                          (i) {
                            return TextFormField(
                              enabled: false,
                              readOnly: true,
                              maxLines: null,
                              initialValue:
                                  differentFieldList[i]['value'].toString(),
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: AppHelper.getLabelOfComparitiveField(
                                    differentFieldList[i]['filed'].toString()),
                                suffixIcon: Icon(
                                  Icons.cancel_outlined,
                                  color: Colors.red,
                                  size: 28,
                                ),
                              ),
                            );
                          },
                        ),
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
