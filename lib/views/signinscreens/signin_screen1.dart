import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/bloc/sign_in/signin_bloc.dart';
import 'package:makemymarry/bloc/sign_in/signin_event.dart';
import 'package:makemymarry/bloc/sign_in/signin_state.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/storage_service.dart';
import 'package:makemymarry/utils/text_field.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/forgotpasswordscreens/forgot_password.dart';
import 'package:makemymarry/views/home/home.dart';
import 'package:makemymarry/views/home/matching_profile/matching_profile_bloc.dart';
import 'package:makemymarry/views/profile_loader/profile_loader.dart';
import 'package:makemymarry/views/profile_loader/profile_loader_bloc.dart';
import 'package:makemymarry/views/profilescreens/about/about.dart';
import 'package:makemymarry/views/profilescreens/bio/bio.dart';
import 'package:makemymarry/views/profilescreens/family/family.dart';
import 'package:makemymarry/views/profilescreens/habbit/habits.dart';
import 'package:makemymarry/views/profilescreens/occupation/occupation.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/profile_preference.dart';
import 'package:makemymarry/views/profilescreens/religion/religion.dart';
import 'package:makemymarry/views/signinscreens/phone%20signin/phone_screen.dart';
import 'package:makemymarry/views/signupscreens/create_account/create_account_screen.dart';
import 'package:makemymarry/views/signupscreens/create_account/signup_option_bottom_sheet.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SignIn extends StatelessWidget {
  final UserRepository userRepository;

  const SignIn({
    Key? key,
    required this.userRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(userRepository),
      child: SignInScreen(),
    );
  }
}

class SignInScreen extends StatefulWidget {
  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String _hint = 'Enter your email';
  String _hint2 = 'Enter your password';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: MmmButtons.appbarThin(),
        body: BlocConsumer<SignInBloc, SigninState>(
          builder: (context, state) {
            return SafeArea(
                child: Stack(
              children: [
                Container(
                  padding: kMargin16,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                            child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                child: Text(
                                  'Sign in to find your\nperfect partner',
                                  style:
                                      MmmTextStyles.heading2(textColor: kDark5),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    MmmTextFileds.textFiledWithLabel(
                                      "Email",
                                      _hint,
                                      emailController,
                                      inputType: TextInputType.emailAddress,
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    MmmTextFileds.textFiledWithLabel(
                                        "Password", _hint2, passwordController,
                                        inputType: TextInputType.emailAddress,
                                        isPassword: true),
                                    SizedBox(
                                      height: 24,
                                    ),
                                    Container(
                                        //padding: kMargin4,
                                        child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            navigateToForgotPassword();
                                          },
                                          child: GradientText(
                                            'Forgot password?',
                                            style: MmmTextStyles.bodySmall(),
                                            colors: [kPrimary, kSecondary],
                                          ),
                                        )
                                      ],
                                    )),
                                    SizedBox(
                                      height: 24,
                                    ),
                                    Container(
                                        child: MmmButtons
                                            .enabledRedButtonbodyMedium(
                                                44, 'Sign In', action: () {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      BlocProvider.of<SignInBloc>(context)
                                          .add(ValidateAndSignin(
                                        emailController.text.trim(),
                                        passwordController.text.trim(),
                                      ));
                                    })),
                                    SizedBox(
                                      height: 24,
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
                                              style:
                                                  MmmTextStyles.bodyMediumSmall(
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
                                      height: 24,
                                    ),
                                    Container(
                                      child: MmmButtons
                                          .enabledRedButton50bodyMedium(
                                              'Connect via OTP', action: () {
                                        navigateToSigninWithMobile();
                                      }),
                                    ),
                                    SizedBox(
                                      height: 24,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 12,
                                            child: MmmButtons
                                                .facebookSigninButton()),
                                        Expanded(
                                          flex: 1,
                                          child: SizedBox(
                                              // width: 16,
                                              ),
                                        ),
                                        Expanded(
                                            flex: 12,
                                            child:
                                                MmmButtons.googleSigninButton())
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                        Container(
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "Don't have an account? ",
                                  style: MmmTextStyles.bodySmall(
                                      textColor: kDark5)),
                              TextSpan(
                                  text: "Signup",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      print("tap");
                                      showSigninOptions(context);
                                      //navigateToRegister();
                                    },
                                  style: MmmTextStyles.bodyMedium(
                                      textColor: kPrimary))
                            ]),
                            textScaleFactor: 1.0,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ]),
                ),
                state is OnLoading
                    ? MmmWidgets.buildLoader2(context)
                    : Container()
              ],
            ));
          },
          listener: (context, state) {
            if (state is OnSignIn) {
              //TODO condition on profile activation status
              navigateToProfileSetup();
            }
            if (state is OnError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
                backgroundColor: kError,
              ));
            }
            if (state is OnValidationFail) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
                backgroundColor: kError,
              ));
            }
          },
        ),
      ),
    );
  }

  // void navigateToHome(
  //     List<MatchingProfile> list, List<MatchingProfile> seachList) {
  //   var userRepo = BlocProvider.of<ProfileLoaderBloc>(context).userRepository;
  //   Navigator.of(context).push(
  //       MaterialPageRoute(
  //           builder: (context) => HomeScreen(
  //               userRepository: userRepo, list: list, searchList: seachList)),
  //   )
  // }
  // void navigateToHome(
  //     List<MatchingProfile> list, List<MatchingProfile> seachList) {
  //   print("Home");
  //   var userRepo = BlocProvider.of<SignInBloc>(context).userRepository;
  //   Navigator.of(context).push(MaterialPageRoute(
  //       builder: (context) => HomeScreen(
  //           userRepository: userRepo, list: list, searchList: seachList)));
  // }

  // void navigateToHome() {
  //   var userRepo = BlocProvider.of<SignInBloc>(context).userRepository;
  //   Navigator.of(context).push(MaterialPageRoute(
  //       builder: (context) => HomeScreen(
  //             userRepository: userRepo,
  //              list: list, searchList: seachList
  //           )));
  // }
  void navigateToForgotPassword() {
    var userRepo = BlocProvider.of<SignInBloc>(context).userRepository;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ForgotPassword(
              userRepository: userRepo,
            )));
  }

  void navigateToSigninWithMobile() {
    var userRepo = BlocProvider.of<SignInBloc>(context).userRepository;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SigninWithPhone(
              userRepository: userRepo,
            )));
  }

  void showSigninOptions(BuildContext context) async {
    showModalBottomSheet(
        context: context, builder: (context) => SignupOptionBottomSheet());

    // var result = await showModalBottomSheet(
    //     context: context,
    //     backgroundColor: Colors.transparent,
    //     isScrollControlled: true,
    //     builder: (context) => DrinkStatusFilterSheet(
    //           selectedDrinkStatus: drinkStatus,
    //         ));
    // if (result != null && result is SimpleMasterData) {
    //   BlocProvider.of<FilterBloc>(context)
    //       .add(OnReligionFilterSelected(result));
    //   this.initCaste = 0;
    // }
  }

  navigateToRegister() {
    var userRepo = BlocProvider.of<SignInBloc>(context).userRepository;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CreateAccount(
              userRepository: userRepo,
            )));
  }

  void navigateToProfileSetup() {
    var userRepo = BlocProvider.of<SignInBloc>(context).userRepository;

    // var userRegistrationStep = userRepo.getUserDetails();
    switch (userRepo.useDetails!.registrationStep) {
      case 10:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => ProfileLoader(userRepository: userRepo)),
            (route) => false);
        break;
      case 9:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => ProfilePreference(
                      userRepository: userRepo,
                    )),
            (route) => false);
        break;
      case 8:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => Bio(userRepository: userRepo)),
            (route) => false);
        break;
      case 7:
      case 6:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => FamilyScreen(userRepository: userRepo)),
            (route) => false);
        break;
      case 5:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => Occupations(userRepository: userRepo)),
            (route) => false);
        break;
      case 4:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => Religion(userRepository: userRepo)),
            (route) => false);
        break;
      case 3:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => Habit(userRepository: userRepo)),
            (route) => false);
        break;
      case 2:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => About(userRepository: userRepo)),
            (route) => false);
        break;
      default:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => SignIn(
                      userRepository: userRepo,
                    )),
            (route) => false);
        break;
    }
  }
}
