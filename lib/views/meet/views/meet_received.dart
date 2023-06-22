import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:makemymarry/views/meet/bloc/meet_list_bloc.dart';
import 'package:makemymarry/views/meet/bloc/meet_list_state.dart';

import 'meet_tile_view.dart';

class MReceivedScreen extends StatelessWidget {
  const MReceivedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MeetListBloc, MeetListState>(
          builder: (context, state) {
          return Container(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return MeetTile(
                  connection: state.receivedMeets[index],
                    isReceived: true
                );
              },
              itemCount: state.receivedMeets.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
            ),
          );
        }
      ),
    );
  }


}
