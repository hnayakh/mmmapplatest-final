import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/helper.dart';
import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/matching_percentage/matching_percentage_bloc.dart';
import 'package:makemymarry/views/matching_percentage/matching_percentage_state.dart';
import 'package:makemymarry/views/profilescreens/hobbies/hobby_details_view.dart';
import 'package:makemymarry/views/profilescreens/lifestyle/lifestyle_details_view.dart';

import '../datamodels/martching_profile.dart';
import '../locator.dart';
import '../repo/chat_repo.dart';
import '../views/meet/views/meet_form_view.dart';
import '../views/profile_detail_view/profile_view.dart';
import '../views/profile_detail_view/profile_view_bloc.dart';
import '../views/profile_detail_view/profile_view_event.dart';
import '../views/stackviewscreens/sidebar screens/my_profile/myprofile.dart';

class MmmButtons {
  static Widget walletApps(String title, String icon) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.only(top: 8),
      title: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: MmmTextStyles.heading6(textColor: kDark5)),
                SvgPicture.asset(icon)
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Divider(
              color: kLight4,
            ),
          ],
        ),
      ),
      onTap: () {
        print(title);
      },
    );
  }

  static Widget plusMinusButton(BuildContext context, String icon,
      {Function()? action}) {
    return Container(
      decoration: BoxDecoration(
        color: kLight2,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: action,
            child: Container(
              height: MediaQuery.of(context).size.width * 0.12,
              width: MediaQuery.of(context).size.width * 0.12,
              alignment: Alignment.center,
              child: SvgPicture.asset(
                icon,
                color: kPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget searchScreenButton(String title, {Function()? action}) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: action,
            child: Container(
              height: 62,
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              decoration: BoxDecoration(
                border: Border.symmetric(
                    horizontal: BorderSide(color: kBorder),
                    vertical: BorderSide.none),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: MmmTextStyles.bodyMedium(textColor: kDark5),
                  ),
                  Container(
                    child: SvgPicture.asset(
                      "images/rightArrow.svg",
                      color: Color(0xff878D96),
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            )));
  }

  static Widget smallprofilePicButton(String image, Function() action) {
    return InkWell(
      child: Container(
        width: 40,
        height: 40,
        padding: EdgeInsets.all(2),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.all(Radius.circular(5.85))),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.85)),
          child: Image.network(image,
              fit: BoxFit.cover,
              errorBuilder: (context, obj, str) =>
                  Container(color: Colors.grey, child: Icon(Icons.error))),
        ),
      ),
      onTap: action,
    );
  }

  static Container familyProfileViewButtons(
      FamilyAfluenceLevel familyAfluenceLevel,
      FamilyValues familyValues,
      FamilyType familyType,
      String city,
      String state,
      String country,
      FatherOccupation fatherOccupation,
      MotherOccupation motherOccupation,
      int noOfBrother,
      int brothersMarried,
      int noOfSister,
      int sistersMarried,
      {Function()? action}) {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        boxShadow: [MmmShadow.elevation1()],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xffF0EFF5),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action,
          child: Container(
            padding: EdgeInsets.all(9),
            child: Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "images/family.svg",
                      color: kPrimary,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Text(
                      "Family",
                      textScaleFactor: 1.0,
                      //textAlign: TextAlign.start,
                      style: MmmTextStyles.heading5(textColor: kPrimary),
                    ),
                    Expanded(
                      flex: 20,
                      child: SizedBox(),
                    ),
                    Container(
                      child: SvgPicture.asset(
                        "images/arrowUp.svg",
                        color: Color(0xff878D96),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  //margin: kMargin16,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        //  width: 84,
                        height: 46,
                        child: Stack(
                          children: <Widget>[
                            Text(
                              'Status',
                              textAlign: TextAlign.left,
                              style: TextStyle( fontFamily: 'MakeMyMarry', 
                                  color: Color.fromRGBO(135, 141, 150, 1),
                                  
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  height: 1.6666666666666667),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Text(
                                AppHelper.getStringFromEnum(
                                    familyAfluenceLevel),
                                textAlign: TextAlign.left,
                                style: TextStyle( fontFamily: 'MakeMyMarry', 
                                    color: Color.fromRGBO(18, 22, 25, 1),
                                    
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    height: 1.5714285714285714),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 46,
                        child: Stack(
                          children: <Widget>[
                            Text(
                              'Type',
                              textAlign: TextAlign.left,
                              style: TextStyle( fontFamily: 'MakeMyMarry', 
                                  color: Color.fromRGBO(135, 141, 150, 1),
                                  
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  height: 1.6666666666666667),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Text(
                                AppHelper.getStringFromEnum(familyType),
                                textAlign: TextAlign.left,
                                style: TextStyle( fontFamily: 'MakeMyMarry', 
                                    color: Color.fromRGBO(18, 22, 25, 1),
                                    
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    height: 1.5714285714285714),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 300,
                        height: 46,
                        child: Stack(
                          children: <Widget>[
                            Text(
                              'Values',
                              textAlign: TextAlign.left,
                              style: TextStyle( fontFamily: 'MakeMyMarry', 
                                  color: Color.fromRGBO(135, 141, 150, 1),
                                  
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  height: 1.6666666666666667),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Text(
                                AppHelper.getStringFromEnum(familyValues),
                                textAlign: TextAlign.left,
                                style: TextStyle( fontFamily: 'MakeMyMarry', 
                                    color: Color.fromRGBO(18, 22, 25, 1),
                                    
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    height: 1.5714285714285714),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if ((city + state + country).isNotEmpty) ...[
                        Container(
                            width: 300,
                            height: 46,
                            child: Stack(children: <Widget>[
                              Text(
                                'Location',
                                textAlign: TextAlign.left,
                                style: TextStyle( fontFamily: 'MakeMyMarry', 
                                    color: Color.fromRGBO(135, 141, 150, 1),
                                    
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    height: 1.6666666666666667),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Text(
                                  '$city, $state, $country',
                                  textAlign: TextAlign.left,
                                  style: TextStyle( fontFamily: 'MakeMyMarry', 
                                      color: Color.fromRGBO(18, 22, 25, 1),
                                      
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      height: 1.5714285714285714),
                                ),
                              ),
                            ])),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                      Container(
                        width: 300,
                        height: 46,
                        child: Stack(
                          children: <Widget>[
                            Text(
                              "Father's Occupation",
                              textAlign: TextAlign.left,
                              style: TextStyle( fontFamily: 'MakeMyMarry', 
                                  color: Color.fromRGBO(135, 141, 150, 1),
                                  
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  height: 1.6666666666666667),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Text(
                                AppHelper.getStringFromEnum(fatherOccupation),
                                textAlign: TextAlign.left,
                                style: TextStyle( fontFamily: 'MakeMyMarry', 
                                    color: Color.fromRGBO(18, 22, 25, 1),
                                    
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    height: 1.5714285714285714),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 300,
                        height: 46,
                        child: Stack(
                          children: <Widget>[
                            Text(
                              "Mother's Occupation",
                              textAlign: TextAlign.left,
                              style: TextStyle( fontFamily: 'MakeMyMarry', 
                                  color: Color.fromRGBO(135, 141, 150, 1),
                                  
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  height: 1.6666666666666667),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Text(
                                AppHelper.getStringFromEnum(motherOccupation),
                                textAlign: TextAlign.left,
                                style: TextStyle( fontFamily: 'MakeMyMarry', 
                                    color: Color.fromRGBO(18, 22, 25, 1),
                                    
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    height: 1.5714285714285714),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 300,
                        height: 46,
                        child: Stack(
                          children: <Widget>[
                            Text(
                              "No. of Brothers/Married",
                              textAlign: TextAlign.left,
                              style: TextStyle( fontFamily: 'MakeMyMarry', 
                                  color: Color.fromRGBO(135, 141, 150, 1),
                                  
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  height: 1.6666666666666667),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Text(
                                '$noOfBrother out of $brothersMarried Married',
                                textAlign: TextAlign.left,
                                style: TextStyle( fontFamily: 'MakeMyMarry', 
                                    color: Color.fromRGBO(18, 22, 25, 1),
                                    
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    height: 1.5714285714285714),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 300,
                        height: 46,
                        child: Stack(
                          children: <Widget>[
                            Text(
                              "No. of Sister's/Married",
                              textAlign: TextAlign.left,
                              style: TextStyle( fontFamily: 'MakeMyMarry', 
                                  color: Color.fromRGBO(135, 141, 150, 1),
                                  
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  height: 1.6666666666666667),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Text(
                                '$noOfSister out of $sistersMarried Married',
                                textAlign: TextAlign.left,
                                style: TextStyle( fontFamily: 'MakeMyMarry', 
                                    color: Color.fromRGBO(18, 22, 25, 1),
                                    
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    height: 1.5714285714285714),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Container aboutProfileViewButtons(String icon, String label,
      String about, MaritalStatus maritalStatus, AbilityStatus abilityStatus,
      {Function()? action}) {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        boxShadow: [MmmShadow.elevation1()],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xffF0EFF5),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action,
          child: Container(
            alignment: Alignment.center,
            // height: 264,
            padding: EdgeInsets.all(9),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      icon,
                      color: kPrimary,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Text(
                      label,
                      textScaleFactor: 1.0,
                      //textAlign: TextAlign.start,
                      style: MmmTextStyles.heading5(textColor: kPrimary),
                    ),
                    Expanded(
                      flex: 20,
                      child: SizedBox(),
                    ),
                    Container(
                      child: SvgPicture.asset(
                        "images/arrowUp.svg",
                        color: Color(0xff878D96),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  margin: kMargin16,
                  child: Column(
                    children: [
                      Text(
                        about,
                        style: MmmTextStyles.bodySmall(),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // Row(
                      //   children: [
                      //     Text('Marital Status: ',
                      //         style: MmmTextStyles.heading6()),
                      //     Text(describeEnum(maritalStatus),
                      //         style: MmmTextStyles.bodySmall()),
                      //   ],
                      // ),
                      // Row(
                      //   children: [
                      //     Text('Disability: ', style: MmmTextStyles.heading6()),
                      //     Text(describeEnum(abilityStatus),
                      //         style: MmmTextStyles.bodySmall()),
                      //   ],
                      // )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Container religionProfileView(String religion, String cast,
      String gothra, Manglik manglik, String motherTongue,
      {Function()? action}) {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        boxShadow: [MmmShadow.elevation1()],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xffF0EFF5),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action,
          child: Container(
            alignment: Alignment.center,
            // height: 264,
            padding: EdgeInsets.all(9),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "images/religion.svg",
                      color: kPrimary,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Text(
                      "Religion",
                      textScaleFactor: 1.0,
                      //textAlign: TextAlign.start,
                      style: MmmTextStyles.heading5(
                        textColor: kPrimary,
                      ),
                    ),
                    Expanded(
                      flex: 20,
                      child: SizedBox(),
                    ),
                    Container(
                      child: SvgPicture.asset(
                        "images/arrowUp.svg",
                        color: Color(0xff878D96),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Religion',
                          style: TextStyle( fontFamily: 'MakeMyMarry', 
                              color: Color.fromRGBO(135, 141, 150, 1),
                              
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              height: 1.6666666666666667)),
                      Text(
                        religion,
                        style: TextStyle( fontFamily: 'MakeMyMarry', 
                            color: Color.fromRGBO(18, 22, 25, 1),
                            
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            height: 1.5714285714285714),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      if (cast != "null" || cast.length == 0) ...[
                        Text('Caste',
                            style: TextStyle( fontFamily: 'MakeMyMarry', 
                                color: Color.fromRGBO(135, 141, 150, 1),
                                
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                height: 1.6666666666666667)),
                        Text(
                          cast,
                          style: TextStyle( fontFamily: 'MakeMyMarry', 
                              color: Color.fromRGBO(18, 22, 25, 1),
                              
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              height: 1.5714285714285714),
                        ),
                      ],
                      SizedBox(
                        height: 6,
                      ),
                      if (gothra != null && gothra.length == 0) ...[
                        Text('Gothra',
                            style: TextStyle( fontFamily: 'MakeMyMarry', 
                                color: Color.fromRGBO(135, 141, 150, 1),
                                
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                height: 1.6666666666666667)),
                        Text(
                          gothra,
                          style: TextStyle( fontFamily: 'MakeMyMarry', 
                              color: Color.fromRGBO(18, 22, 25, 1),
                              
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              height: 1.5714285714285714),
                        ),
                      ],
                      SizedBox(
                        height: 6,
                      ),
                      Text('Manglik',
                          style: TextStyle( fontFamily: 'MakeMyMarry', 
                              color: Color.fromRGBO(135, 141, 150, 1),
                              
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              height: 1.6666666666666667)),
                      Text(
                        describeEnum(manglik),
                        style: TextStyle( fontFamily: 'MakeMyMarry', 
                            color: Color.fromRGBO(18, 22, 25, 1),
                            
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            height: 1.5714285714285714),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text('Mother Tongue',
                          style: TextStyle( fontFamily: 'MakeMyMarry', 
                              color: Color.fromRGBO(135, 141, 150, 1),
                              
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              height: 1.6666666666666667)),
                      Text(
                        motherTongue,
                        style: TextStyle( fontFamily: 'MakeMyMarry', 
                            color: Color.fromRGBO(18, 22, 25, 1),
                            
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            height: 1.5714285714285714),
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Container carrerProfileView(
      //String employedin,
      String occupation,
      AnnualIncome annualIncome,
      String city,
      String state,
      String country,
      String highiestEducation,
      {Function()? action}) {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        boxShadow: [MmmShadow.elevation1()],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xffF0EFF5),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action,
          child: Container(
            alignment: Alignment.center,
            // height: 264,
            padding: EdgeInsets.all(9),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "images/education.svg",
                      color: kPrimary,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Text(
                      "Career & Education",
                      textScaleFactor: 1.0,

                      style: MmmTextStyles.heading5(textColor: kPrimary),
                    ),
                    Expanded(
                      flex: 20,
                      child: SizedBox(),
                    ),
                    Container(
                      child: SvgPicture.asset(
                        "images/arrowUp.svg",
                        color: Color(0xff878D96),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text('Occupation', style: TextStyle( fontFamily: 'MakeMyMarry', 
                          color: Color.fromRGBO(135, 141, 150, 1),
                          
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          height: 1.6666666666666667)),
                      Text(occupation, style: TextStyle( fontFamily: 'MakeMyMarry', 
                          color: Color.fromRGBO(18, 22, 25, 1),
                          
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          height: 1.5714285714285714),),
                      SizedBox(height: 6,),
                      Text('Annual Income',
                          style: TextStyle( fontFamily: 'MakeMyMarry', 
                              color: Color.fromRGBO(135, 141, 150, 1),
                              
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              height: 1.6666666666666667)),
                      Text(AppHelper.getStringFromEnum(annualIncome),
                          style: TextStyle( fontFamily: 'MakeMyMarry', 
                              color: Color.fromRGBO(18, 22, 25, 1),
                              
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              height: 1.5714285714285714),),
                      SizedBox(height: 6,),

                      Text('Job Location',
                          style:TextStyle( fontFamily: 'MakeMyMarry', 
                              color: Color.fromRGBO(135, 141, 150, 1),
                              
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              height: 1.6666666666666667)),
                      Text(
                        "$city${city.isNotEmpty ? "," : ""} $state,$country",
                        style:  TextStyle( fontFamily: 'MakeMyMarry', 
                            color: Color.fromRGBO(18, 22, 25, 1),
                            
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            height: 1.5714285714285714),
                        maxLines: 2,
                      ),
                      SizedBox(height: 6,),

                      Text('Highest Education',
                          style: TextStyle( fontFamily: 'MakeMyMarry', 
                              color: Color.fromRGBO(135, 141, 150, 1),
                              
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              height: 1.6666666666666667)),
                      Text(highiestEducation,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 10,
                          style:  TextStyle( fontFamily: 'MakeMyMarry', 
                              color: Color.fromRGBO(18, 22, 25, 1),
                              
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              height: 1.5714285714285714),)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Container interestsProfileViewButtons(
      BuildContext context,
      EatingHabit eatingHabit,
      DrinkingHabit drinkingHabit,
      SmokingHabit smokingHabit,
      {Function()? action}) {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        boxShadow: [MmmShadow.elevation1()],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xffF0EFF5),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action,
          child: Container(
            alignment: Alignment.center,
            //height: 264,
            padding: EdgeInsets.all(9),
            child: Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "images/occasionally.svg",
                      color: kPrimary,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Text(
                      "Habits",
                      textScaleFactor: 1.0,
                      //textAlign: TextAlign.start,
                      style: MmmTextStyles.heading5(textColor: kPrimary),
                    ),
                    Expanded(
                      flex: 20,
                      child: SizedBox(),
                    ),
                    Container(
                      child: SvgPicture.asset(
                        "images/arrowUp.svg",
                        color: Color(0xff878D96),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  margin: kMargin16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 250,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Eating',
                                  textAlign: TextAlign.left,
                                  style: TextStyle( fontFamily: 'MakeMyMarry', 
                                      color: Color.fromARGB(212, 0, 0, 0),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      height: 1.6666666666666667),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 8, 20, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(13, 255, 77, 110),
                                          offset: Offset(0, 4),
                                          blurRadius: 14)
                                    ],
                                    border: Border.all(
                                      color: Color.fromRGBO(193, 199, 205, 1),
                                      width: 1,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        describeEnum(eatingHabit) ==
                                                " Vegetarrian"
                                            ? 'images/Veg2.svg'
                                            : describeEnum(eatingHabit) ==
                                                    "Nonvegetarrian"
                                                ? 'images/non veg.svg'
                                                : describeEnum(eatingHabit) ==
                                                        "Eggitarrian"
                                                    ? 'images/egg.svg'
                                                    : "images/egg.svg",
                                        height: 28,
                                        width: 28,
                                      ),
                                      SizedBox(width: 8),
                                      Container(
                                        decoration: BoxDecoration(),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              AppHelper.getStringFromEnum(
                                                  eatingHabit),
                                              textAlign: TextAlign.left,
                                              style: TextStyle( fontFamily: 'MakeMyMarry', 
                                                  color: Color.fromRGBO(
                                                      18, 22, 25, 1),
                                                  
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  height: 1.625),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Smoking',
                              textAlign: TextAlign.left,
                              style: TextStyle( fontFamily: 'MakeMyMarry', 
                                  color: Color.fromARGB(212, 0, 0, 0),
                                  
                                  fontSize: 14,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1.6666666666666667),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 8, 20, 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(13, 255, 77, 110),
                                      offset: Offset(0, 4),
                                      blurRadius: 14)
                                ],
                                border: Border.all(
                                  color: Color.fromRGBO(193, 199, 205, 1),
                                  width: 1,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  SvgPicture.asset(
                                      describeEnum(smokingHabit) == "Smoker"
                                          ? 'images/smoke.svg'
                                          : describeEnum(smokingHabit) ==
                                                  "NonSmoker"
                                              ? 'images/smoke.svg'
                                              : describeEnum(smokingHabit) ==
                                                      "Occasionally"
                                                  ? 'images/cigarette.png'
                                                  : "images/download.png",
                                      height: 28,
                                      width: 28),
                                  SizedBox(width: 8),
                                  Container(
                                    decoration: BoxDecoration(),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          AppHelper.getStringFromEnum(
                                              smokingHabit),
                                          textAlign: TextAlign.left,
                                          style: TextStyle( fontFamily: 'MakeMyMarry', 
                                              color:
                                                  Color.fromRGBO(18, 22, 25, 1),
                                              
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              height: 1.625),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Alcoholic',
                              textAlign: TextAlign.left,
                              style: TextStyle( fontFamily: 'MakeMyMarry', 
                                  color: Color.fromARGB(212, 0, 0, 0),
                                  
                                  fontSize: 14,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1.6666666666666667),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 8, 20, 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(13, 255, 77, 110),
                                      offset: Offset(0, 4),
                                      blurRadius: 14)
                                ],
                                border: Border.all(
                                  color: Color.fromRGBO(193, 199, 205, 1),
                                  width: 1,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  SvgPicture.asset(
                                      describeEnum(drinkingHabit) == "Alcoholic"
                                          ? 'images/alcoholic.svg'
                                          : describeEnum(drinkingHabit) ==
                                                  "Nonalcoholic"
                                              ? 'images/non_alcoholic.svg'
                                              : describeEnum(drinkingHabit) ==
                                                      "Occasionally"
                                                  ? 'images/occasionally.svg'
                                                  : "images/occasionally.svg",
                                      height: 28,
                                      width: 28),
                                  SizedBox(width: 8),
                                  Container(
                                    decoration: BoxDecoration(),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          AppHelper.getStringFromEnum(
                                              drinkingHabit),
                                          textAlign: TextAlign.left,
                                          style: TextStyle( fontFamily: 'MakeMyMarry', 
                                              color:
                                                  Color.fromRGBO(18, 22, 25, 1),
                                              
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              height: 1.625),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Container hoobiesProfileViewButtons(
      BuildContext context, List<String>? hobbies,
      {Function()? action}) {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        boxShadow: [MmmShadow.elevation1()],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xffF0EFF5),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action,
          child: Container(
            alignment: Alignment.center,
            //height: 264,
            padding: EdgeInsets.all(9),
            child: Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "images/occasionally.svg",
                      color: kPrimary,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Text(
                      "Hobbies",
                      textScaleFactor: 1.0,
                      //textAlign: TextAlign.start,
                      style: MmmTextStyles.heading5(textColor: kPrimary),
                    ),
                    Expanded(
                      flex: 20,
                      child: SizedBox(),
                    ),
                    Container(
                      child: SvgPicture.asset(
                        "images/arrowUp.svg",
                        color: Color(0xff878D96),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  margin: kMargin16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (hobbies.isNotNullEmpty)
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width: 400,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   'Hobbies',
                              //   textAlign: TextAlign.left,
                              //   style: TextStyle( fontFamily: 'MakeMyMarry', 
                              //       color: Color.fromARGB(212, 0, 0, 0),
                              //       
                              //       fontSize: 14,
                              //       fontWeight: FontWeight.normal,
                              //       height: 1.6666666666666667),
                              // ),
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.start,
                                runAlignment: WrapAlignment.start,
                                alignment: WrapAlignment.start,
                                children: <Widget>[
                                  ...(hobbies
                                          ?.map(
                                            (e) => ProfileHobbyTile(
                                                hobby: HobbyType.values
                                                    .where((element) =>
                                                        element.name == e)
                                                    .first),
                                          )
                                          .toList() ??
                                      <Widget>[]),
                                ],
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Container lifestyleProfileViewButtons(
      BuildContext context, List<String>? lifeStyles,
      {Function()? action}) {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        boxShadow: [MmmShadow.elevation1()],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xffF0EFF5),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "images/lifestyle.svg",
                      color: kPrimary,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Text(
                      'LifeStyle',
                      textScaleFactor: 1.0,
                      //textAlign: TextAlign.start,
                      style: MmmTextStyles.heading5(textColor: kPrimary),
                    ),
                    Expanded(
                      flex: 20,
                      child: SizedBox(),
                    ),
                    Container(
                      child: SvgPicture.asset(
                        "images/arrowUp.svg",
                        color: Color(0xff878D96),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  width: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        runAlignment: WrapAlignment.start,
                        alignment: WrapAlignment.start,
                        children: <Widget>[
                          ...(lifeStyles
                                  ?.map(
                                    (e) => LifeStyleTile(
                                        lifestyle: LifeStyleType.values
                                            .where(
                                                (element) => element.name == e)
                                            .first),
                                  )
                                  .toList() ??
                              <Widget>[]),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Container profileViewButtons(String icon, String label,
      {Function()? action}) {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        boxShadow: [MmmShadow.elevation1()],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xffF0EFF5),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action,
          child: Container(
            alignment: Alignment.center,
            height: 60,
            padding: EdgeInsets.all(8),
            // width: 342,
            child: Row(
              children: [
                SvgPicture.asset(
                  icon,
                  color: kPrimary,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Text(
                  label,
                  textScaleFactor: 1.0,
                  //textAlign: TextAlign.start,
                  style: MmmTextStyles.heading5(textColor: kPrimary),
                ),
                Expanded(
                  flex: 20,
                  child: SizedBox(),
                ),
                Container(
                  child: SvgPicture.asset(
                    "images/rightArrow.svg",
                    color: Color(0xff878D96),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Container searchButtons(String icon, String label,
      {Function()? action}) {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        boxShadow: [MmmShadow.elevation1()],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xffF0EFF5),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: action,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
              alignment: Alignment.center,
              height: 60,
              //padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  SvgPicture.asset(
                    icon,
                    color: Color(0xff121619),
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(),
                  ),
                  Text(
                    label,
                    textScaleFactor: 1.0,
                    //textAlign: TextAlign.start,
                    style: MmmTextStyles.bodyRegular(textColor: kDark5),
                  ),
                  Expanded(
                    flex: 20,
                    child: SizedBox(),
                  ),
                  Container(
                    child: SvgPicture.asset(
                      "images/rightArrow.svg",
                      color: Color(0xff878D96),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget swapViewButton(BuildContext context, String icon,
      {Function()? action}) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                        onTap: action,
                        child: Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.height * 0.07,
                          decoration: BoxDecoration(
                            boxShadow: [MmmShadow.gridViewButton()],
                            color: gray5.withOpacity(0.4),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: Container(
                            // height: 21,
                            // width: 15,
                            child: SvgPicture.asset(
                              icon,
                              color: kDark5,
                              height: MediaQuery.of(context).size.height *
                                  0.07 *
                                  0.5,
                            ),
                          ),
                        ))))
          ],
        )
      ],
    );
  }

  static Widget showphotoButton(String pathPhoto, BuildContext context,
      {Function()? action}) {
    return Container(
      alignment: Alignment.center,
      height: 100,
      //width: 180,
      decoration: BoxDecoration(
          border: Border.all(color: kBio),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [MmmShadow.elevation3(shadowColor: kShadowColorForWhite)]),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              File(pathPhoto),
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,

              // width: 180,
              //height: 100,
            ),
          ),
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [kPrimary, kSecondary],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight),
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: action,
                    child: Container(
                      height: 20,
                      // width: 18,
                      //padding: EdgeInsets.fromLTRB(14, 13, 12, 13),
                      child: SvgPicture.asset(
                        "images/Cross.svg",
                        color: gray7,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget uploadPhotoButton({Function()? action}) {
    return Container(
      height: 100,
      // width: 180,
      decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [MmmShadow.elevation3(shadowColor: kShadowColorForWhite)]),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            child: InkWell(
              onTap: action,
              child: Container(
                decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1.5, color: kBioSecondary)),
                child: SvgPicture.asset(
                  'images/plus.svg',
                  color: kBioSecondary,
                  height: 24,
                  // width: 22.88,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget filterButtons(String hintText, {Function()? action}) {
    return Column(
      children: [
        Container(
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: kLight4),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: action,
              child: Container(
                padding: EdgeInsets.only(left: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        hintText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textScaleFactor: 1.0,
                        textAlign: TextAlign.start,
                        style: MmmTextStyles.bodyRegular(textColor: kDark5),
                      ),
                    ),
                    SvgPicture.asset(
                      'images/rightArrow.svg',
                      width: 24,
                      height: 24,
                      color: Color(0xff878D96),
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget myProfileButtons(String hintText, {Function()? action}) {
    return Column(
      children: [
        Container(
          height: 58,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: kLight4),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: action,
                child: Container(
                  padding: EdgeInsets.only(left: 22, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        hintText,
                        textScaleFactor: 1.0,
                        style: MmmTextStyles.bodyMedium(textColor: kDark5),
                      ),
                      SvgPicture.asset(
                        'images/rightArrow.svg',
                        width: 24,
                        height: 24,
                        color: Color(0xff878D96),
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget walletButtons(String hintText, {Function()? action}) {
    return Column(
      children: [
        Container(
          height: 66,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [kPrimary, kSecondary],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight) ,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              MmmShadow.filterButton(),
            ],
            //border: Border.all(width: 1, color: kLight4),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: action,
                child: Container(
                  padding: EdgeInsets.only(left: 22, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        hintText,
                        textScaleFactor: 1.0,
                        style: MmmTextStyles.bodyMedium(textColor: kWhite),
                      ),
                      SvgPicture.asset(
                        'images/rightArrow.svg',
                        width: 24,
                        height: 24,
                        color: kWhite,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget buyConnectsButton(String title, String amount,
      {Function()? action}) {
    return Column(
      children: [
        Container(
          height: 66,
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              MmmShadow.filterButton(),
            ],
            //border: Border.all(width: 1, color: kLight4),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: action,
                child: Container(
                  padding: EdgeInsets.only(left: 22, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        textScaleFactor: 1.0,
                        style: MmmTextStyles.bodyMedium(textColor: kDark5),
                      ),
                      Text(
                        amount,
                        style: MmmTextStyles.captionBold(textColor: kPrimary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget categoryButtonsNotRequired(
      String labelText, String hintText, String newhintText, String icon,
      {Function()? action,
      bool showCancel = false,
      Function()? cancelAction,
      bool required = true}) {
    return Column(
      children: [
        if (labelText.isNotNullEmpty)
          Row(
            children: [
              Text(
                labelText,
                textScaleFactor: 1.0,
                style: MmmTextStyles.bodySmall(textColor: kDark5),
              ),
              required
                  ? Text(
                      '',
                      style: MmmTextStyles.bodySmall(textColor: kredStar),
                    )
                  : Container()
            ],
          ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: kLight4,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: kDark2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: action,
                child: Container(
                  padding: EdgeInsets.only(left: 12, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          hintText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 1.0,
                          textAlign: TextAlign.start,
                          style: newhintText == hintText
                              ? MmmTextStyles.bodyRegular(textColor: kDark2)
                              : MmmTextStyles.bodyRegular(textColor: kDark5),
                        ),
                      ),
                      showCancel
                          ? InkWell(
                              onTap: cancelAction,
                              child: Container(
                                width: 24,
                                height: 24,
                                child: SvgPicture.asset(
                                  "images/Cross.svg",
                                  width: 24,
                                  height: 24,
                                  color: kPrimary,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : SvgPicture.asset(
                              icon,
                              width: 24,
                              height: 24,
                              color: Color(0xff878D96),
                              fit: BoxFit.cover,
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget categoryButtons(
      String labelText, String hintText, String newhintText, String icon,
      {Function()? action,
      bool showCancel = false,
      Function()? cancelAction,
      bool required = true}) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              labelText,
              textScaleFactor: 1.0,
              style: MmmTextStyles.bodySmall(textColor: kDark5),
            ),
            required
                ? Text(
                    ' *',
                    style: MmmTextStyles.bodySmall(textColor: kredStar),
                  )
                : Container()
          ],
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: kLight4,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: kDark2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: action,
                child: Container(
                  padding: EdgeInsets.only(left: 12, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          hintText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 1.0,
                          textAlign: TextAlign.start,
                          style: newhintText == hintText
                              ? MmmTextStyles.bodyRegular(textColor: kDark2)
                              : MmmTextStyles.bodyRegular(textColor: kDark5),
                        ),
                      ),
                      showCancel
                          ? InkWell(
                              onTap: cancelAction,
                              child: Container(
                                width: 24,
                                height: 24,
                                child: SvgPicture.asset(
                                  "images/Cross.svg",
                                  width: 24,
                                  height: 24,
                                  color: kPrimary,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : SvgPicture.asset(
                              icon,
                              width: 24,
                              height: 24,
                              color: Color(0xff878D96),
                              fit: BoxFit.cover,
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget idproofButton(
      String labelText, String hintText, String newhintText, String icon,
      {Function()? action}) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: kLight4),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: action,
            child: Container(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      hintText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.start,
                      style: newhintText == hintText
                          ? MmmTextStyles.bodyMedium(textColor: kDark2)
                          : MmmTextStyles.bodyMedium(textColor: kDark5),
                    ),
                  ),
                  SvgPicture.asset(
                    icon,
                    width: 24,
                    height: 24,
                    color: Color(0xff878D96),
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget categoryButton(String labelText, String hintText, String icon) {
    String newhintText = hintText;
    return Column(
      children: [
        Row(
          children: [
            Text(
              labelText,
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
        SizedBox(
          height: 4,
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: kLight4,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: kDark2),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //SizedBox(
                    //  width: 16,
                    // ),
                    Container(
                      //width: 216,
                      child: Text(
                        newhintText,
                        textScaleFactor: 1.0,
                        textAlign: TextAlign.start,
                        style: newhintText == hintText
                            ? MmmTextStyles.bodyRegular(textColor: kDark2)
                            : MmmTextStyles.bodyRegular(textColor: kDark5),
                      ),
                    ),
                    // SizedBox(
                    //width: 110,
                    //  ),
                    SvgPicture.asset(
                      icon,
                      width: 24,
                      height: 24,
                      color: Color(0xff878D96),
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget appBarCurvedProfile(
      String title,
      BuildContext context,
      String image,
      String uid,
      ProposalStatus? connectStatus,
      ProfileDetails profileDetails) {
    ValueNotifier<bool> isDialOpen = ValueNotifier(false);
    return PreferredSize(
      //preferredSize: Size.fromHeight(120),
      preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(32)),
              gradient: LinearGradient(
                  colors: [kPrimary, kSecondary],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight),
            ),
          ),
          AppBar(
            toolbarOpacity: 0,
            bottomOpacity: 0,
            leading: Row(
              children: [
                Container(
                  width: 35,
                  margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  decoration: BoxDecoration(
                      color: kLight2.withOpacity(0.60),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        MmmShadow.elevationbBackButton(
                            shadowColor: kShadowColorForWhite)
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          //if (context != null) {
                          Navigator.of(context).pop();
                          // }
                        },
                        child: Container(
                            height: 32,
                            width: 24,
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              'images/arrowLeft.svg',
                              height: 17.45,
                              color: gray3,
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            toolbarHeight: 74.0,
            title: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      color: Colors.transparent,
                    ),
                    CircleAvatar(
                      radius: 24,
                      child: ClipOval(
                        child: Image.network(image,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, obj, str) => Container(
                                color: Colors.grey, child: Icon(Icons.error))),
                      ),
                    ),
                    Positioned(
                      right: 2,
                      top: 2,
                      child: StreamBuilder<bool>(
                          stream: getIt<ChatRepo>().getOnlineStatus(uid),
                          builder: (context, snapshot) {
                            return Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: snapshot.data == null
                                      ? kGray
                                      : snapshot.data!
                                          ? kGreen
                                          : kError),
                            );
                          }),
                    )
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Expanded(
                    child: Text(
                  title,
                  maxLines: 1,
                  style: MmmTextStyles.heading4(textColor: kLight2),
                )),
              ],
            ),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0.0,
          ),

          if (connectStatus == ProposalStatus.Accepted &&
              profileDetails.gender.index !=
                  getIt<UserRepository>().useDetails?.gender) ...[
            Positioned(
              right: MediaQuery.of(context).size.width * 0.1,
              bottom: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ConnectWidget(
                    isDialOpen: isDialOpen,
                    profileDetails: profileDetails,
                    direction: SpeedDialDirection.down,
                  ),
                  SizedBox(width: 12),
                  MmmIcons.meet(
                    context,
                    action: () async {
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25)),
                        ),
                        context: context,
                        builder: (context) => MmmWidgets.selectMeetWidget(
                            context, profileDetails),
                      );
                    },
                  ),
                ],
              ),
            ),
          ] else if ((connectStatus == ProposalStatus.Reverted ||
                  connectStatus == ProposalStatus.Rejected ||
                  connectStatus == null) &&
              profileDetails.gender.index !=
                  getIt<UserRepository>().useDetails?.gender) ...[
            Positioned(
              right: MediaQuery.of(context).size.width * 0.1,
              bottom: 0,
              child: InkWell(
                  onTap: () {
                    BlocProvider.of<ProfileViewBloc>(context)
                        .add(SendLikeRequest());
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 48,
                        width: 48,
                        child: Center(
                          child: SvgPicture.asset(
                            "images/heart.svg",
                            color: Colors.white,
                            height: 24,
                            width: 24,
                          ),
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: MmmDecorations.primaryGradient(),
                            border:
                                Border.all(color: Colors.white, width: 1.2)),
                      ),
                      Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kPrimary.withAlpha(50),
                              border:
                                  Border.all(color: Colors.white, width: 1.2)))
                    ],
                  )),
            )
          ] else if (connectStatus == ProposalStatus.Sent &&
              profileDetails.gender.index !=
                  getIt<UserRepository>().useDetails?.gender) ...[
            Positioned(
              right: MediaQuery.of(context).size.width * 0.1,
              bottom: 0,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      BlocProvider.of<ProfileViewBloc>(context)
                          .add(CancelLikeRequest());
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 48,
                          width: 48,
                          child: Center(
                            child: SvgPicture.asset(
                              "images/cancel.svg",
                              color: Colors.white,
                              height: 24,
                              width: 24,
                            ),
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: MmmDecorations.primaryGradient(),
                              border:
                                  Border.all(color: Colors.white, width: 1.2)),
                        ),
                        Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: kPrimary.withAlpha(50),
                                border: Border.all(
                                    color: Colors.white, width: 1.2)))
                      ],
                    ),
                  ),
                  SizedBox(width: 6),
                  InkWell(
                    onTap: () {
                      BlocProvider.of<ProfileViewBloc>(context)
                          .add(MakeConnectRequest());
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 48,
                          width: 48,
                          child: Center(
                            child: SvgPicture.asset(
                              "images/chat.svg",
                              color: Colors.white,
                              height: 24,
                              width: 24,
                            ),
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: MmmDecorations.primaryGradient(),
                              border:
                                  Border.all(color: Colors.white, width: 1.2)),
                        ),
                        Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: kPrimary.withAlpha(50),
                                border: Border.all(
                                    color: Colors.white, width: 1.2)))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ] else if (profileDetails.proposalStatus == ProposalStatus.Received &&
              profileDetails.gender.index !=
                  getIt<UserRepository>().useDetails?.gender) ...[
            Positioned(
              right: MediaQuery.of(context).size.width * 0.1,
              bottom: 0,
              child: Row(
                children: [
                  MmmIcons.largeReject(
                    action: () {
                      BlocProvider.of<ProfileViewBloc>(context)
                          .add(RejectLikeRequest());
                    },
                  ),
                  SizedBox(width: 6),
                  MmmIcons.largeAccept(
                    action: () {
                      BlocProvider.of<ProfileViewBloc>(context)
                          .add(AcceptLikeRequest());
                    },
                  ),
                ],
              ),
            ),
          ],

          // Positioned(
          //     bottom: 0,
          //     //right: 80,
          //     right: MediaQuery.of(context).size.width * 0.2,
          //     child: Transform.scale(scale: 0.9, child: MmmIcons.cancel())),
          // Positioned(
          //     bottom: 0,
          //     right: MediaQuery.of(context).size.width * 0.06,
          //     child: Transform.scale(scale: 0.9, child: MmmIcons.meet(context)))
        ],
      ),
    );
  }

  static PreferredSize appBarCurvedFilter(String title,
      {BuildContext? context}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(74.0),
      child: Container(
        child: AppBar(
          leading: Container(
            margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
            decoration: BoxDecoration(
                color: kLight2.withOpacity(0.60),
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  MmmShadow.elevationbBackButton(
                      shadowColor: kShadowColorForWhite)
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    if (context != null) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                      height: 32,
                      width: 32,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'images/arrowLeft.svg',
                        height: 17.45,
                        width: 17.45,
                        color: gray3,
                      )),
                ),
              ),
            ),
          ),
          toolbarHeight: 74.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: MmmTextStyles.heading4(textColor: kLight2),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    'Reset',
                    style: MmmTextStyles.bodyMedium(textColor: kLight2),
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(32)),
          gradient: LinearGradient(
              colors: [kPrimary, kSecondary],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
        ),
      ),
      //preferredSize: Size(MediaQuery.of(context).size.width, 0.0),
    );
  }

  static PreferredSize appBarCurved(String title,
      {BuildContext? context, bool isTopLevel = false}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(74.0),
      child: Container(
        child: AppBar(
          leading: (context != null
                  ? ((navigatorKey.currentState?.canPop() ?? true) &&
                      Navigator.of(context).canPop())
                  : false)
              ? Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 0, 20),
                  decoration: BoxDecoration(
                    color: kLight2.withOpacity(0.60),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      MmmShadow.elevationbBackButton(
                        shadowColor: kShadowColorForWhite,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          var res = await Navigator.of(context).maybePop();
                          if (!res) {
                            SystemNavigator.pop();
                          }
                        },
                        child: Container(
                            height: 32,
                            width: 32,
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              'images/arrowLeft.svg',
                              height: 17.45,
                              width: 17.45,
                              color: gray3,
                            )),
                      ),
                    ),
                  ),
                )
              : null,
          toolbarHeight: 74.0,
          title: Text(
            title,
            style: MmmTextStyles.heading4(textColor: kLight2),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(32)),
          gradient: LinearGradient(
              colors: [kSecondary, kPrimary],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft),
          // gradient: LinearGradient(
          //     colors: [kPrimary, kSecondary],
          //     begin: Alignment.centerLeft,
          //     end: Alignment.centerRight),
        ),
      ),
      //preferredSize: Size(MediaQuery.of(context).size.width, 0.0),
    );
  }

  static PreferredSize appTabTitleBarCurved(String title,
      {BuildContext? context}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(74.0),
      child: Container(
        child: AppBar(
          toolbarHeight: 74.0,
          title: Text(
            title,
            style: MmmTextStyles.heading4(textColor: kLight2),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(32)),
            color: kSecondary
            // gradient: LinearGradient(
            //     colors: [kPrimary, kSecondary],
            //     begin: Alignment.centerLeft,
            //     end: Alignment.centerRight),
            ),
      ),
      //preferredSize: Size(MediaQuery.of(context).size.width, 0.0),
    );
  }

  static PreferredSize appBarAccountBar(
      String name, String image, ProfileActivationStatus status,
      {BuildContext? context}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(164.0),
      child: Container(
        child: AppBar(
          toolbarHeight: 164.0,
          title: Container(
            width: MediaQuery.of(context!).size.width,
            height: 164,
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(37),
                    child: Image.network(image,
                        height: 74,
                        fit: BoxFit.cover,
                        width: 74,
                        errorBuilder: (context, obj, str) => Container(
                            color: Colors.grey, child: Icon(Icons.error)))),
                SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: MmmTextStyles.heading4(textColor: kLight2),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    status == ProfileActivationStatus.Verified
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                'images/Verified.svg',
                                height: 20.51,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "Verified User",
                                style: MmmTextStyles.bodyRegular(
                                    textColor: kLight2),
                              ),
                            ],
                          )
                        : Container()
                  ],
                )
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(32)),
            color: kSecondary
            // gradient: LinearGradient(
            //     colors: [kPrimary, kSecondary],
            //     begin: Alignment.centerLeft,
            //     end: Alignment.centerRight),
            ),
      ),
      //preferredSize: Size(MediaQuery.of(context).size.width, 0.0),
    );
  }

  static Widget appBarCurvedReset(Function()? action, String title,
      {BuildContext? context}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(74.0),
      child: Container(
        child: AppBar(
          actions: [
            GestureDetector(
              onTap: action,
              child: Text('Reset'),
            )
          ],
          leading: Container(
            margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
            decoration: BoxDecoration(
                color: kLight2.withOpacity(0.60),
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  MmmShadow.elevationbBackButton(
                      shadowColor: kShadowColorForWhite)
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    if (context != null) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                      height: 32,
                      width: 32,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'images/arrowLeft.svg',
                        height: 17.45,
                        width: 17.45,
                        color: gray3,
                      )),
                ),
              ),
            ),
          ),
          toolbarHeight: 74.0,
          title: Text(
            title,
            style: MmmTextStyles.heading4(textColor: kLight2),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(32)),
          gradient: LinearGradient(
              colors: [kPrimary, kSecondary],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
        ),
      ),
      //preferredSize: Size(MediaQuery.of(context).size.width, 0.0),
    );
  }

  static PreferredSize appbarThin() {
    return PreferredSize(
      preferredSize: Size.fromHeight(0.0),
      child: Container(
        child: AppBar(
          toolbarHeight: 0.0,
          //title: Text(widget.title),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        decoration: BoxDecoration(
          gradient: MmmDecorations.primaryGradient(),
        ),
      ),
      //preferredSize: Size(MediaQuery.of(context).size.width, 0.0),
    );
  }

  static Widget cameraimportButton({Function()? action}) {
    return Container(
      height: 50,
      child: Container(
        decoration: MmmDecorations.primaryButtonDecoration(),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: action,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "images/camera.svg",
                    height: 24,
                    width: 24,
                    color: Color(0xffFCFCFD),
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Click via camera',
                      textAlign: TextAlign.center,
                      style: MmmTextStyles.heading5(textColor: gray7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget facebookImportbutton({Function()? action}) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffFCFCFD),
        border: Border.all(
          color: Color(0xff878D96),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action,
          child: Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Container(
                height: 24,
                width: 24,
                child: SvgPicture.asset(
                  "images/social/facebook.svg",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 26,
                width: 260,
                child: Text(
                  'Import from Facebook',
                  textAlign: TextAlign.center,
                  style: MmmTextStyles.heading5(textColor: kDark5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget importGalleryButton({Function()? action}) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffFCFCFD),
        border: Border.all(
          color: Color(0xff878D96),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action,
          child: Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Container(
                height: 24,
                width: 24,
                child: SvgPicture.asset(
                  "images/gallery.svg",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 26,
                width: 260,
                child: Text(
                  'Import from Gallery',
                  textAlign: TextAlign.center,
                  style: MmmTextStyles.heading5(textColor: kDark5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget profileSelectButton(
      double containerHeight, String text, Function ontap) {
    return Container(
      height: containerHeight,
      decoration: BoxDecoration(
        color: kLight4,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: kDark2),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => ontap,
          child: Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Container(
                child: Text(
                  text,
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.start,
                  style: MmmTextStyles.bodyRegular(textColor: kDark2),
                ),
              ),
              SizedBox(
                width: 130,
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

  static Widget primaryButtonMeetGray(String title, Function()? onTap) {
    return Container(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          width: 105,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(53, 61, 75, 92),
                  offset: Offset(0, 4),
                  blurRadius: 14)
            ],
            color: Color.fromRGBO(255, 255, 255, 1),
            border: Border.all(
              color: kGray,
              width: 1,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            textScaleFactor: 1.0,
            style: MmmTextStyles.heading6(textColor: gray3),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      // margin: kMargin32,
    );
  }

  static Widget primaryButtonMeet(String title, Function()? onTap) {
    return Container(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          width: 110,
          alignment: Alignment.center,
          child: Text(
            title,
            textScaleFactor: 1.0,
            style: MmmTextStyles.heading6(textColor: Colors.white),
            textAlign: TextAlign.center,
          ),
          decoration: MmmDecorations.primaryButtonDecoration(),
        ),
      ),
      //margin: kMargin32,
    );
  }

  static Widget primaryButton(String title, Function()? onTap) {
    return Container(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          alignment: Alignment.center,
          child: Text(
            title,
            textScaleFactor: 1.0,
            style: MmmTextStyles.heading6(textColor: Colors.white),
            textAlign: TextAlign.center,
          ),
          decoration: MmmDecorations.primaryButtonDecoration(),
        ),
      ),
      margin: kMargin24,
    );
  }

  static Container enabledRedButton328x50bodyMedium(String title) {
    return Container(
      // margin: kMargin24,

      decoration: MmmDecorations.primaryButtonDecoration(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            alignment: Alignment.center,
            height: 50,
            child: Text(
              title,
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
              style: MmmTextStyles.bodyMedium(textColor: gray7),
            ),
          ),
        ),
      ),
    );
  }

  static Container enabledRedButton328x50heading5(String text) {
    return Container(
      decoration: MmmDecorations.primaryButtonDecoration(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            alignment: Alignment.center,
            height: 50,
            width: 328,
            child: Text(
              text,
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
              style: MmmTextStyles.heading5(textColor: gray7),
            ),
          ),
        ),
      ),
    );
  }

  static Container enabledRedButton50bodyMedium(String text,
      {Function()? action}) {
    return Container(
      decoration: MmmDecorations.primaryButtonDecoration(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action,
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            alignment: Alignment.center,
            height: 44,
            child: Text(
              text,
              textAlign: TextAlign.center,
              textScaleFactor: 1.0,
              style: MmmTextStyles.bodyMedium(textColor: gray7),
            ),
          ),
        ),
      ),
    );
  }

  static Container enabledRedButtonbodyMedium(double height, String text,
      {Function()? action}) {
    return Container(
      decoration: MmmDecorations.primaryButtonDecoration(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: action,
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              alignment: Alignment.center,
              height: height,
              child: Text(
                text,
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
                style: MmmTextStyles.bodyMedium(textColor: gray7),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget checkMatchButtonModified(double height, String text,
      {Function()? action}) {
    return BlocBuilder<MatchingPercentageBloc, MatchingPercentageState>(
        builder: (context, state) {
      if (state is OnProfileVisited) {
        return Container(
          width: 380,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(61, 75, 92, 0.11999999731779099),
                  offset: Offset(0, 12),
                  blurRadius: 22)
            ],
            color: Color.fromRGBO(255, 255, 255, 1),
            border: Border.all(
              color: Color.fromRGBO(240, 239, 245, 1),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Match meter ${(state).matchingPercentage}%',
                      textAlign: TextAlign.center,
                      style: TextStyle( fontFamily: 'MakeMyMarry', 
                          
                          color: kPrimary,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          height: 1.625),
                    ),
                  ],
                ),
              ),
              CupertinoSlider(
                  value: (state as OnProfileVisited).matchingPercentage / 100,
                  onChanged: (value) {}),

              InkWell(
                onTap: action,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'View more',
                        textAlign: TextAlign.center,
                        style: TextStyle( fontFamily: 'MakeMyMarry',
                            color: Color.fromRGBO(201, 24, 74, 1),

                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            height: 1.5714285714285714),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(5, 7, 1, 1),
                          child: Image.asset('images/doublearrow.png'))
                    ],
                  ),
                ),
              ),

            ],
          ),
        );
      } else {
        return Container();
      }
    });
  }

  static Container checkMatchButton(double height, String text,
      {Function()? action}) {
    return Container(
      decoration: MmmDecorations.primaryButtonDecoration(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: action,
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              alignment: Alignment.center,
              height: height,
              child: Text(
                text,
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
                style: MmmTextStyles.heading5(textColor: gray7),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Container enabledRedButton280x42heading6(String text) {
    return Container(
      decoration: MmmDecorations.primaryButtonDecoration(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 6, 16, 6),
            alignment: Alignment.center,
            height: 42,
            width: 280,
            child: Text(
              text,
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
              style: MmmTextStyles.heading6(textColor: gray7),
            ),
          ),
        ),
      ),
    );
  }

  static Container disabledGreyButton(double containerHeight, String text,
      {Function()? action}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffDDE1E6),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action,
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            alignment: Alignment.center,
            height: containerHeight,
            child: Text(
              text,
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
              style: MmmTextStyles.bodyMedium(textColor: gray4),
            ),
          ),
        ),
      ),
    );
  }

  static Container expandedButtonWithIcon(String title, String icon) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: kLight2,
        border: Border.all(
          color: gray6,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 24,
                width: 24,
                child: SvgPicture.asset(
                  icon,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Text(
                title,
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
                style: MmmTextStyles.bodyMedium(textColor: kDark5),
              )),
            ],
          ),
        ),
      ),
    );
  }

  static Container facebookSigninButton() {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: kLight2,
        border: Border.all(
          color: gray6,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 24, width: 24, child: Image.asset('images/fb.png')
                  // SvgPicture.asset(
                  //   "images/social/facebook.svg",
                  //   fit: BoxFit.cover,
                  // ),
                  ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Facebook',
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
                style: MmmTextStyles.bodyMedium(textColor: kDark5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Container googleSigninButton({Function()? action}) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffFCFCFD),
        border: Border.all(
          color: Color(0xffF0EFF5),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 24,
                width: 24,
                child: SvgPicture.asset(
                  "images/social/google.svg",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Gmail',
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
                style: MmmTextStyles.bodyMedium(textColor: kDark5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // signup screen==============================================================

  static Container facebookSignupButton({Function()? action}) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffFCFCFD),
        border: Border.all(
          color: Color(0xff878D96),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action,
          child: Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Container(
                height: 24,
                width: 24,
                child: SvgPicture.asset(
                  "images/social/facebook.svg",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 26,
                width: 260,
                child: Text(
                  'Facebook',
                  textAlign: TextAlign.center,
                  style: MmmTextStyles.heading5(textColor: kDark5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Container instagramButton() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffFCFCFD),
        border: Border.all(
          color: Color(0xff878D96),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Container(
                height: 30,
                width: 30,
                child: Image.network(
                    "https://pbs.twimg.com/profile_images/1526231349354303489/3Bg-2ZsT_400x400.jpg",
                    fit: BoxFit.cover,
                    errorBuilder: (context, obj, str) => Container(
                        color: Colors.grey, child: Icon(Icons.error))),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 26,
                width: 260,
                child: Text(
                  'Instagram',
                  textAlign: TextAlign.center,
                  style: MmmTextStyles.heading5(textColor: kDark5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Container googleSignupButton({Function()? action}) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffFCFCFD),
        border: Border.all(
          color: Color(0xff878D96),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action,
          child: Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Container(
                height: 24,
                width: 24,
                child: SvgPicture.asset(
                  "images/social/google.svg",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 26,
                width: 260,
                child: Text(
                  'Gmail',
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.center,
                  style: MmmTextStyles.heading5(textColor: kDark5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Container emailButton({Function()? action}) {
    return Container(
      height: 50,
      child: Container(
        decoration: MmmDecorations.primaryButtonDecoration(),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: action,
            child: Center(
              child: Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  SvgPicture.asset(
                    "images/email.svg",
                    color: Color(0xffFCFCFD),
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 26,
                    width: 260,
                    child: Text(
                      'Email',
                      textAlign: TextAlign.center,
                      style: MmmTextStyles.heading5(textColor: gray7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //forgot password==========================================================
  static Container cancelButtonForgotPassword() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffFCFCFD),
        border: Border.all(
          color: Color(0xffDDE1E6),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              height: 42,
              width: 136,
              child: Text(
                'Cancel',
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
                style: MmmTextStyles.heading6(textColor: gray4),
              ),
            )),
      ),
    );
  }

  static Container confirmButtonForgotPassword() {
    return Container(
      decoration: MmmDecorations.primaryButtonDecoration(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            height: 42,
            width: 136,
            alignment: Alignment.center,
            child: Text(
              'Confirm',
              textAlign: TextAlign.center,
              textScaleFactor: 1.0,
              style: MmmTextStyles.heading6(textColor: gray7),
            ),
          ),
        ),
      ),
    );
  }

  //profile setup screen=====================================================
  static Container habitsEnabled(
      double containerheight, double containerwidth, String icon, String text) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffFF4D6D),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Color(0xffF0EFF5),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xffFF4D6D).withOpacity(0.24),
              blurRadius: 14.0,
              spreadRadius: 0.0,
              offset: Offset(0.0, 4.0),
            )
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            height: containerheight,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            //width: containerwidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //SizedBox(
                //   width: 12,
                // ),
                SvgPicture.asset(
                  icon,
                  color: Color(0xffFCFCFD),
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.0,
                  style: MmmTextStyles.bodyRegular(textColor: gray7),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget lifeStyleChip(double height, double width, String icon,
      String text, bool isActive, void Function() onToggle) {
    return InkWell(
      onTap: () {
        onToggle.call();
      },
      child: Container(
        margin: EdgeInsets.all(12.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          color: isActive ? Color(0xffFF4D6D) : Color(0xffF0EFF5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Color(0xffF0EFF5),
            width: 1,
          ),
        ),
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
              color: isActive ? Color(0xffFCFCFD) : Color(0xff121619),
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              textScaleFactor: 1.0,
              style: MmmTextStyles.bodyRegular(
                  textColor: isActive ? gray7 : kDark5),
            ),
          ],
        ),
      ),
    );
  }

  static Container habitsDisabled(
      double containerheight, double containerwidth, String icon, String text,
      {Function()? action}) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF0EFF5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xffF0EFF5),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action,
          child: Container(
            alignment: Alignment.center,
            height: containerheight,
            padding: const EdgeInsets.symmetric(horizontal: 12),

            // width: containerwidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //SizedBox(
                //   width: 12,
                //  ),
                SvgPicture.asset(
                  icon,
                  color: Color(0xff121619),
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  text,
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.center,
                  style: MmmTextStyles.bodyRegular(textColor: kDark5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //sidebar navigation=======================================================
  static Container changePasswordSidebarNavigation() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xffF0EFF5),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            height: 58,
            width: 360,
            child: Row(
              children: [
                SizedBox(
                  width: 12,
                ),
                Container(
                  height: 24,
                  width: 24,
                  margin: EdgeInsets.only(bottom: 5),
                  child: SvgPicture.asset(
                    "images/passwordChange.svg",
                    color: Color(0xff121619),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  height: 26,
                  width: 147,
                  child: Text(
                    'Change Password',
                    textScaleFactor: 1.0,
                    textAlign: TextAlign.start,
                    style: MmmTextStyles.bodyMedium(textColor: kDark5),
                  ),
                ),
                SizedBox(
                  width: 107,
                ),
                Container(
                  height: 24,
                  width: 24,
                  child: SvgPicture.asset(
                    "images/rightArrow.svg",
                    color: Color(0xff878D96),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Container logoutSidebarNavigation({Function()? action}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xffF0EFF5),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action,
          child: Container(
            alignment: Alignment.center,
            height: 58,
            width: 360,
            child: Row(
              children: [
                SizedBox(
                  width: 12,
                ),
                Container(
                  width: 24,
                  height: 24,
                  margin: EdgeInsets.only(bottom: 5),
                  child: SvgPicture.asset(
                    "images/lock.svg",
                    color: Color(0xff121619),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  height: 26,
                  width: 139,
                  child: Text(
                    'Logout',
                    textScaleFactor: 1.0,
                    textAlign: TextAlign.start,
                    style: MmmTextStyles.bodyMedium(textColor: kDark5),
                  ),
                ),
                SizedBox(
                  width: 115,
                ),
                Container(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset(
                    "images/rightArrow.svg",
                    color: Color(0xff878D96),
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // static Container deleteAccountSidebarNavigation({Function()? action}) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(8),
  //       border: Border.all(
  //         color: Color(0xffF0EFF5),
  //         width: 1,
  //       ),
  //     ),
  //     child: Material(
  //       color: Colors.transparent,
  //       child: InkWell(
  //         onTap: action,
  //         child: Container(
  //           alignment: Alignment.center,
  //           height: 58,
  //           width: 360,
  //           child: Row(
  //             children: [
  //               SizedBox(
  //                 width: 12,
  //               ),
  //               Container(
  //                 width: 24,
  //                 height: 24,
  //                 margin: EdgeInsets.only(bottom: 0),
  //                 child: SvgPicture.asset(
  //                   "images/userDelete.svg",
  //                   color: Color(0xff121619),
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //               SizedBox(
  //                 width: 10,
  //               ),
  //               Container(
  //                 height: 26,
  //                 width: 139,
  //                 child: Text(
  //                   'Delete Account',
  //                   textAlign: TextAlign.start,
  //                   textScaleFactor: 1.0,
  //                   style: MmmTextStyles.bodyMedium(textColor: kDark5),
  //                 ),
  //               ),
  //               Container(
  //                 width: 24,
  //                 height: 24,
  //                 child: SvgPicture.asset(
  //                   "images/rightArrow.svg",
  //                   color: Color(0xff878D96),
  //                   fit: BoxFit.cover,
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  static Container deleteAccountSidebarNavigation({Function()? action}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xffF0EFF5),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action,
          child: Container(
            alignment: Alignment.center,
            height: 58,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "images/userDelete.svg",
                        color: Color(0xff121619),
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Delete Account',
                        textAlign: TextAlign.start,
                        textScaleFactor: 1.0,
                        style: MmmTextStyles.bodyMedium(textColor: kDark5),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset(
                    "images/rightArrow.svg",
                    color: Color(0xff878D96),
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //search screen=============================================================

  static Container searchScreenButtons(String icon, String text) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xffF0EFF5),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () {},
            child: Container(
              height: 58,
              width: 328,
              padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
              child: Row(
                children: [
                  SvgPicture.asset(
                    icon,
                    color: Color(0xff343A3F),
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Container(
                    height: 26,
                    width: 184,
                    child: Text(
                      text,
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.start,
                      style: MmmTextStyles.bodyRegular(textColor: kDark5),
                    ),
                  ),
                  SizedBox(
                    width: 58,
                  ),
                  SvgPicture.asset(
                    "images/rightArrow.svg",
                    height: 20,
                    width: 20,
                    color: Color(0xff878D96),
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            )),
      ),
    );
  }

  //meet screen==============================================================
  static Container virtualDateMeetScreen() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: Color(0xff121619),
          )),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            height: 50,
            width: 328,
            child: Text(
              'Virtual Date',
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
              style: MmmTextStyles.heading5(textColor: kDark5),
            ),
          ),
        ),
      ),
    );
  }

  static Container cancelButtonBookYourDate() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xff878D96),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              height: 42,
              width: 136,
              child: Text(
                'Cancel',
                textAlign: TextAlign.center,
                style: MmmTextStyles.heading5(textColor: Color(0xffF9F9FB)),
              ),
            )),
      ),
    );
  }

  static Container cancelButtonMeet() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffDDE1E6),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            height: 28,
            width: 76,
            child: Text(
              'Cancel',
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
              style: MmmTextStyles.captionBold(textColor: kDark5),
            ),
          ),
        ),
      ),
    );
  }

  static Container cancelButtonBookyourlocation() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffDDE1E6),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            height: 38,
            width: 136,
            child: Text(
              'Cancel',
              textAlign: TextAlign.center,
              style: MmmTextStyles.heading6(textColor: kDark5),
            ),
          ),
        ),
      ),
    );
  }

  static Widget rescheduleButtonMeet(Function onTap) {
    return Container(
      height: 28,
      width: 127,
      child: Container(
        decoration: MmmDecorations.primaryButtonDecoration(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                onTap.call();
              },
              child: Center(
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    Container(
                      width: 16,
                      height: 16,
                      child: SvgPicture.asset(
                        "images/Calendar.svg",
                        color: Color(0xffFCFCFD),
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      alignment: Alignment.center,
                      height: 20,
                      width: 71,
                      child: Text(
                        'Reschedule',
                        textScaleFactor: 1.0,
                        textAlign: TextAlign.center,
                        style: MmmTextStyles.captionBold(textColor: gray7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //interests screen=============================================================

  static Container connectButton(String text, {Function()? action}) {
    return Container(
      decoration: MmmDecorations.primaryButtonDecoration(),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: action,
            child: Container(
              padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
              //alignment: Alignment.center,
              height: 28,
              width: 129,
              child: Row(
                children: [
                  SvgPicture.asset(
                    'images/connect.svg',
                    height: 16,
                    color: gray7,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.0,
                    style: MmmTextStyles.caption(textColor: gray7),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Container unblockButton(String text, {Function()? action}) {
    return Container(
      decoration: MmmDecorations.primaryButtonDecoration(),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: action,
            child: Container(
              padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
              //alignment: Alignment.center,
              height: 28,
              width: 104,
              child: Row(
                children: [
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.0,
                    style: MmmTextStyles.caption(textColor: gray7),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Container preferenceFliterScreen(String text) {
    return Container(
      height: 48,
      width: 327,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: Color(0xffF0EFF5)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Container(
                height: 26,
                width: 145,
                child: Text(
                  text,
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.start,
                  style: MmmTextStyles.bodyRegular(textColor: kDark5),
                ),
              ),
              SizedBox(
                width: 130,
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

  static Container acceptInterestScreen(Function()? action) {
    return Container(
      height: 28,
      width: 91,
      child: Container(
        decoration: MmmDecorations.primaryButtonDecoration(),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: action,
            child: Center(
              child: Row(
                children: [
                  SizedBox(
                    width: 12,
                  ),
                  Container(
                    width: 16,
                    height: 16,
                    child: SvgPicture.asset(
                      "images/heart.svg",
                      color: Color(0xffFCFCFD),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    alignment: Alignment.center,
                    height: 20,
                    width: 43,
                    child: Text(
                      'Accept',
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.center,
                      style: MmmTextStyles.caption(textColor: gray7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Container acceptMeetScreen(void Function() onTap) {
    return Container(
      height: 28,
      width: 91,
      child: Container(
        decoration: MmmDecorations.primaryButtonDecoration(),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              onTap.call();
            },
            child: Center(
              child: Row(
                children: [
                  SizedBox(
                    width: 12,
                  ),
                  Container(
                    width: 16,
                    height: 16,
                    child: SvgPicture.asset(
                      "images/meet.svg",
                      color: Color(0xffFCFCFD),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    alignment: Alignment.center,
                    height: 20,
                    width: 43,
                    child: Text(
                      'Accept',
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.center,
                      style: MmmTextStyles.caption(textColor: gray7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Container cancelButtonInterestScreen({Function()? action}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: kLight4,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: action,
            child: Container(
              alignment: Alignment.center,
              height: 28,
              width: 67,
              child: Text(
                'Cancel',
                textScaleFactor: 1.0,
                style: MmmTextStyles.caption(textColor: kDark5),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Container cancelButtonMeetScreen(String title, double width,
      {Function()? action}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: gray5,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: action,
            child: Container(
              alignment: Alignment.center,
              height: 28,
              width: width,
              child: Text(
                title,
                textScaleFactor: 1.0,
                style: MmmTextStyles.captionBold(textColor: kDark5),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Container rejectButtonInterestScreen(Function()? action) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffF0EFF5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: action,
          child: Container(
            alignment: Alignment.center,
            height: 28,
            width: 61,
            child: Text(
              'Reject',
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
              style: MmmTextStyles.caption(textColor: kDark5),
            ),
          ),
        ),
      ),
    );
  }

  //fliter screen===========================================================
  static Container verifyAccountFliterScreen(context, {Function()? action}) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF0EFF5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xffDDE1E6),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: action,
            child: Container(
              alignment: Alignment.center,
              height: 87,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 39,
                    width: 41.1,
                    child: SvgPicture.asset(
                      "images/verifiedCheck.svg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    child: Text(
                      'Verify your account',
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.center,
                      style: MmmTextStyles.heading5(textColor: kDark5),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: SvgPicture.asset(
                      "images/rightArrow.svg",
                      color: gray3,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Container interestSelected() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color(0xffF0EFF5),
            width: 1,
          ),
          color: kShadowColorForPink,
          boxShadow: [
            BoxShadow(
              color: kShadowColorForPink.withOpacity(0.12),
              blurRadius: 22.0,
              spreadRadius: 0.0,
              offset: Offset(0.0, 12.0),
            )
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            height: 74,
            width: 156,
            padding: EdgeInsets.fromLTRB(40, 24, 40, 24),
            child: Row(
              children: [
                SvgPicture.asset(
                  'images/interests/games.svg',
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'Sports',
                  textAlign: TextAlign.center,
                  style: MmmTextStyles.bodyMediumSmall(textColor: gray7),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget backButton(BuildContext context) {
    return Container(
      child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: ShaderMask(
            shaderCallback: (bounds) => RadialGradient(
              center: Alignment.center,
              radius: 0.5,
              colors: [kPrimary, kSecondary],
              tileMode: TileMode.mirror,
            ).createShader(bounds),
            child: SvgPicture.asset(
              'images/leftArrow.svg',
              color: Colors.white,
              height: 24,
              width: 24,
            ),
          )),
    );
  }

  static Widget buildOptionSelectWidget(
      String hint, String iconName, String? text,
      {Function()? action}) {
    return Container(
        height: 50,
        decoration: BoxDecoration(
          color: kLight4,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: kDark2),
        ),
        child: InkWell(
          onTap: action,
          child: Row(
            children: [
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  text != null ? text : hint,
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.start,
                  style: text != null
                      ? MmmTextStyles.bodyRegular(textColor: kDark2)
                      : MmmTextStyles.bodyRegular(textColor: kDark5),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              SvgPicture.asset(
                "images/$iconName.svg",
                width: 24,
                height: 24,
                color: Color(0xff878D96),
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 8,
              ),
            ],
          ),
        ));
  }
}
