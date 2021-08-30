import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
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
  // String showWidget1 = 'showPhoto';
  // String showWidget2 = 'uploadPhoto';
  // String showWidget3 = 'uploadPhoto';
  // String showWidget4 = 'uploadPhoto';
  String pathPhoto1 = '';
  String pathPhoto2 = '';
  String pathPhoto3 = '';
  String pathPhoto4 = '';

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
                                    child: pathPhoto1 == ''
                                        ? MmmButtons.uploadPhotoButton(
                                            action: () {
                                            uploadPhotos('pathPhoto1');
                                          })
                                        : MmmButtons.showphotoButton(
                                            pathPhoto1, context, action: () {
                                            setState(() {
                                              pathPhoto1 = '';
                                            });
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
                                    child: pathPhoto2 == ''
                                        ? MmmButtons.uploadPhotoButton(
                                            action: () {
                                            uploadPhotos('pathPhoto2');
                                          })
                                        : MmmButtons.showphotoButton(
                                            pathPhoto2, context, action: () {
                                            setState(() {
                                              pathPhoto2 = '';
                                            });
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
                                      child: pathPhoto3 == ''
                                          ? MmmButtons.uploadPhotoButton(
                                              action: () {
                                              uploadPhotos('pathPhoto3');
                                            })
                                          : MmmButtons.showphotoButton(
                                              pathPhoto3, context, action: () {
                                              setState(() {
                                                pathPhoto3 = '';
                                              });
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
                                      child: pathPhoto4 == ''
                                          ? MmmButtons.uploadPhotoButton(
                                              action: () {
                                              uploadPhotos('pathPhoto4');
                                            })
                                          : MmmButtons.showphotoButton(
                                              pathPhoto4, context, action: () {
                                              setState(() {
                                                pathPhoto4 = '';
                                              });
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
                                      UpdateBioEvent(
                                          bioController.text,
                                          pathPhoto1,
                                          pathPhoto2,
                                          pathPhoto3,
                                          pathPhoto4));
                                })
                              ]),
                        ])));
          },
        ));
  }

  void uploadPhotos(String photoPos) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        context: context,
        builder: (context) => Container(
            padding: kMargin16,
            child: Column(children: [
              SizedBox(
                height: 60,
              ),
              MmmButtons.facebookImportbutton(),
              SizedBox(
                height: 16,
              ),
              MmmButtons.importGalleryButton(action: () {
                pickImages(ImageSource.gallery, photoPos);
              }),
              SizedBox(
                height: 16,
              ),
              MmmButtons.cameraimportButton(action: () {
                pickImages(ImageSource.camera, photoPos);
              }),
            ])));
  }

  final ImagePicker _picker = ImagePicker();
  Future pickImages(ImageSource source, String photoPos) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image == null) return;
      final imageTemp = image.path;
      setState(() {
        if (photoPos == 'pathPhoto1') {
          pathPhoto1 = imageTemp;
        } else if (photoPos == 'pathPhoto2') {
          pathPhoto2 = imageTemp;
        } else if (photoPos == 'pathPhoto3') {
          pathPhoto3 = imageTemp;
        } else {
          pathPhoto4 = imageTemp;
        }
      });
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      print('Failed to pick image:$e');
    }
  }
}
