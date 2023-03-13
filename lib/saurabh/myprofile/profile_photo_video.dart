import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/saurabh/partner_preference.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/profilescreens/bio/bloc/bio_bloc.dart';
import 'package:makemymarry/views/profilescreens/bio/bloc/bio_state.dart';
import 'package:makemymarry/views/profilescreens/bio/views/image_picker_dialog.dart';

import '../../utils/dimens.dart';
import '../../views/profilescreens/bio/bloc/bio_event.dart';

class MmmPhotovideos extends StatelessWidget {
  final UserRepository userRepository;

  const MmmPhotovideos({Key? key, required this.userRepository})
      : super(key: key);

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

  List<String> localImagePaths = [];
  late UserDetails userDetails;
  String profileImage = "";
  @override
  Widget build(BuildContext context) {
    this.userDetails =
        BlocProvider.of<BioBloc>(context).userRepository.useDetails!;

    if (this.userDetails.registrationStep > 8) {
      BlocProvider.of<BioBloc>(context).add(onBioDataLoad(userDetails.id));
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar:
            MmmButtons.appBarCurved('Profile Photo & Videos', context: context),
        body: BlocConsumer<BioBloc, BioState>(
          listener: (context, state) {
            if (state is OnProfileSetupCompletion) {}
            if (state is OnError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
            if (state is OnUpdate) {
              if (this.userDetails.registrationStep > 8) {
                Navigator.of(context).pop();
              } else {
                navigateToProfilePreference();
              }
            }
            if (state is BioDataState) {
              this.profileDetails = state.profileDetails;
              (this.profileDetails?.images ?? []).forEach((element) {
                if (!this.localImagePaths.contains(element)) {
                  this.localImagePaths.insert(0, element);
                }
              });
              if ((this.profileDetails?.images ?? []).isNotEmpty) {
                profileImage = (this.profileDetails?.images ?? []).first;
              } else {
                profileImage = "";
              }
            }
          },
          builder: (context, state) {
            initData(context);

            return Stack(
              children: [
                Container(
                    padding: kMargin16,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Container(
                              child: Column(
                                children: [
                                  buildAboutMeWidget(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              'More',
                                              style: MmmTextStyles.bodyRegular(
                                                  textColor: kDark5),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Expanded(
                                              child: GridView.builder(
                                            gridDelegate:
                                                SliverGridDelegateWithMaxCrossAxisExtent(
                                                    maxCrossAxisExtent:
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .width) /
                                                            2,
                                                    mainAxisExtent: 120,
                                                    crossAxisSpacing: 20,
                                                    mainAxisSpacing: 20),
                                            itemBuilder: (context, index) {
                                              if (this.localImagePaths.length ==
                                                  0) {
                                                return addImageButton();
                                              } else {
                                                var image =
                                                    this.localImagePaths[index];

                                                return Column(
                                                  children: [
                                                    Container(
                                                      child: Stack(
                                                        children: [
                                                          ClipRRect(
                                                            child: image !=
                                                                    "addImage"
                                                                ? CachedNetworkImage(
                                                                    imageUrl:
                                                                        image,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                    width: (MediaQuery.of(context)
                                                                            .size
                                                                            .width) /
                                                                        2,
                                                                    height: 120,
                                                                    errorWidget:
                                                                        (context,
                                                                            obj,
                                                                            str) {
                                                                      print(image +
                                                                          "========================================================================>>>>>");
                                                                      print(
                                                                          obj);
                                                                      print(
                                                                          str);
                                                                      print(image +
                                                                          "========================================================================>>>>>");
                                                                      return InkWell(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {});
                                                                        },
                                                                        child: Container(
                                                                            width: (MediaQuery.of(context).size.width) /
                                                                                2,
                                                                            height:
                                                                                120,
                                                                            color:
                                                                                Colors.grey,
                                                                            child: Icon(Icons.error)),
                                                                      );
                                                                    })
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
                                                                    onTap: () {
                                                                      BlocProvider.of<BioBloc>(
                                                                              context)
                                                                          .add(RemoveImage(
                                                                              index));
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      child: SvgPicture
                                                                          .asset(
                                                                        "images/Cross.svg",
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      width: 18,
                                                                      height:
                                                                          18,
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              2),
                                                                      decoration: BoxDecoration(
                                                                          gradient: MmmDecorations
                                                                              .primaryGradient(),
                                                                          borderRadius:
                                                                              BorderRadius.circular(9)),
                                                                    ),
                                                                  ))
                                                              : Container(),
                                                          this.localImagePaths[
                                                                      index] !=
                                                                  "addImage"
                                                              ? Positioned(
                                                                  top: -8,
                                                                  left: -8,
                                                                  child: Radio<
                                                                          String>(
                                                                      value: this
                                                                              .localImagePaths[
                                                                          index],
                                                                      groupValue:
                                                                          profileImage,
                                                                      onChanged:
                                                                          (String?
                                                                              value) {
                                                                        if (value !=
                                                                            null) {
                                                                          BlocProvider.of<BioBloc>(context)
                                                                              .add(ChangeProfilePic(value));
                                                                          this.profileImage =
                                                                              value;
                                                                        }
                                                                      }),
                                                                )
                                                              : Container()
                                                        ],
                                                      ),
                                                      decoration: BoxDecoration(
                                                          boxShadow: [
                                                            MmmShadow
                                                                .elevation3(
                                                                    shadowColor:
                                                                        kShadow)
                                                          ],
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
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
                                    height: 30,
                                  ),
                                  MmmButtons.enabledRedButtonbodyMedium(
                                      50, 'Save', action: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    BlocProvider.of<BioBloc>(context).add(
                                        UpdateBioImage(
                                            this.localImagePaths,
                                            this.userDetails.registrationStep >
                                                8));
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

  Widget buildAboutMeWidget() {
    return Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
            ),
            clipBehavior: Clip.hardEdge,
            child: CachedNetworkImage(
              imageUrl: profileImage,
              fit: BoxFit.contain,
              errorWidget: (context, obj, str) => Container(
                color: Colors.grey,
                child: Icon(
                  Icons.error,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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

    // this.aboutMe = this.bioController.text;

    if (BlocProvider.of<BioBloc>(context).profileData != null) {
      // if (this.aboutMe == null) {
      //   this.aboutMe =
      //       BlocProvider.of<BioBloc>(context).profileData!.aboutmeMsg;
      // }
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
        builder: (context) => PartnerPrefsScreen(userRepository: userRepo)));
  }
}
