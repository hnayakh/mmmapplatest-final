import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/profilescreens/bio/image_picker_dialog.dart';

import 'bio_bloc.dart';
import 'bio_event.dart';
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
  var bioController = TextEditingController();
  List<String> localImagePaths = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<BioBloc, BioState>(
      listener: (context, state) {
        if (state is OnProfileSetupCompletion) {
          //navigate to profile screen
          print('profile setup completed');
        }
      },
      builder: (context, state) {
        this.localImagePaths =
            BlocProvider.of<BioBloc>(context).localImagePaths;
        return Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              MmmButtons.appBarCurved('Bio', context: context),
              Expanded(
                  child: Container(
                padding: kMargin16,
                child: Column(
                  children: [
                    buildAboutMeWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Photo',
                              style:
                                  MmmTextStyles.bodyRegular(textColor: kDark5),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Expanded(
                                child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent:
                                          (MediaQuery.of(context).size.width) /
                                              2,
                                      mainAxisExtent: 120,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20),
                              itemBuilder: (context, index) {
                                if (index == this.localImagePaths.length) {
                                  return addImageButton();
                                } else
                                  return Container(
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          child: Image.file(
                                            File(this.localImagePaths[index]),
                                            fit: BoxFit.fill,
                                            width: (MediaQuery.of(context)
                                                    .size
                                                    .width) /
                                                2,
                                            height: 120,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        Positioned(
                                            top: 8,
                                            right: 8,
                                            child: InkWell(
                                              onTap: () {
                                                BlocProvider.of<BioBloc>(
                                                        context)
                                                    .add(RemoveImage(index));
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
                                        borderRadius: BorderRadius.circular(8)),
                                  );
                              },
                              itemCount: this.localImagePaths.length + 1,
                            )),
                          ]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MmmButtons.enabledRedButtonbodyMedium(
                        50, 'Submit your details',
                        action: () {})
                  ],
                ),
              ))
            ]));
      },
    ));
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
                maxLength: 200,
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'A little bit about me ...',
                  hintStyle: MmmTextStyles.bodySmall(textColor: gray4),
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
}
