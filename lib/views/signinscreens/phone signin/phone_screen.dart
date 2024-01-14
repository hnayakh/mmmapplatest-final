import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/signinscreens/phone%20signin/phone_bloc.dart';
import 'package:makemymarry/views/signinscreens/phone%20signin/phone_event.dart';
import 'package:makemymarry/views/signinscreens/phone%20signin/phone_state.dart';
import 'package:makemymarry/views/signupscreens/create_account/create_account_screen.dart';

import '../mobile verification/mobile_verification.dart';

class SigninWithPhone extends StatelessWidget {
  final UserRepository userRepository;

  const SigninWithPhone({Key? key, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneSigninBloc(userRepository),
      child: SigninWithPhoneScreen(),
    );
  }
}

class SigninWithPhoneScreen extends StatefulWidget {
  const SigninWithPhoneScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SigninWithPhoneScreenState();
}

class _SigninWithPhoneScreenState extends State<SigninWithPhoneScreen> {
  final phoneController = TextEditingController();
  String dialCode = '+91';
  String currentText = '';
  late Country selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MmmButtons.appbarThin(),
      body: BlocConsumer<PhoneSigninBloc, PhoneSigninState>(
        listener: (context, state) {
          if (state is MoveToMobileVerification) {
            navigateToOtp();
          }
          if (state is OnError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: kError,
            ));
          }
        },
        builder: (context, state) {
          this.selectedCountry =
              BlocProvider.of<PhoneSigninBloc>(context).selectedCountry;
          return Stack(
            children: [
              Container(
                padding: kMargin16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Sign in to find your\nperfect partner',
                        style: MmmTextStyles.heading2(textColor: kDark5),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                        child: TextField(
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      style: MmmTextStyles.bodyRegular(textColor: kDark5),
                      cursorColor: kDark5,
                      obscureText: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: kDark2, width: 1),
                              borderRadius: BorderRadius.circular(8)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide:
                                  BorderSide(color: kInputBorder, width: 1)),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          hintText: 'Phone Number',
                          isDense: true,
                          filled: true,
                          fillColor: kLight4,
                          hintStyle:
                              MmmTextStyles.bodyRegular(textColor: kDark2),
                          prefixIcon: countrySelector()),
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    currentText.length < 10
                        ? MmmButtons.disabledGreyButton(44, 'Send OTP')
                        : MmmButtons.enabledRedButton50bodyMedium('Send OTP',
                            action: () {
                            BlocProvider.of<PhoneSigninBloc>(context)
                                .add(GenerateOtp(phoneController.text.trim()));
                          }),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Container(
                              height: 1,
                              color: gray5,
                            )),
                        Expanded(
                          flex: 1,
                          child: Container(
                            // width: 27,
                            height: 22,
                            alignment: Alignment.center,
                            child: Text(
                              'OR',
                              textAlign: TextAlign.center,
                              style: MmmTextStyles.bodyMediumSmall(
                                  textColor: kDark2),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 4,
                            child: Container(
                              height: 1,
                              color: gray5,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 12, child: MmmButtons.facebookSigninButton()),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                              // width: 16,
                              ),
                        ),
                        Expanded(
                          flex: 12,
                          child: MmmButtons.googleSigninButton(
                            action: () async {
                              GoogleSignIn _googleSignIn = GoogleSignIn();
                              await _googleSignIn.signOut();
                              _googleSignIn.signIn().then((userData) {
                                Navigator.of(context)
                                    .pop(userData?.email ?? "");
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: MmmButtons.enabledRedButtonbodyMedium(
                          44, 'Connect via Email', action: () {
                        Navigator.of(context).pop();
                      }),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Don't have an account? ",
                              style:
                                  MmmTextStyles.bodySmall(textColor: kDark5)),
                          TextSpan(
                              text: "Signup",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print("tap");
                                  navigateToRegister();
                                },
                              style:
                                  MmmTextStyles.bodyMedium(textColor: kPrimary))
                        ]),
                        textScaleFactor: 1.0,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              state is OnLoading ? MmmWidgets.buildLoader(context) : Container()
            ],
          );
        },
      ),
    );
  }

  Widget countrySelector() {
    return InkWell(
      onTap: () {
        showCountryPicker(
            context: context,
            showPhoneCode: true,
            onSelect: (country) {
              BlocProvider.of<PhoneSigninBloc>(context)
                  .add(OnCountrySelected(country));
            });
      },
      child: Container(
        height: 26,
        width: 85,
        margin: EdgeInsets.only(left: 16),
        child: Row(
          //mainAxisSize: MainAxisSize.min,
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(AppHelper.countryCodeToEmoji(selectedCountry.countryCode)),
            SizedBox(
              width: 4,
            ),
            Text(
              selectedCountry.phoneCode,
              style: MmmTextStyles.bodyRegular(textColor: kDark5),
            ),
            SizedBox(
              width: 4,
            ),
            Material(
              child: Container(
                  height: 16,
                  width: 16,
                  color: kLight4,
                  child: SvgPicture.asset(
                    'images/Chevron_Down.svg',
                  )),
            ),
          ],
        ),
      ),
    );
  }

  navigateToRegister() {
    var userRepo = BlocProvider.of<PhoneSigninBloc>(context).userRepository;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CreateAccount(
              userRepository: userRepo,
              email: "",
            )));
  }

  void navigateToOtp() {
    var userRepo = getIt<UserRepository>();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MobileVerification(
          dialCode: selectedCountry.phoneCode,
          phone: phoneController.text.trim(),
          userRepository: userRepo,
          otpType: OtpType.Login,
        ),
      ),
    );
  }
}
