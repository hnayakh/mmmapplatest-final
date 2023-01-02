import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/matching_percentage/matching_percentage_bloc.dart';
import 'package:makemymarry/views/matching_percentage/matching_percentage_event.dart';
import 'package:makemymarry/views/matching_percentage/matching_percentage_state.dart';

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
              var name = BlocProvider.of<MatchingPercentageBloc>(context).name;
              var userImage =
                  BlocProvider.of<MatchingPercentageBloc>(context).userImage;
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
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width * 0.90,
                        //color: Colors.orangeAccent,
                      ),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.end,
                      //   verticalDirection: VerticalDirection.down,
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   // mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      // SizedBox(height: 10),
                      //SizedBox(width: 80),
                      Positioned(
                        left: 68,
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.122,
                          child: ClipOval(
                            child: Image.network(
                              userImage,
                              // 'images/stackviewImage.jpg',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      //  SizedBox(width: 20),
                      Positioned(
                        left: 188,
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.122,
                          child: ClipOval(
                            child: Image.network(
                              '$image',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 148,
                        top: 30,
                        child: Container(
                          child: SvgPicture.asset(
                            "images/heart.svg",
                            color: Colors.pinkAccent,
                            height: 65,
                            width: 65,
                          ),
                        ),
                      ),
                      //  SizedBox(width: 80),
                      //],
                      //),
                    ]),
                    //  SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      height: 70.0,
                      // width: 900.0,
                      margin: const EdgeInsets.all(20.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        color: Color(0xffF0EFF5),
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
                          Center(
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.grey.shade400,
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
                                suffixIcon: Icon(
                                  Icons.cancel_outlined,
                                  color: Colors.red,
                                  size: 28,
                                )),
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
