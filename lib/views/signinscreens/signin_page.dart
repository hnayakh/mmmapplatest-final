import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/views/signinscreens/signin_bloc.dart';
import 'package:makemymarry/views/signinscreens/signin_event.dart';
import 'package:makemymarry/views/signinscreens/signin_state.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_field.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/forgotpasswordscreens/forgot_password.dart';
import 'package:makemymarry/views/profile_loader/profile_loader.dart';
import 'package:makemymarry/views/profilescreens/about/about.dart';
import 'package:makemymarry/views/profilescreens/bio/bio.dart';
import 'package:makemymarry/views/profilescreens/family/family.dart';
import 'package:makemymarry/views/profilescreens/habbit/habits.dart';
import 'package:makemymarry/views/profilescreens/occupation/occupation.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/profile_preference.dart';
import 'package:makemymarry/views/profilescreens/religion/religion.dart';
import 'package:makemymarry/views/signinscreens/authentication_service.dart';
import 'package:makemymarry/views/signinscreens/phone%20signin/phone_screen.dart';
import 'package:makemymarry/views/signupscreens/create_account/create_account_screen.dart';
import 'package:makemymarry/views/signupscreens/create_account/signup_option_bottom_sheet.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:http/http.dart' as http;

final Dio dio = Dio();

// GoogleSignIn _googleSignIn = GoogleSignIn(
//   // Optional clientId
//   clientId:
//       '929893628278-2ocmjecpi60uj3phsto5ctb84a101iup.apps.googleusercontent.com',
//   scopes: <String>[
//     'email',
//     'https://www.googleapis.com/auth/contacts.readonly',
//   ],
// );

class SignInPage extends StatelessWidget {
  const SignInPage({
    Key? key,
  }) : super(key: key);


  static Route getRoute() => MaterialPageRoute(builder: (context) => SignInPage());
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(getIt<UserRepository>()),
      child: SignInScreen(),
    );
  }
}

class SignInScreen extends StatefulWidget {
  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  String currentText = "";
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String _hint2 = 'Enter your password';

  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  bool isProgressing = false;
  bool isLoggedIn = false;

  bool _isLoggedIn = false;
  GoogleSignInAccount? _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    initAuth();
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact(_currentUser!);
      }
    });
    _googleSignIn.signInSilently();
  }

  initAuth() async {
    setLoadingState();
    final bool isAuthenticated = await AuthService.instance.initAuth();
    if (isAuthenticated) {
      setAuthenticatedState();
    } else {
      setUnauthenticatedState();
    }
  }

  setAuthenticatedState() {
    setState(() {
      isProgressing = false;
      isLoggedIn = true;
    });
  }

  setUnauthenticatedState() {
    setState(() {
      isProgressing = false;
      isLoggedIn = false;
    });
  }

  Future<void> loginAction() async {
    setLoadingState();
    final authSuccess = await AuthService.instance.login();
    if (authSuccess) {
      setAuthenticatedState();
      navigateToProfileSetup();
    } else {
      setUnauthenticatedState();
    }
  }

  setLoadingState() {
    setState(() {
      isProgressing = true;
    });
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final Map<String, dynamic>? name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Widget _buildBody() {
    final GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          const Text('Signed in successfully.'),
          Text(_contactText),
          ElevatedButton(
            onPressed: _handleSignOut,
            child: const Text('SIGN OUT'),
          ),
          ElevatedButton(
            child: const Text('REFRESH'),
            onPressed: () => _handleGetContact(user),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('You are not currently signed in.'),
          ElevatedButton(
            onPressed: loginAction,
            child: const Text('SIGN IN'),
          ),
        ],
      );
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      //child: _buildBody(),
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
                                    //MmmTextFileds.textFiledWithLabel(
                                    //   "Email",
                                    //   _hint,
                                    //   emailController,
                                    //   inputType: TextInputType.emailAddress,
                                    // ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Text(
                                            'Email',
                                            textScaleFactor: 1.0,
                                            style: MmmTextStyles.bodySmall(
                                                textColor: kDark5),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      child: TextField(
                                        onChanged: (value) {
                                          setState(() {
                                            currentText = value;
                                          });
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        controller: emailController,
                                        style: MmmTextStyles.bodyRegular(
                                            textColor: kDark5),
                                        cursorColor: kDark5,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: kDark2, width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                borderSide: BorderSide(
                                                    color: kInputBorder,
                                                    width: 1)),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 14),
                                            hintText: 'Enter email id',
                                            isDense: true,
                                            filled: true,
                                            fillColor: kLight4,
                                            hintStyle:
                                                MmmTextStyles.bodyRegular(
                                                    textColor: kDark2)),
                                      ),
                                    ),

                                    //
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
                                        child: currentText.length < 8
                                            ? MmmButtons.disabledGreyButton(
                                                50, 'Sign in')
                                            : MmmButtons
                                                .enabledRedButtonbodyMedium(
                                                    44, 'Sign In', action: () {
                                                FocusScope.of(context)
                                                    .requestFocus(FocusNode());
                                                BlocProvider.of<SignInBloc>(
                                                        context)
                                                    .add(ValidateAndSignin(
                                                  emailController.text.trim(),
                                                  passwordController.text
                                                      .trim(),
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
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 10,
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
                                                MmmButtons.googleSigninButton(
                                              action: () async {
                                                await _googleSignIn.signOut();
                                                _googleSignIn
                                                    .signIn()
                                                    .then((userData) {
                                                  emailController.text =
                                                      userData?.email ?? "";
                                                  // setState(() {
                                                  //   _isLoggedIn = true;
                                                  //   _userObj = userData;
                                                  // });
                                                }).catchError((e) {
                                                  print(e);
                                                });
                                              },
                                            ))
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

  void navigateToSigninWithMobile() async {
    var userRepo = BlocProvider.of<SignInBloc>(context).userRepository;
    var res = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SigninWithPhone(
              userRepository: userRepo,
            )));
    if (res is String) {
      emailController.text = res;
    }
  }

  void showSigninOptions(BuildContext context) async {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (context) => SignupOptionBottomSheet());

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
              email: "",
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
      case 11:
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
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => Habit(userRepository: userRepo)),
            (route) => false);
        break;
      // case 6:
      //   break;
      case 5:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => FamilyScreen(userRepository: userRepo)),
            (route) => false);
        break;
      case 4:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => Occupations(userRepository: userRepo)),
            (route) => false);

        break;
      case 3:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => Religion(userRepository: userRepo)),
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
            MaterialPageRoute(builder: (context) => SignInPage()),
            (route) => false);
        break;
    }
  }
}
