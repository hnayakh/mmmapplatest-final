import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';

import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/profile%20screens/verify%20account%20screens/select_idproof_bottom_sheet.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/profile%20screens/verify%20account%20screens/verify_bloc.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/profile%20screens/verify%20account%20screens/verify_event.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/profile%20screens/verify%20account%20screens/verify_state.dart';

class VerifyAccount extends StatelessWidget {
  final UserRepository userRepository;

  const VerifyAccount({Key? key, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyBloc(userRepository),
      child: VerifyAccountScreen(),
    );
  }
}

class VerifyAccountScreen extends StatefulWidget {
  const VerifyAccountScreen({Key? key}) : super(key: key);

  @override
  _VerifyAccountScreenState createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  IdProofType? idProof;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('Verify your account'),
      body: BlocConsumer<VerifyBloc, VerifyState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          initData();
          return Container(
            padding: kMargin16,
            child: Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                MmmButtons.idproofButton(
                    '',
                    this.idProof != null
                        ? describeEnum(idProof!)
                        : 'Select your ID Proof',
                    'Select your ID Proof',
                    'images/rightArrow.svg', action: () {
                  selectIdProofBottomSheet(context);
                }),
                SizedBox(
                  height: 44,
                ),
                Container(
                  height: 224,
                  width: double.infinity,
                  //alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kWhite,
                      boxShadow: [MmmShadow.elevation2()]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('images/filter.svg'),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Click to upload your document',
                        style: MmmTextStyles.bodySmall(textColor: gray3),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                MmmButtons.enabledRedButtonbodyMedium(50, 'Verify',
                    action: () {})
              ],
            ),
          );
        },
      ),
    );
  }

  void selectIdProofBottomSheet(BuildContext context) async {
    var result = await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => IdproofBottomSheet(
              selectedIdProof: idProof,
            ));

    if (result != null && result is IdProofType) {
      BlocProvider.of<VerifyBloc>(context).add(OnSelectIdProof(result));
    }
  }

  void initData() {
    this.idProof = BlocProvider.of<VerifyBloc>(context).idProof;
  }
}
