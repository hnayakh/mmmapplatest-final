import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/profilescreens/family/family_background/family_background_event.dart';
import 'package:makemymarry/views/profilescreens/family/family_background/family_background_state.dart';

import 'family_background_bloc.dart';
import 'family_status_bottom_sheet.dart';
import 'family_values_sheet.dart';

class FamilyBackground extends StatelessWidget {
  final UserRepository userRepository;
  final Function onComplete;

  const FamilyBackground(
      {Key? key, required this.userRepository, required this.onComplete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => FamilyBackgroundBloc(userRepository),
        child: FamilyBackgroundScreen());
  }
}

class FamilyBackgroundScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FamilyBackgroundScreenState();
  }
}

class FamilyBackgroundScreenState extends State<FamilyBackgroundScreen> {
  String familyStatustext = 'Select your family status';
  String familyValuestext = 'Select your family value';
  FamilyAfluenceLevel? level;
  FamilyValues? values;
  FamilyType? type;

  String countrytext = 'Select your country';

  String statetext = 'Select your state';

  String citytext = 'Select your city';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FamilyBackgroundBloc, FamilyBackgroundState>(
      builder: (context, state) {
        initData();
        return Container(
            child: Stack(
          children: [
           SingleChildScrollView(
             child:  Container(
               padding: kMargin16,
               child: Column(
                 children: [
                   Column(
                     children: [
                       Column(
                         children: [
                           Row(
                             children: [
                               Text(
                                 'Family Status',
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
                           SizedBox(
                             height: 4,
                           ),
                           Container(
                             height: 40,
                             decoration: BoxDecoration(
                               color: kLight4,
                               borderRadius: BorderRadius.circular(8),
                               border: Border.all(width: 1, color: kDark2),
                             ),
                             child: Material(
                               color: Colors.transparent,
                               child: InkWell(
                                 onTap: () {
                                   showFamilyStatusSheet();
                                 },
                                 child: Row(
                                   children: [
                                     SizedBox(
                                       width: 16,
                                     ),
                                     Container(
                                       width: 205,
                                       child: Text(
                                         level != null
                                             ? describeEnum(level!)
                                             : familyStatustext,
                                         textScaleFactor: 1.0,
                                         textAlign: TextAlign.start,
                                         style: level != null
                                             ? MmmTextStyles.bodyRegular(
                                             textColor: kDark5)
                                             : MmmTextStyles.bodyRegular(
                                             textColor: kDark2),
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
                           ),
                         ],
                       ),
                       SizedBox(
                         height: 24,
                       ),
                       Column(
                         children: [
                           Row(
                             children: [
                               Text(
                                 'Family Values',
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
                           SizedBox(
                             height: 4,
                           ),
                           Container(
                             height: 40,
                             decoration: BoxDecoration(
                               color: kLight4,
                               borderRadius: BorderRadius.circular(8),
                               border: Border.all(width: 1, color: kDark2),
                             ),
                             child: Material(
                               color: Colors.transparent,
                               child: InkWell(
                                 onTap: () {
                                   showFamilyValuesSheet();
                                 },
                                 child: Row(
                                   children: [
                                     SizedBox(
                                       width: 16,
                                     ),
                                     Container(
                                       width: 205,
                                       child: Text(
                                         this.values != null
                                             ? describeEnum(this.values!)
                                             : familyValuestext,
                                         textScaleFactor: 1.0,
                                         textAlign: TextAlign.start,
                                         style: this.values != null
                                             ? MmmTextStyles.bodyRegular(
                                             textColor: kDark5)
                                             : MmmTextStyles.bodyRegular(
                                             textColor: kDark2),
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
                           ),
                         ],
                       ),
                       SizedBox(
                         height: 24,
                       ),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Container(
                             margin: EdgeInsets.only(top: 10, left: 8),
                             child: Text(
                               'Family Type',
                               style:
                               MmmTextStyles.bodyRegular(textColor: kDark5),
                             ),
                           ),
                           Container(
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: [
                                 Transform.scale(
                                   scale: 1.2,
                                   child: Radio(
                                       activeColor: Colors.pinkAccent,
                                       value: this.type!,
                                       groupValue: FamilyType.Nuclear,
                                       onChanged: (val) {
                                         BlocProvider.of<FamilyBackgroundBloc>(
                                             context)
                                             .add(OnFamilyTypeChanges(
                                             FamilyType.Nuclear));
                                       }),
                                 ),
                                 Text(
                                   'Nuclear Family',
                                   style: MmmTextStyles.bodySmall(
                                       textColor: kDark5),
                                 ),
                                 SizedBox(
                                   width: 8,
                                 ),
                                 Transform.scale(
                                   scale: 1.2,
                                   child: Radio(
                                       activeColor: Colors.pinkAccent,
                                       value: this.type!,
                                       groupValue: FamilyType.Joint,
                                       onChanged: (val) {
                                         BlocProvider.of<FamilyBackgroundBloc>(
                                             context)
                                             .add(OnFamilyTypeChanges(
                                             FamilyType.Joint));
                                       }),
                                 ),
                                 Text(
                                   'Joint Family',
                                   style: MmmTextStyles.bodySmall(
                                       textColor: kDark5),
                                 ),
                                 SizedBox(
                                   width: 8,
                                 ),
                                 Transform.scale(
                                   scale: 1.2,
                                   child: Radio(
                                       activeColor: Colors.pinkAccent,
                                       value: this.type!,
                                       groupValue: FamilyType.Other,
                                       onChanged: (val) {
                                         BlocProvider.of<FamilyBackgroundBloc>(
                                             context)
                                             .add(OnFamilyTypeChanges(
                                             FamilyType.Other));
                                       }),
                                 ),
                                 Text(
                                   'Other',
                                   style: MmmTextStyles.bodySmall(
                                       textColor: kDark5),
                                 ),
                               ],
                             ),
                           ),
                         ],
                       ),
                       Container(
                         width: MediaQuery.of(context).size.width-96,
                         decoration: BoxDecoration(
                             border: Border.all(width: 1, color: kLight4)),
                       )
                     ],
                   ),
                   SizedBox(
                     height: 24,
                   ),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.end,
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           Text(
                             '   Current location of groom’s family',
                             style: MmmTextStyles.bodyMedium(textColor: kDark5),
                           ),
                         ],
                       ),
                       Column(
                         children: [
                           Row(
                             children: [
                               Text(
                                 'Country',
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
                           SizedBox(
                             height: 4,
                           ),
                           Container(
                             height: 40,
                             decoration: BoxDecoration(
                               color: kLight4,
                               borderRadius: BorderRadius.circular(8),
                               border: Border.all(width: 1, color: kDark2),
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
                                       width: 205,
                                       child: Text(
                                         countrytext,
                                         textScaleFactor: 1.0,
                                         textAlign: TextAlign.start,
                                         style:
                                         countrytext == 'Select your country'
                                             ? MmmTextStyles.bodyRegular(
                                             textColor: kDark2)
                                             : MmmTextStyles.bodyRegular(
                                             textColor: kDark5),
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
                           ),
                         ],
                       ),
                       SizedBox(
                         height: 24,
                       ),
                       Column(
                         children: [
                           Row(
                             children: [
                               Text(
                                 'State',
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
                           SizedBox(
                             height: 4,
                           ),
                           Container(
                             height: 40,
                             decoration: BoxDecoration(
                               color: kLight4,
                               borderRadius: BorderRadius.circular(8),
                               border: Border.all(width: 1, color: kDark2),
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
                                       width: 205,
                                       child: Text(
                                         statetext,
                                         textScaleFactor: 1.0,
                                         textAlign: TextAlign.start,
                                         style: statetext == 'Select your state'
                                             ? MmmTextStyles.bodyRegular(
                                             textColor: kDark2)
                                             : MmmTextStyles.bodyRegular(
                                             textColor: kDark5),
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
                           ),
                         ],
                       ),
                       SizedBox(
                         height: 24,
                       ),
                       Column(
                         children: [
                           Row(
                             children: [
                               Text(
                                 'City',
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
                           SizedBox(
                             height: 4,
                           ),
                           Container(
                             height: 40,
                             decoration: BoxDecoration(
                               color: kLight4,
                               borderRadius: BorderRadius.circular(8),
                               border: Border.all(width: 1, color: kDark2),
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
                                       width: 205,
                                       child: Text(
                                         citytext,
                                         textScaleFactor: 1.0,
                                         textAlign: TextAlign.start,
                                         style: citytext == 'Select your city'
                                             ? MmmTextStyles.bodyRegular(
                                             textColor: kDark2)
                                             : MmmTextStyles.bodyRegular(
                                             textColor: kDark5),
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
                           ),
                         ],
                       ),
                       SizedBox(
                         height: 20,
                       ),
                     ],
                   )
                 ],
               ),
             ),
           )
          ],
        ));
      },
      listener: (context, state) {},
    );
  }

  void initData() {
    this.values = BlocProvider.of<FamilyBackgroundBloc>(context).values;
    this.level = BlocProvider.of<FamilyBackgroundBloc>(context).level;
    this.type = BlocProvider.of<FamilyBackgroundBloc>(context).type;
  }

  showFamilyStatusSheet() async {
    var result = await showModalBottomSheet(
        context: context,
        builder: (context) => FamilyStatusBottomSheet(
              level: this.level,
            ));
    if (result != null && result is FamilyAfluenceLevel) {
      BlocProvider.of<FamilyBackgroundBloc>(context)
          .add(OnFamilyStatusSelected(result));
    }
  }

  void showFamilyValuesSheet() async {
    var result = await showModalBottomSheet(
        context: context,
        builder: (context) => FamilyValuesBottomSheet(
              level: values,
            ));
    if (result != null && result is FamilyValues) {
      BlocProvider.of<FamilyBackgroundBloc>(context)
          .add(OnFamilyValueSelected(result));
    }
  }
}
