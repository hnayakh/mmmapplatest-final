import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/bloc/sign_in/signin_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/signupscreens/create_account/create_account_screen.dart';

class SignupOption extends StatelessWidget {
  final UserRepository userRepository;

  const SignupOption({Key? key, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(userRepository),
      child: SignupOptionBottomSheet(),
    );
  }
}

class SignupOptionBottomSheet extends StatefulWidget {
  @override
  SignupOptionBottomSheetState createState() => SignupOptionBottomSheetState();
}

class SignupOptionBottomSheetState extends State<SignupOptionBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: kMargin16,
        height: 360,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MmmButtons.backButton(context),
            SizedBox(
              height: 26,
            ),
            MmmButtons.facebookSignupButton(
              action: () {
                print("Akash");
              },
            ),
            SizedBox(
              height: 26,
            ),
            MmmButtons.googleSignupButton(
              action: () {
                print("Jontyu");
              },
            ),
            SizedBox(
              height: 26,
            ),
            MmmButtons.emailButton(
              action: () {
                print("Sharma");
                navigateToRegister(context);
              },
            ),
            SizedBox(
              height: 26,
            ),
            Container(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Already have an account? ",
                      style: MmmTextStyles.bodySmall(textColor: kDark5)),
                  TextSpan(
                      text: "Sign in",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
                        },
                      style: MmmTextStyles.bodyMedium(textColor: kPrimary))
                ]),
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )
            // borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ));
  }

  navigateToRegister(context) {
    // var userRepo = BlocProvider.of<SignInBloc>(context).userRepository;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CreateAccount(
              userRepository: UserRepository(),
            )));
  }
}
