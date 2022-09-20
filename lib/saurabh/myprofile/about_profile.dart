import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makemymarry/utils/colors.dart';

import '../../datamodels/martching_profile.dart';
import '../../repo/user_repo.dart';
import '../../utils/buttons.dart';
import '../../utils/elevations.dart';
import '../../utils/text_styles.dart';
import '../../utils/view_decorations.dart';
import '../../views/profilescreens/bio/bio_bloc.dart';
import '../../views/profilescreens/bio/bio_event.dart';
import '../../views/profilescreens/bio/bio_state.dart';
import '../../views/profilescreens/bio/image_picker_dialog.dart';
import '../hexcolor.dart';

class ABoutProfile extends StatelessWidget {
  final UserRepository userRepository;

  const ABoutProfile({Key? key, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BioBloc(
        userRepository,
      ),
      child: AboutProfileScreen(),
    );
  }
}

class AboutProfileScreen extends StatefulWidget {
  const AboutProfileScreen({Key? key}) : super(key: key);

  @override
  State<AboutProfileScreen> createState() => _AboutProfileScreenState();
}

class _AboutProfileScreenState extends State<AboutProfileScreen> {
  ProfileDetails? profileDetails;
  var bioController = TextEditingController();
  List<String> localImagePaths = [];
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var primaryColor = HexColor('C9184A');
    return Scaffold(
        appBar: MmmButtons.appBarCurved('About', context: context),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: BlocConsumer<BioBloc, BioState>(listener: (context, state) {
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
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Updated Successfully"),
                  backgroundColor: Colors.green,
                ));
                bioController.clear();
                Navigator.pop(context);

                // navigateToProfilePreference();
              }
            }, builder: (context, state) {
              this.localImagePaths =
                  BlocProvider.of<BioBloc>(context).localImagePaths;
              return ListView(
                shrinkWrap: true,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    //padding: const EdgeInsets.only(top: 4, left: 4),
                    child: Text(
                      "About me",
                      textScaleFactor: 1.0,
                      style: MmmTextStyles.cardNumber(textColor: kDark5),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextFormField(
                    maxLength: 200,
                    // controller: controller,
                    // textCapitalization: textCapitalization,
                    keyboardType: TextInputType.text,
                    style: MmmTextStyles.bodyRegular(textColor: kDark5),
                    controller: bioController,
                    // cursorColor: kDark5,
                    // obscureText: isPassword,
                    decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: kDark2, width: 1),
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide:
                                BorderSide(color: kInputBorder, width: 1)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        hintText: "A little bit about me",
                        isDense: true,
                        filled: true,
                        fillColor: Colors.white,
                        hintStyle:
                            MmmTextStyles.bodyRegular(textColor: kDark2)),
                    maxLines: 10,
                    enabled: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Photo",
                    textScaleFactor: 1.0,
                    style: MmmTextStyles.cardNumber(textColor: kDark5),
                  ),
                  Container(
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
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  MmmButtons.enabledRedButtonbodyMedium(
                      50, 'Submit your details', action: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    BlocProvider.of<BioBloc>(context)
                        .add(UpdateBio(this.bioController.text));
                  })
                  // Row(
                  //   // crossAxisAlignment: WrapCrossAlignment.start,
                  //   children: [
                  //     Expanded(
                  //       flex: 1,
                  //       child: ClipRRect(
                  //         borderRadius: BorderRadius.circular(10),
                  //         child: Image.network(
                  //           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6eSTakjPRBatCMcm9fiX2KON4RC-Pjox1L2hqotKsmqIZhNaTKCuBUZbHiw6lvms2uwc&usqp=CAU",
                  //           height: 120,
                  //           // width: 120,
                  //           fit: BoxFit.fitWidth,
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Expanded(flex: 1, child: addImageButton())
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       flex: 1,
                  //       child: Container(
                  //         height: 110,
                  //         // width: 50,
                  //         alignment: Alignment.center,
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.grey,
                  //               blurRadius: 5.0,
                  //             ),
                  //           ],
                  //           borderRadius: BorderRadius.circular(10),
                  //         ),
                  //         child: Container(
                  //             decoration: BoxDecoration(
                  //                 border: Border.all(color: Colors.grey),
                  //                 borderRadius: BorderRadius.circular(5)),
                  //             child: Icon(Icons.add)),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Expanded(
                  //       flex: 1,
                  //       child: Container(
                  //         height: 110,
                  //         // width: 50,
                  //         alignment: Alignment.center,
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.grey,
                  //               blurRadius: 5.0,
                  //             ),
                  //           ],
                  //           borderRadius: BorderRadius.circular(10),
                  //         ),
                  //         child: Container(
                  //             decoration: BoxDecoration(
                  //                 border: Border.all(color: Colors.grey),
                  //                 borderRadius: BorderRadius.circular(5)),
                  //             child: Icon(Icons.add)),
                  //       ),
                  //     )
                  //   ],
                  // )
                ],
              );
            })));
  }

  InkWell addImageButton() {
    return InkWell(
      onTap: () {
        showImagePickerDialog();
      },
      child: Container(
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
    if (file != null) {
      BlocProvider.of<BioBloc>(context).add(AddImage(file.path));
    }
  }
}
