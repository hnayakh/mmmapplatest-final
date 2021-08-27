import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/profilescreens/bio_event.dart';

import 'bio_bloc.dart';
import 'bio_state.dart';

class Bio extends StatelessWidget {
  final UserRepository userRepository;

  const Bio({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BioBloc(
        userRepository,
      ),
      child: BioScreen(),
    );
  }
}

class BioScreen extends StatefulWidget {
  const BioScreen({Key? key}) : super(key: key);

  @override
  _BioScreenState createState() => _BioScreenState();
}

class _BioScreenState extends State<BioScreen> {
  String showWidget1 = 'showPhoto';
  String showWidget2 = 'uploadPhoto';
  String showWidget3 = 'uploadPhoto';
  String showWidget4 = 'uploadPhoto';
  String photo1 = 'images/bio.jpg';
  String photo2 = '';
  String photo3 = '';
  String photo4 = '';

  var bioController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MmmButtons.appBarCurved('Bio'),
        body: BlocConsumer<BioBloc, BioState>(
          listener: (context, state) {
            if (state is OnProfileSetupCompletion) {
              //navigate to profile screen
              print('profile setup completed');
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
                child: Container(
                    padding: kMargin16,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: double.infinity,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'About me',
                                style: MmmTextStyles.bodyRegular(
                                    textColor: kDark5),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Container(
                                  height: 180,
                                  //width: 390,
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 1, color: kBio),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: TextField(
                                      controller: bioController,
                                      maxLength: 200,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        hintText: 'A little bit about me ...',
                                        hintStyle: MmmTextStyles.bodySmall(
                                            textColor: gray4),
                                        border: InputBorder.none,
                                        //enabledBorder: OutlineInputBorder(
                                        //   borderSide:
                                        //       BorderSide(color: kBio, width: 1),
                                        //    borderRadius: BorderRadius.circular(8)),
                                        //  focusedBorder: OutlineInputBorder(
                                        //    borderSide:
                                        //        BorderSide(color: kBio, width: 1),
                                        //    borderRadius: BorderRadius.circular(8)),
                                      )))
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Photo',
                                  style: MmmTextStyles.bodyRegular(
                                      textColor: kDark5),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(children: [
                                  Expanded(
                                    flex: 10,
                                    child: showWidget1 == 'showPhoto'
                                        ? MmmButtons.showphotoButton(
                                            photo1, context, action: () {})
                                        : MmmButtons.uploadPhotoButton(
                                            action: () {
                                            uploadPhotos();
                                          }),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                        // width: 15.26,
                                        ),
                                  ),
                                  Expanded(
                                    flex: 10,
                                    child: showWidget2 == 'showPhoto'
                                        ? MmmButtons.showphotoButton(
                                            photo2, context, action: () {})
                                        : MmmButtons.uploadPhotoButton(
                                            action: () {
                                            uploadPhotos();
                                          }),
                                  ),
                                ]),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 10,
                                      child: showWidget3 == 'showPhoto'
                                          ? MmmButtons.showphotoButton(
                                              photo3, context, action: () {})
                                          : MmmButtons.uploadPhotoButton(
                                              action: () {
                                              uploadPhotos();
                                            }),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                          //width: 15.26,
                                          ),
                                    ),
                                    Expanded(
                                      flex: 10,
                                      child: showWidget4 == 'showPhoto'
                                          ? MmmButtons.showphotoButton(
                                              photo4, context, action: () {})
                                          : MmmButtons.uploadPhotoButton(
                                              action: () {
                                              uploadPhotos();
                                            }),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                MmmButtons.enabledRedButtonbodyMedium(
                                    50, 'Submit your details', action: () {
                                  BlocProvider.of<BioBloc>(context).add(
                                      UpdateBioEvent(bioController.text, photo1,
                                          photo2, photo3, photo4));
                                })
                              ]),
                        ])));
          },
        ));
  }

  void uploadPhotos() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        context: context,
        builder: (context) => Container(
              padding: kMargin16,
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  MmmButtons.facebookImportbutton(),
                  SizedBox(
                    height: 16,
                  ),
                  MmmButtons.importGalleryButton(),
                  SizedBox(
                    height: 16,
                  ),
                  MmmButtons.cameraimportButton()
                ],
              ),
            ));
  }
}
