import 'package:flutter/material.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({Key key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String currentTextnew = 'new';

  var newcontroller = TextEditingController();

  String currentTextconfirm = 'confirm';

  var confirmcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Container(
          padding: kMargin16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 13,
              ),
              MmmButtons.backButton(),
              SizedBox(
                height: 26,
              ),
              Text(
                "Reset Password",
                style: MmmTextStyles.heading2(textColor: kDark5),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'Enter your new password and the confirm\npassword which you want to use.',
                style: MmmTextStyles.bodySmall(textColor: gray3),
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Text(
                            'New Password',
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
                    Container(
                      height: 50,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            currentTextnew = value;
                          });
                        },
                        controller: newcontroller,
                        style: MmmTextStyles.bodyRegular(textColor: kDark5),
                        cursorColor: kDark5,
                        obscureText: true,
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
                                horizontal: 20, vertical: 14),
                            hintText: 'Enter new password',
                            isDense: true,
                            filled: true,
                            fillColor: kLight4,
                            hintStyle:
                                MmmTextStyles.bodyRegular(textColor: kDark2)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Text(
                            'Confirm Password',
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
                    Container(
                      height: 50,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            currentTextconfirm = value;
                          });
                        },
                        controller: confirmcontroller,
                        style: MmmTextStyles.bodyRegular(textColor: kDark5),
                        cursorColor: kDark5,
                        obscureText: true,
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
                                horizontal: 20, vertical: 14),
                            hintText: 'Confirm new password',
                            isDense: true,
                            filled: true,
                            fillColor: kLight4,
                            hintStyle:
                                MmmTextStyles.bodyRegular(textColor: kDark2)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 44,
              ),
              currentTextnew == currentTextconfirm
                  ? MmmButtons.enabledRedButtonbodyMedium(50, 'Reset Password')
                  : MmmButtons.disabledGreyButton(50, 'Reset Password')
            ],
          ),
        ),
      ),
    );
  }
}
