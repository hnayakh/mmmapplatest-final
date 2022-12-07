import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:makemymarry/views/profilescreens/bio/image_picker_dialog.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/profile%20screens/verify%20account%20screens/select_idproof_bottom_sheet.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/profile%20screens/verify%20account%20screens/verify_bloc.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/profile%20screens/verify%20account%20screens/verify_event.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/profile%20screens/verify%20account%20screens/verify_state.dart';

class VerifyAccount extends StatelessWidget {
  final UserRepository userRepository;

  const VerifyAccount({Key? key, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyBloc(userRepository),
      child: VerifyAccountScreen(),
    );
  }
}

class VerifyAccountScreen extends StatefulWidget {
  const VerifyAccountScreen({Key? key}) : super(key: key);

  @override
  _VerifyAccountScreenState createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  IdProofType? idProof;
  late UserDetails? userDetails;
  List<String> localImagePaths = [];
  @override
  Widget build(BuildContext context) {
    this.userDetails =
        BlocProvider.of<VerifyBloc>(context).userRepository.useDetails;
    print("USEDETAILS${this.userDetails}");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MmmButtons.appBarCurved('Verify your account', context: context),
      body: BlocConsumer<VerifyBloc, VerifyState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is AddDocumentImage) {
            //navigate to profile screen
            print('Docs setup completed');
          }
        },
        builder: (context, state) {
          initData();
          print("this.localImagePaths.length${this.localImagePaths.length}");
          return Container(
            padding: kMargin16,
            child: Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                MmmButtons.idproofButton(
                    '',
                    this.idProof != null
                        ? describeEnum(idProof!)
                        : 'Select your ID Proof',
                    'Select your ID Proof',
                    'images/rightArrow.svg', action: () {
                  selectIdProofBottomSheet(context);
                }),
                Expanded(
                    flex: 1,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Photo',
                            style: MmmTextStyles.bodyRegular(textColor: kDark5),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Expanded(
                              child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent:
                                  (MediaQuery.of(context).size.width) / 1,
                              // mainAxisExtent: 80,
                              //  crossAxisSpacing: 40,
                              // mainAxisSpacing: 30),
                            ),
                            itemBuilder: (context, index) {
                              print("LOCALLL${this.localImagePaths.length}");
                              if (this.localImagePaths.length == 0) {
                                return addImageButton();
                              } else {
                                var image = this.localImagePaths[index];
                                print("image $image");
                                return Column(
                                  children: [
                                    Container(
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            child: this
                                                        .localImagePaths
                                                        .length !=
                                                    0
                                                ? Image.network(
                                                    image,
                                                    fit: BoxFit.cover,
                                                    width:
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .width) *
                                                            1,
                                                    height:
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .width) *
                                                            0.9,
                                                  )
                                                : Container(),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          Positioned(
                                              top: 8,
                                              right: 8,
                                              child: InkWell(
                                                onTap: () {
                                                  BlocProvider.of<VerifyBloc>(
                                                          context)
                                                      .add(RemoveDocImage(
                                                          index));
                                                  addImageButton();
                                                },
                                                child: Container(
                                                  child: SvgPicture.asset(
                                                    "images/Cross.svg",
                                                    color: Colors.white,
                                                  ),
                                                  width: 18,
                                                  height: 18,
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  decoration: BoxDecoration(
                                                      gradient: MmmDecorations
                                                          .primaryGradient(),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9)),
                                                ),
                                              ))
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            MmmShadow.elevation3(
                                                shadowColor: kShadow)
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                  ],
                                );
                              }
                            },
                            itemCount: 1,
                          )),
                        ])),
                SizedBox(
                  height: 40,
                ),
                MmmButtons.enabledRedButtonbodyMedium(50, 'Verify',
                    action: () {})
              ],
            ),
            //  ),
          );
        },
      ),
    );
  }

  void selectIdProofBottomSheet(BuildContext context) async {
    var result = await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => IdproofBottomSheet(
              selectedIdProof: idProof,
            ));

    if (result != null && result is IdProofType) {
      BlocProvider.of<VerifyBloc>(context).add(OnSelectIdProof(result));
    }
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
      BlocProvider.of<VerifyBloc>(context).add(AddDocumentImage(file.path));
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

  InkWell addImageButton() {
    return InkWell(
      onTap: () {
        print("Hello");
        showImagePickerDialog();
      },
      child: Container(
        height: 254,
        width: 60,
        //alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: kWhite,
            boxShadow: [MmmShadow.elevation2()]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('images/filter.svg'),
            SizedBox(
              height: 20,
            ),
            Text('Click to upload your document',
                style: TextStyle(fontSize: 12))
          ],
        ),
      ),
    );
  }

  // InkWell addImageButton() {
  //   return InkWell(
  //     onTap: () {
  //       showImagePickerDialog();
  //     },
  //     child: Container(
  //       height: 120,
  //       decoration: BoxDecoration(
  //           boxShadow: [MmmShadow.elevation3(shadowColor: kShadow)],
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(8)),
  //       child: Center(
  //         child: Container(
  //           decoration: BoxDecoration(
  //               border: Border.all(color: kBioSecondary, width: 1.5),
  //               borderRadius: BorderRadius.circular(7)),
  //           padding: const EdgeInsets.all(6),
  //           child: SvgPicture.asset("images/plus.svg"),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void initData() {
    this.idProof = BlocProvider.of<VerifyBloc>(context).idProof;
    this.localImagePaths =
        BlocProvider.of<VerifyBloc>(context).localDocImagePaths;
  }
}
