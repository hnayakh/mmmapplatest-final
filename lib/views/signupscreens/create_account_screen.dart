import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_field.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class CreateAccount extends StatefulWidget {
  CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final profileController = TextEditingController();

  final emailController = TextEditingController();
  late bool val;

  int value1 = 1;
  int value2 = 2;
  int value3 = 3;
  int group = 0;

  var phoneController;

  String currentText = '';

  TextEditingController passwordController = TextEditingController();

  bool checkboxvalue = false;
  Color clr = kModalPrimary;
  List<String> profiles = ['Self', 'Son', 'Daughter', 'Sister', 'Brother'];

  late int profile;

  String profiletext = 'Select profile created for';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: Container(
          child: AppBar(
            toolbarHeight: 0.0,
            //title: Text(widget.title),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [kPrimary, kSecondary],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight),
          ),
        ),
        //preferredSize: Size(MediaQuery.of(context).size.width, 0.0),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            topBar(context),
            Expanded(
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
                            style: MmmTextStyles.bodySmall(textColor: kDark5),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            '*',
                            style: MmmTextStyles.bodySmall(textColor: kredStar),
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
                    'Email', 'Enter email id', emailController),
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
                                activeColor: Colors.pinkAccent,
                                value: value1,
                                groupValue: group,
                                onChanged: (val) {
                                  setState(() {
                                    value1 = group;
                                    value2 = 2;
                                    value3 = 3;
                                  });
                                }),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Male',
                            style: MmmTextStyles.bodySmall(textColor: kDark5),
                          ),
                          SizedBox(
                            width: 22,
                          ),
                          Transform.scale(
                            scale: 1.2,
                            child: Radio(
                                activeColor: Colors.pinkAccent,
                                value: value2,
                                groupValue: group,
                                onChanged: (val) {
                                  setState(() {
                                    value2 = group;
                                    value1 = 1;
                                    value3 = 3;
                                  });
                                }),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Female',
                            style: MmmTextStyles.bodySmall(textColor: kDark5),
                          ),
                          SizedBox(
                            width: 22,
                          ),
                          Transform.scale(
                            scale: 1.2,
                            child: Radio(
                                activeColor: kPrimary,
                                value: value3,
                                groupValue: group,
                                onChanged: (val) {
                                  setState(() {
                                    value3 = group;
                                    value1 = 1;
                                    value2 = 2;
                                  });
                                }),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Others',
                            style: MmmTextStyles.bodySmall(textColor: kDark5),
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
                    height: 46,
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
                              horizontal: 20, vertical: 10),
                          hintText: '   Phone Number',
                          isDense: true,
                          filled: true,
                          fillColor: kLight4,
                          hintStyle:
                              MmmTextStyles.bodyRegular(textColor: kDark2),
                          prefixIcon: Container(
                            height: 26,
                            width: 85,
                            margin: EdgeInsets.only(left: 16),
                            child: Row(
                              //mainAxisSize: MainAxisSize.min,
                              //mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  'images/flags/in.svg',
                                  height: 16,
                                  width: 22,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  '+91',
                                  style: MmmTextStyles.bodyRegular(
                                      textColor: kDark5),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Material(
                                  child: InkWell(
                                    // onTap: () => showModalBottomSheet(
                                    //     shape: RoundedRectangleBorder(
                                    //         borderRadius: BorderRadius.vertical(
                                    //             top: Radius.circular(16))),
                                    //     context: context,
                                    //     builder: (context) => buildSheet()),
                                    child: Container(
                                        height: 16,
                                        width: 16,
                                        color: kLight4,
                                        child: SvgPicture.asset(
                                          'images/Chevron_Down.svg',
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          )),
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
                        value: checkboxvalue,
                        activeColor: kPrimary,
                        onChanged: (bool? value) {
                          setState(() {
                            checkboxvalue = value!;
                          });
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
            checkboxvalue
                ? MmmButtons.enabledRedButtonbodyMedium(45, 'Sign up')
                : MmmButtons.disabledGreyButton(45, 'Sign up')
          ],
        ),
      )),
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
          onTap: () => showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16))),
              context: context,
              builder: (context) => Container(
                    padding: kMargin16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MmmButtons.backButton(context),
                        SizedBox(
                          height: 32,
                        ),
                        Text(
                          '   Select profile created for:',
                          style: MmmTextStyles.bodyMedium(textColor: kDark5),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12, right: 12),
                          decoration: BoxDecoration(
                              border: Border.all(width: 0.5, color: kLight4)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          //height: 210,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemExtent: 42,
                            itemBuilder: (context, index) {
                              return ListTile(
                                dense: true,
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(profiles[index],
                                        style: MmmTextStyles.bodyMediumSmall(
                                            textColor: profile == index
                                                ? kPrimary
                                                : clr)),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.5, color: kLight4)),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  setState(() {
                                    profile = index;
                                    profiletext = profiles[index];
                                  });
                                },
                              );
                            },
                            itemCount: 5,
                          ),
                        )
                      ],
                    ),
                  )),
          child: Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Container(
                width: 205,
                child: Text(
                  profiletext,
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.start,
                  style: profiletext == 'Select profile created for'
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
                color: Color(0xff878D96),
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
}

Widget buildProfileSheet() {
  Color clr = kModalPrimary;
  List<String> profiles = ['Self', 'Son', 'Daughter', 'Sister', 'Brother'];
  return Container(
    padding: kMargin16,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // MmmButtons.backButton(context),
        SizedBox(
          height: 32,
        ),
        Text(
          '   Select profile created for :',
          style: MmmTextStyles.bodyMedium(textColor: kDark5),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          margin: EdgeInsets.only(left: 12, right: 12),
          decoration:
              BoxDecoration(border: Border.all(width: 0.5, color: kLight4)),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          //height: 210,
          child: ListView.builder(
            shrinkWrap: true,
            itemExtent: 42,

            itemBuilder: (context, index) {
              return ListTile(
                dense: true,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(profiles[index],
                        style: MmmTextStyles.bodyMediumSmall(textColor: clr)),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: kLight4)),
                    ),
                  ],
                ),
                onTap: () {},
              );
            },
            itemCount: 5,
            //separatorBuilder: (BuildContext context, int index) {
            //return Divider();}
          ),
        )
      ],
    ),
  );
}

Widget buildSigninSheet() {
  return Container(
    padding: kMargin16,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 8,
        ),
        // MmmButtons.backButton(context),
        SizedBox(
          height: 24,
        ),
        MmmButtons.facebookSignupButton(),
        SizedBox(
          height: 16,
        ),
        MmmButtons.googleSignupButton(),
        SizedBox(
          height: 16,
        ),
        MmmButtons.emailButton(),
        SizedBox(
          height: 18,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text('Already have an account?',
                    textScaleFactor: 1.0,
                    style: MmmTextStyles.bodySmall(textColor: kDark5)),
              ),
              InkWell(
                onTap: () {},
                child: GradientText(
                  ' Signin',
                  style: MmmTextStyles.bodyMedium(),
                  colors: [kPrimary, kSecondary],
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
