import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:makemymarry/views/profilescreens/bio/bio_bloc.dart';
import 'package:makemymarry/views/profilescreens/bio/bio_event.dart';
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
  String docImage = '';
  List<String> localImagePaths = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('Verify your account', context: context),
      body: BlocConsumer<VerifyBloc, VerifyState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          initData();
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
                SizedBox(
                  height: 44,
                ),
                InkWell(
                  onTap: () => {showImagePickerDialog()},
                  child: Container(
                    height: 224,
                    width: double.infinity,
                    //alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: kWhite,
                        boxShadow: [MmmShadow.elevation2()]),
                    child: Container(
                      height: (MediaQuery.of(context).size.height) / 3,
                      child: Flexible(
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent:
                                      (MediaQuery.of(context).size.width) / 2,
                                  mainAxisExtent: 120,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemBuilder: (context, index) {
                            print('saurabhtest ${this.localImagePaths.length}');
                            if (index == this.localImagePaths.length) {
                              return addImageButton();

                              // if (index == 0) {
                              //   return ClipRRect(
                              //     borderRadius: BorderRadius.circular(10),
                              //     child: Image.network(
                              //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6eSTakjPRBatCMcm9fiX2KON4RC-Pjox1L2hqotKsmqIZhNaTKCuBUZbHiw6lvms2uwc&usqp=CAU",
                              //       height: 120,
                              //       // width: 120,
                              //       fit: BoxFit.fitWidth,
                              //     ),
                              //   );
                            } else
                              // return addImageButton();
                              return Container(
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      child: Image.network(
                                        this.localImagePaths[index],
                                        fit: BoxFit.cover,
                                        width: (MediaQuery.of(context)
                                                .size
                                                .width) /
                                            2,
                                        height: 120,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    // Positioned(
                                    //     top: 8,
                                    //     right: 8,
                                    Container(
                                        child: InkWell(
                                      onTap: () {
                                        BlocProvider.of<BioBloc>(context)
                                            .add(RemoveImage(index));
                                      },
                                      child: Container(
                                        child: SvgPicture.asset(
                                          "images/Cross.svg",
                                          color: Colors.white,
                                        ),
                                        width: 18,
                                        height: 18,
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            gradient: MmmDecorations
                                                .primaryGradient(),
                                            borderRadius:
                                                BorderRadius.circular(9)),
                                      ),
                                    ))
                                    //)
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      MmmShadow.elevation3(shadowColor: kShadow)
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                              );
                          },
                          itemCount: this.localImagePaths.length + 1,
                        ),
                      ),
                    ),
                    // child: Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,

                    //   children: [
                    //     SvgPicture.asset('images/filter.svg'),
                    //     SizedBox(
                    //       height: 4,
                    //     ),

                    //     Text(
                    //       'Click to upload your document',
                    //       style: MmmTextStyles.bodySmall(textColor: gray3),
                    //     )
                    //   ],
                    // ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                MmmButtons.enabledRedButtonbodyMedium(50, 'Verify',
                    action: () {})
              ],
            ),
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

  void initData() {
    this.idProof = BlocProvider.of<VerifyBloc>(context).idProof;
    this.localImagePaths = BlocProvider.of<VerifyBloc>(context).localImagePaths;
  }

  InkWell addImageButton() {
    return InkWell(
      onTap: () {
        showImagePickerDialog();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('images/filter.svg'),
          SizedBox(
            height: 4,
          ),
          Text(
            'Click to upload your document',
            style: MmmTextStyles.bodySmall(textColor: gray3),
          )
        ],
      ),
      // child: Container(
      //   decoration: BoxDecoration(
      //       boxShadow: [MmmShadow.elevation3(shadowColor: kShadow)],
      //       color: Colors.white,
      //       borderRadius: BorderRadius.circular(8)),
      //   child: Center(
      //     child: Container(
      //       decoration: BoxDecoration(
      //           border: Border.all(color: kBioSecondary, width: 1.5),
      //           borderRadius: BorderRadius.circular(7)),
      //       padding: const EdgeInsets.all(6),
      //       child: SvgPicture.asset("images/plus.svg"),
      //     ),
      //   ),
      // ),
    );
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

  final ImagePicker _picker = ImagePicker();

  Future pickImages(
    ImageSource source,
  ) async {
    var file = await _picker.pickImage(
      source: source,
      imageQuality: 60,
    );
    print(file);
    if (file != null) {
      //BlocProvider.of<BioBloc>(context).add(AddImage(file.path));
      BlocProvider.of<VerifyBloc>(context).add(IdVerificationEvent(file.path));
    }
  }
}
