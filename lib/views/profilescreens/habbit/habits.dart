import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:makemymarry/bloc/habits/habit_bloc.dart';
import 'package:makemymarry/bloc/habits/habit_event.dart';
import 'package:makemymarry/bloc/habits/habit_state.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';

import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/profilescreens/religion/religion.dart';

class Habit extends StatelessWidget {
  final UserRepository userRepository;

  const Habit({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HabitBloc(userRepository),
      child: HabitScreen(),
    );
  }
}

class HabitScreen extends StatefulWidget {
  HabitScreen({Key? key}) : super(key: key);

  @override
  _HabitScreenState createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  EatingHabit? eatingHabit;
  SmokingHabit? smokingHabit;
  DrinkingHabit? drinkingHabit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HabitBloc, HabitState>(
        listener: (context, state) {
          if (state is NavigationToReligion) {
            navigateToReligion();
          }
        },
        builder: (context, state) {
          initData();
          return SafeArea(
              child: Expanded(
                  child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MmmButtons.appBarCurved('Habits', context: context),
                Container(
                  padding: kMargin16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Eating',
                        style:
                            MmmTextStyles.bodySmall(textColor: kModalPrimary),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 8,
                            child: eatingHabit == EatingHabit.Vegetarrian
                                ? MmmButtons.habitsEnabled(
                                    50, 152, 'images/Veg2.svg', 'Vegetarrian')
                                : MmmButtons.habitsDisabled(
                                    50, 152, 'images/Veg2.svg', 'Vegetarrian',
                                    action: () {
                                    vegOptionSelected();
                                  }),
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                          Expanded(
                            flex: 8,
                            child: eatingHabit == EatingHabit.Eggitarrian
                                ? MmmButtons.habitsEnabled(
                                    50, 144, 'images/egg.svg', 'eggetarian')
                                : MmmButtons.habitsDisabled(
                                    50, 144, 'images/egg.svg', 'eggetarian',
                                    action: () {
                                    eggOptionSelected();
                                  }),
                          ),
                          Expanded(flex: 3, child: SizedBox())
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: eatingHabit == EatingHabit.Nonvegetarrian
                                ? MmmButtons.habitsEnabled(50, 193,
                                    'images/non veg.svg', 'Non-Vegetarrian')
                                : MmmButtons.habitsDisabled(
                                    50,
                                    193,
                                    'images/non veg.svg',
                                    'Non-Vegetarrian', action: () {
                                    nonvegOptionSelected();
                                  }),
                          ),
                          Expanded(flex: 1, child: SizedBox())
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Smoking',
                            style: MmmTextStyles.bodySmall(
                                textColor: kModalPrimary),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: smokingHabit == SmokingHabit.Smoker
                                    ? MmmButtons.habitsEnabled(
                                        50, 116, 'images/smoke.svg', 'Smoker')
                                    : MmmButtons.habitsDisabled(
                                        50, 116, 'images/smoke.svg', 'Smoker',
                                        action: () {
                                        smokingOptionSelected();
                                      }),
                              ),
                              Expanded(
                                flex: 1,
                                child: SizedBox(),
                              ),
                              Expanded(
                                flex: 7,
                                child: smokingHabit == SmokingHabit.NonSmoker
                                    ? MmmButtons.habitsEnabled(50, 161,
                                        'images/noSmoke.svg', 'Never Smoke')
                                    : MmmButtons.habitsDisabled(
                                        50,
                                        161,
                                        'images/noSmoke.svg',
                                        'Never Smoke', action: () {
                                        nonSmokingOptionSelected();
                                      }),
                              ),
                              Expanded(
                                flex: 3,
                                child: SizedBox(),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Alcoholic',
                            style: MmmTextStyles.bodySmall(
                                textColor: kModalPrimary),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: drinkingHabit == DrinkingHabit.Alcoholic
                                    ? MmmButtons.habitsEnabled(50, 130,
                                        'images/alcoholic.svg', 'Alcoholic')
                                    : MmmButtons.habitsDisabled(
                                        50,
                                        130,
                                        'images/alcoholic.svg',
                                        'Alcoholic', action: () {
                                        alchoholicOptionSelected();
                                      }),
                              ),
                              Expanded(
                                flex: 1,
                                child: SizedBox(),
                              ),
                              Expanded(
                                flex: 7,
                                child:
                                    drinkingHabit == DrinkingHabit.Nonalcoholic
                                        ? MmmButtons.habitsEnabled(
                                            50,
                                            165,
                                            'images/non_alcoholic.svg',
                                            'Non-Alcoholic')
                                        : MmmButtons.habitsDisabled(
                                            50,
                                            165,
                                            'images/non_alcoholic.svg',
                                            'Non-Alcoholic', action: () {
                                            nonalchoholicOptionSelected();
                                          }),
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child:
                                    drinkingHabit == DrinkingHabit.Occasionally
                                        ? MmmButtons.habitsEnabled(
                                            50,
                                            160,
                                            'images/occasionally.svg',
                                            'Occasionally')
                                        : MmmButtons.habitsDisabled(
                                            50,
                                            160,
                                            'images/occasionally.svg',
                                            'Occasionally', action: () {
                                            occasionalOptionSelected();
                                          }),
                              ),
                              Expanded(flex: 1, child: SizedBox())
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
                bottom: 24,
                right: 24,
                child: InkWell(
                  onTap: () {
                    BlocProvider.of<HabitBloc>(context).add(UpdateHabit());
                  },
                  child: MmmIcons.rightArrowEnabled(),
                )),
            state is OnLoading ? MmmWidgets.buildLoader(context) : Container()
          ])));
        },
      ),
    );
  }

  void vegOptionSelected() {
    BlocProvider.of<HabitBloc>(context)
        .add(EatingHabitSelected(EatingHabit.Vegetarrian));
  }

  void eggOptionSelected() {
    BlocProvider.of<HabitBloc>(context)
        .add(EatingHabitSelected(EatingHabit.Eggitarrian));
  }

  void nonvegOptionSelected() {
    BlocProvider.of<HabitBloc>(context)
        .add(EatingHabitSelected(EatingHabit.Nonvegetarrian));
  }

  void smokingOptionSelected() {
    BlocProvider.of<HabitBloc>(context)
        .add(SmokingHabitSelected(SmokingHabit.Smoker));
  }

  void nonSmokingOptionSelected() {
    BlocProvider.of<HabitBloc>(context)
        .add(SmokingHabitSelected(SmokingHabit.NonSmoker));
  }

  void alchoholicOptionSelected() {
    BlocProvider.of<HabitBloc>(context)
        .add(DrinkingHabitSelected(DrinkingHabit.Alcoholic));
  }

  void nonalchoholicOptionSelected() {
    BlocProvider.of<HabitBloc>(context)
        .add(DrinkingHabitSelected(DrinkingHabit.Nonalcoholic));
  }

  void occasionalOptionSelected() {
    BlocProvider.of<HabitBloc>(context)
        .add(DrinkingHabitSelected(DrinkingHabit.Occasionally));
  }

  void navigateToReligion() {
    var userRepo = BlocProvider.of<HabitBloc>(context).userRepository;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Religion(
              userRepository: userRepo,
            )));
  }

  void initData() {
    this.eatingHabit = BlocProvider.of<HabitBloc>(context).eatingHabit;
    this.drinkingHabit = BlocProvider.of<HabitBloc>(context).drinkingHabit;
    this.smokingHabit = BlocProvider.of<HabitBloc>(context).smokingHabit;
  }
}
