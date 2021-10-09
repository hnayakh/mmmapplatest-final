import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

//import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:makemymarry/views/home/matching_profile/matching_profile_bloc.dart';

import 'matching_profile_state.dart';

class MatchingProfileStackView extends StatelessWidget {
  final UserRepository userRepository;
  final List<MatchingProfile> list;

  const MatchingProfileStackView(
      {Key? key, required this.userRepository, required this.list})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MatchingProfileBloc(userRepository, list),
      child: MatchingProfileStackViewScreen(),
    );
  }
}

class MatchingProfileStackViewScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MatchingProfileStackViewScreenState();
  }
}

class MatchingProfileStackViewScreenState
    extends State<MatchingProfileStackViewScreen>
    with TickerProviderStateMixin {
  late List<MatchingProfile> list;

  //late CardController controller;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MatchingProfileBloc, MatchingProfileState>(
      builder: (context, state) {
        this.list = BlocProvider.of<MatchingProfileBloc>(context).list;
        return Container(
          height: MediaQuery.of(context).size.height - 72,
          width: MediaQuery.of(context).size.width,
          color: gray5,
          child: new Text('TinderCard'),
        );
      },
      listener: (context, state) {},
    );
  }
}
