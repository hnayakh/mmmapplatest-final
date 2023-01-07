import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/profile_loader/profile_loader.dart';
import 'package:makemymarry/views/profilescreens/bio/views/image_picker_dialog.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/profile_preference.dart';

import '../bloc/bio_bloc.dart';
import '../bloc/bio_state.dart';
import '../bloc/bio_event.dart';

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
  ProfileDetails? profileDetails;
  var bioController = TextEditingController();
  String? aboutMe;
  List<String> localImagePaths = [];
  late UserDetails userDetails;
  @override
  Widget build(BuildContext context) {
    this.userDetails =
        BlocProvider.of<BioBloc>(context).userRepository.useDetails!;

    if (this.userDetails.registrationStep > 8) {
      BlocProvider.of<BioBloc>(context).add(onBioDataLoad(userDetails.id));
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<BioBloc, BioState>(
          listener: (context, state) {
            if (state is OnProfileSetupCompletion) {
              //navigate to profile screen
              print('profile setup completed');
            }
            if (state is OnError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ));
            }
            if (state is OnUpdate) {
              if(this.userDetails.registrationStep > 8 ){
                Navigator.of(context).pop();
              }else {
                navigateToProfilePreference();
              }
            }
          },
          builder: (context, state) {
            initData(context);


            return Stack(
              children: [
                Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                      MmmButtons.appBarCurved('About', context: context),
                      Expanded(
                        child: Container(
                          padding: kMargin16,
                          child: Column(
                            children: [
                              buildAboutMeWidget(),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: this.userDetails.registrationStep > 8
                                    ? Container()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                            Text(
                                              'Photo',
                                              style: MmmTextStyles.bodyRegular(
                                                  textColor: kDark5),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Expanded(
                                                child: GridView.builder(
                                              gridDelegate:
                                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                                      maxCrossAxisExtent:
                                                          (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width) /
                                                              2,
                                                      mainAxisExtent: 120,
                                                      crossAxisSpacing: 20,
                                                      mainAxisSpacing: 20),
                                              itemBuilder: (context, index) {
                                                print(
                                                    "IMAGE${this.localImagePaths}");
                                                if (this
                                                        .localImagePaths
                                                        .length ==
                                                    0) {
                                                  return addImageButton();
                                                } else {
                                                  var image = this
                                                      .localImagePaths[index];
                                                  print("image $image");
                                                  return Column(
                                                    children: [
                                                      Container(
                                                        child: Stack(
                                                          children: [
                                                            ClipRRect(
                                                              child: image !=
                                                                      "addImage"
                                                                  ? Image
                                                                      .network(
                                                                      image,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      width: (MediaQuery.of(context)
                                                                              .size
                                                                              .width) /
                                                                          2,
                                                                      height:
                                                                          120,
                                                                    )
                                                                  : addImageButton(),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                            this.localImagePaths[
                                                                        index] !=
                                                                    "addImage"
                                                                ? Positioned(
                                                                    top: 8,
                                                                    right: 8,
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        BlocProvider.of<BioBloc>(context)
                                                                            .add(RemoveImage(index));
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        child: SvgPicture
                                                                            .asset(
                                                                          "images/Cross.svg",
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        width:
                                                                            18,
                                                                        height:
                                                                            18,
                                                                        padding:
                                                                            const EdgeInsets.all(2),
                                                                        decoration: BoxDecoration(
                                                                            gradient:
                                                                                MmmDecorations.primaryGradient(),
                                                                            borderRadius: BorderRadius.circular(9)),
                                                                      ),
                                                                    ))
                                                                : Container()
                                                          ],
                                                        ),
                                                        decoration: BoxDecoration(
                                                            boxShadow: [
                                                              MmmShadow.elevation3(
                                                                  shadowColor:
                                                                      kShadow)
                                                            ],
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                      ),
                                                    ],
                                                  );
                                                }
                                              },
                                              itemCount:
                                                  this.localImagePaths.length,
                                            )),
                                          ]),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              this.userDetails.registrationStep > 8
                                  ? MmmButtons.enabledRedButtonbodyMedium(
                                      50, 'Save', action: () {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      BlocProvider.of<BioBloc>(context).add(
                                          UpdateBio(this.aboutMe!, this.localImagePaths, this.userDetails.registrationStep > 8
                                              ));
                                    })
                                  : MmmButtons.enabledRedButtonbodyMedium(
                                      50, 'Submit your details', action: () {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      BlocProvider.of<BioBloc>(context).add(
                                          UpdateBio(this.aboutMe!,
                                              this.localImagePaths, this.userDetails.registrationStep > 8));
                                    })
                            ],
                          ),
                        ),
                      )
                    ])),
                state is OnLoading
                    ? MmmWidgets.buildLoader(context)
                    : Container()
              ],
            );
          },
        ));
  }

  InkWell addImageButton() {
    return InkWell(
      onTap: () {
        showImagePickerDialog();
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
            boxShadow: [MmmShadow.elevation3(shadowColor: kShadow)],
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: kBioSecondary, width: 1.5),
                borderRadius: BorderRadius.circular(7)),
            padding: const EdgeInsets.all(6),
            child: SvgPicture.asset("images/plus.svg"),
          ),
        ),
      ),
    );
  }

  // Widget imagesGrid(index) {
  //   return
  //   Container(
  //     child: Stack(
  //       children: [
  //         ClipRRect(
  //           child: Image.network(
  //             this.localImagePaths[index],
  //             fit: BoxFit.cover,
  //             width: (MediaQuery.of(context).size.width) / 2,
  //             height: 120,
  //           ),
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //         Positioned(
  //             top: 8,
  //             right: 8,
  //             child: InkWell(
  //               onTap: () {
  //                 BlocProvider.of<BioBloc>(context).add(RemoveImage(index));
  //               },
  //               child: Container(
  //                 child: SvgPicture.asset(
  //                   "images/Cross.svg",
  //                   color: Colors.white,
  //                 ),
  //                 width: 18,
  //                 height: 18,
  //                 padding: const EdgeInsets.all(2),
  //                 decoration: BoxDecoration(
  //                     gradient: MmmDecorations.primaryGradient(),
  //                     borderRadius: BorderRadius.circular(9)),
  //               ),
  //             ))
  //       ],
  //     ),
  //     decoration: BoxDecoration(
  //         boxShadow: [MmmShadow.elevation3(shadowColor: kShadow)],
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(8)),
  //   );
  // }

  Widget buildAboutMeWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About me',
          style: MmmTextStyles.bodyRegular(textColor: kDark5),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
            height: 180,
            //width: 390,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: kBio),
                borderRadius: BorderRadius.circular(8)),
            child: TextField(
                controller: bioController,

                onChanged: (value) {
                  this.aboutMe = value;
                },
                // maxLength: 200,
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                decoration: InputDecoration(
                  // hintText: aboutMe,
                  hintText: 'A little bit about me',
                  hintStyle: MmmTextStyles.bodySmall(),
                  contentPadding: EdgeInsets.zero,
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
    );
  }

  // static Container aboutProfileViewButtons(String icon, String label,
  //     String about, MaritalStatus maritalStatus, AbilityStatus abilityStatus,
  //     {Function()? action}) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: kWhite,
  //       boxShadow: [MmmShadow.elevation1()],
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
  //           // height: 264,
  //           padding: EdgeInsets.all(9),
  //
  //           child: Column(
  //             children: [
  //               SizedBox(
  //                 height: 8,
  //               ),
  //               Row(
  //                 children: [
  //                   SvgPicture.asset(
  //                     icon,
  //                     color: Color(0xff121619),
  //                     fit: BoxFit.cover,
  //                   ),
  //                   Expanded(
  //                     flex: 1,
  //                     child: SizedBox(),
  //                   ),
  //                   Text(
  //                     label,
  //                     textScaleFactor: 1.0,
  //                     //textAlign: TextAlign.start,
  //                     style: MmmTextStyles.heading5(textColor: kDark6),
  //                   ),
  //                   Expanded(
  //                     flex: 20,
  //                     child: SizedBox(),
  //                   ),
  //                   Container(
  //                     child: SvgPicture.asset(
  //                       "images/arrowUp.svg",
  //                       color: Color(0xff878D96),
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: 8,
  //               ),
  //               Container(
  //                 margin: kMargin16,
  //                 child: Column(
  //                   children: [
  //                     Text(
  //                       about,
  //                       style: MmmTextStyles.bodySmall(),
  //                     ),
  //                     SizedBox(
  //                       height: 24,
  //                     ),
  //                     Row(
  //                       children: [
  //                         Text('Marital Status: ',
  //                             style: MmmTextStyles.heading6()),
  //                         Text(describeEnum(maritalStatus),
  //                             style: MmmTextStyles.bodySmall()),
  //                       ],
  //                     ),
  //                     Row(
  //                       children: [
  //                         Text('Disability: ', style: MmmTextStyles.heading6()),
  //                         Text(describeEnum(abilityStatus),
  //                             style: MmmTextStyles.bodySmall()),
  //                       ],
  //                     )
  //                   ],
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  final ImagePicker _picker = ImagePicker();

  Future pickImages(
    ImageSource source,
  ) async {
    var file = await _picker.pickImage(
      source: source,
      imageQuality: 60,
    );
    if (file != null) {
      BlocProvider.of<BioBloc>(context).add(AddImage(file.path));
    }
  }

  void showImagePickerDialog() async {
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => MmmImagePickerDialog());
    if (result != null && result is int) {
      switch (result) {
        case 1:
          break;
        case 2:
          pickImages(ImageSource.gallery);
          break;
        case 3:
          pickImages(ImageSource.camera);
      }
    }
  }

  void initData(BuildContext context) {
    this.localImagePaths = BlocProvider.of<BioBloc>(context).localImagePaths;

    this.aboutMe = this.bioController.text;

    if (BlocProvider.of<BioBloc>(context).profileData != null) {
      print("aboutMe  ${this.aboutMe}");
      if (this.aboutMe == null || this.aboutMe == '') {
        this.aboutMe =
            BlocProvider.of<BioBloc>(context).profileData!.aboutmeMsg;

        print("object123${this.aboutMe}");
        this.bioController.text = this.aboutMe ?? "";
      }
      if (this.localImagePaths.length == 0) {
        this.localImagePaths =
            BlocProvider.of<BioBloc>(context).profileData!.images;
        if (!this.localImagePaths.contains("addImage"))
          this.localImagePaths.add("addImage");
      } else {
        if (!this.localImagePaths.contains("addImage"))
          this.localImagePaths.add("addImage");
      }
    } else {
      if (!this.localImagePaths.contains("addImage"))
        this.localImagePaths.add("addImage");
    }
  }

  void navigateToProfilePreference() {
    var userRepo = BlocProvider.of<BioBloc>(context).userRepository;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProfilePreference(userRepository: userRepo)));
  }
}
