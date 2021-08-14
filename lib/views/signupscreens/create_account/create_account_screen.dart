import 'package:country_picker/country_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_field.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/signupscreens/create_account/create_account_bloc.dart';
import 'package:makemymarry/views/signupscreens/create_account/create_account_event.dart';
import 'package:makemymarry/views/signupscreens/create_account/profile_create_for_bottom_sheet.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'create_account_state.dart';

class CreateAccount extends StatelessWidget {
  final UserRepository userRepository;

  const CreateAccount({Key? key, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateAccountBloc(userRepository),
      child: CreateAccountScreen(),
    );
  }
}

class CreateAccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateAccountScreenState();
  }
}

class CreateAccountScreenState extends State<CreateAccountScreen> {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  late Gender gender;
  late Country selectedCountry;
  late bool acceptTerms;

  late Relationship profileCreatedFor;

  String hintText = 'Select profile created for';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appbarThin(),
      body: BlocConsumer<CreateAccountBloc, CreateAccountState>(
        builder: (context, state) {
          intiData();
          return SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                topBar(context),
                Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Let's create an \naccount for you",
                      textAlign: TextAlign.start,
                      style: MmmTextStyles.heading2(textColor: kDark5),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Column(
                      children: [
                        Container(
                          //padding: const EdgeInsets.only(top: 4, left: 4),
                          child: Row(
                            children: [
                              Text(
                                'Profile created for',
                                textScaleFactor: 1.0,
                                style:
                                    MmmTextStyles.bodySmall(textColor: kDark5),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                '*',
                                style: MmmTextStyles.bodySmall(
                                    textColor: kredStar),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        selectProfileFor(context)
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    MmmTextFileds.textFiledWithLabelStar(
                        'Email', 'Enter email id', emailController,
                        inputType: TextInputType.emailAddress),
                    SizedBox(
                      height: 24,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gender',
                          style: MmmTextStyles.bodyRegular(textColor: kDark5),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Transform.scale(
                                scale: 1.2,
                                child: Radio(
                                    activeColor: kPrimary,
                                    value: Gender.Male,
                                    groupValue: gender,
                                    onChanged: (val) {
                                      BlocProvider.of<CreateAccountBloc>(
                                              context)
                                          .add(OnGenderSelected(Gender.Male));
                                    }),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Male',
                                style:
                                    MmmTextStyles.bodySmall(textColor: kDark5),
                              ),
                              SizedBox(
                                width: 22,
                              ),
                              Transform.scale(
                                scale: 1.2,
                                child: Radio(
                                    activeColor: kPrimary,
                                    value: Gender.Female,
                                    groupValue: gender,
                                    onChanged: (val) {
                                      BlocProvider.of<CreateAccountBloc>(
                                              context)
                                          .add(OnGenderSelected(Gender.Female));
                                    }),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Female',
                                style:
                                    MmmTextStyles.bodySmall(textColor: kDark5),
                              ),
                              SizedBox(
                                width: 22,
                              ),
                              Transform.scale(
                                scale: 1.2,
                                child: Radio(
                                    activeColor: kPrimary,
                                    value: Gender.Other,
                                    groupValue: gender,
                                    onChanged: (val) {
                                      BlocProvider.of<CreateAccountBloc>(
                                              context)
                                          .add(OnGenderSelected(Gender.Other));
                                    }),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Others',
                                style:
                                    MmmTextStyles.bodySmall(textColor: kDark5),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                        height: 50,
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          style: MmmTextStyles.bodyRegular(textColor: kDark5),
                          cursorColor: kDark5,
                          obscureText: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: kDark2, width: 1),
                                  borderRadius: BorderRadius.circular(8)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                      color: kInputBorder, width: 1)),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                              hintText: '   Phone Number',
                              isDense: true,
                              filled: true,
                              fillColor: kLight4,
                              hintStyle:
                                  MmmTextStyles.bodyRegular(textColor: kDark2),
                              prefixIcon: countrySelector()),
                        )),
                    SizedBox(
                      height: 24,
                    ),
                    MmmTextFileds.textFiledWithLabelStar(
                        'Password', 'Enter password', passwordController),
                    SizedBox(
                      height: 24,
                    ),
                    MmmTextFileds.textFiledWithLabelStar('Confirm Password',
                        'Enter confirm password', emailController),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: 1.3,
                          child: Checkbox(
                            value: acceptTerms,
                            activeColor: kPrimary,
                            onChanged: (bool? value) {
                              BlocProvider.of<CreateAccountBloc>(context)
                                  .add(ChangeAcceptTerms(!acceptTerms));
                            },
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'By signing up, i agree to the',
                          style: MmmTextStyles.caption(textColor: kDark5),
                        ),
                        InkWell(
                          onTap: () {},
                          child: GradientText(
                            ' terms & conditions',
                            style: MmmTextStyles.captionBold(),
                            colors: [kPrimary, kSecondary],
                          ),
                        )
                      ],
                    ),
                  ],
                )),
                state is OnLoading
                    ? Container(
                        height: 50,
                        child: CircularProgressIndicator(),
                      )
                    : acceptTerms
                        ? MmmButtons.enabledRedButtonbodyMedium(50, 'Sign up',
                            action: () {
                            BlocProvider.of<CreateAccountBloc>(context).add(
                                OnSignupClicked(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                    confirmpasswordController.text.trim(),
                                    phoneController.text.trim()));
                          })
                        : MmmButtons.disabledGreyButton(50, 'Sign up'),
              ],
            ),
          ));
        },
        listener: (context, state) {},
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
              BlocProvider.of<CreateAccountBloc>(context)
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

  Container selectProfileFor(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: kLight4,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: kDark2),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            showProfileForBottomSheet();
          },
          child: Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Container(
                width: 205,
                child: Text(
                  hintText,
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.start,
                  style: hintText == 'Select profile created for'
                      ? MmmTextStyles.bodyRegular(textColor: kDark2)
                      : MmmTextStyles.bodyRegular(textColor: kDark5),
                ),
              ),
              SizedBox(
                width: 120,
              ),
              SvgPicture.asset(
                "images/rightArrow.svg",
                width: 24,
                height: 24,
                color: kDark2,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row topBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MmmButtons.backButton(context),
        Container(
          //margin: EdgeInsets.only(left: 15),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: GradientText(
                'Sign in?',
                style: MmmTextStyles.bodySmall(),
                colors: [kPrimary, kSecondary],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showProfileForBottomSheet() async {
    var result = await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => ProfileCreateForBottomSheet(
              selectedRelation: profileCreatedFor,
            ));

    if (result != null && result is Relationship) {
      this.hintText = describeEnum(result);
      BlocProvider.of<CreateAccountBloc>(context)
          .add(OnProfileCreatedForSelected(result));
    }
  }

  void intiData() {
    this.gender = BlocProvider.of<CreateAccountBloc>(context).gender;
    this.profileCreatedFor =
        BlocProvider.of<CreateAccountBloc>(context).profileCreatedFor;
    this.selectedCountry =
        BlocProvider.of<CreateAccountBloc>(context).selectedCountry;
    this.acceptTerms = BlocProvider.of<CreateAccountBloc>(context).acceptTerms;
  }
}
