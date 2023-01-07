import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makemymarry/views/profilescreens/about/bloc/about_bloc.dart';
import 'package:makemymarry/views/signinscreens/signin_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/saurabh/myprofile/add_interest.dart';
import 'package:makemymarry/saurabh/filter_preference.dart';
import 'package:makemymarry/saurabh/partner_preference.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/home/menu/account_menu_bloc.dart';
import 'package:makemymarry/views/profilescreens/about/views/about.dart';
import 'package:makemymarry/views/profilescreens/bio/views/bio.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/profile_preference.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/sidebar_about_screen.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/status_screen.dart';

import '../../../../datamodels/martching_profile.dart';
import '../../../../saurabh/myprofile/about_profile.dart';
import '../../../../utils/widgets_large.dart';
import '../../../home/menu/account_menu_event.dart';
import '../../../home/menu/account_menu_state.dart' as Menu;
import '../../../profilescreens/bio/bloc/bio_bloc.dart';
import '../../../profilescreens/bio/bloc/bio_event.dart';
import '../../../profilescreens/bio/views/image_picker_dialog.dart';

class MyprofileMenuScreen extends StatelessWidget {
  final UserRepository userRepository;
  const MyprofileMenuScreen({Key? key, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BioBloc(userRepository),
      child: MyProfileMenu(userRepository: userRepository),
    );
  }
}

class MyProfileMenu extends StatefulWidget {
  final UserRepository userRepository;
  const MyProfileMenu({Key? key, required this.userRepository})
      : super(key: key);

  @override
  State<MyProfileMenu> createState() => _MyProfileMenuState();
}

class _MyProfileMenuState extends State<MyProfileMenu> {
  // UserRepository userRepository = UserRepository();
  ProfileDetails? profileDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('My Profile', context: context),
      body: SingleChildScrollView(
        child: Container(
          padding: kMargin16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
              ),
              BlocProvider(
                create: (context) => AccountMenuBloc(widget.userRepository),
                child: BlocConsumer<AccountMenuBloc, Menu.AccountMenuState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    print("Akash");
                    print('checkimagestatus$state');
                    if (state is Menu.AccountMenuInitialState) {
                      BlocProvider.of<AccountMenuBloc>(context)
                          .add(FetchMyProfile());
                    }
                    if (state is Menu.OnLoading) {
                      return Scaffold(
                        body: MmmWidgets.buildLoader2(context),
                      );
                    } else if (state is Menu.OnGotProfile) {
                      this.profileDetails =
                          BlocProvider.of<AccountMenuBloc>(context).profileData;
                      // print('saurabh12345 ${profileDetails!.images}');
                      // print('Aaurabh12345 ${profileDetails!.aboutMe}');
                      return Stack(children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.17,
                          width: MediaQuery.of(context).size.width * 0.244,
                          //color: Colors.orangeAccent,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.122,
                            child: ClipOval(
                              child: Image.network(
                                profileDetails!.images[1].toString(),
                                width: double.infinity,
                                fit: BoxFit.cover,
                                height: double.infinity,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 55,
                          right: 25,
                          left: MediaQuery.of(context).size.width * 0.066,
                          child: InkWell(
                            onTap: () {
                              showImagePickerDialog();
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.1,
                              width: MediaQuery.of(context).size.width * 0.1,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: kWhite, shape: BoxShape.circle),
                              child: SvgPicture.asset(
                                'images/camera.svg',
                                color: kDark2,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: MediaQuery.of(context).size.width * 0.36,
                          child: Stack(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kWhite,
                                ),
                              ),
                              Positioned(
                                top: 3,
                                bottom: 3,
                                right: 3,
                                left: 3,
                                child: Container(
                                    decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kPrimary,
                                )),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 130),
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            profileDetails!.name,
                            style: MmmTextStyles.heading4(textColor: kDark5),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 150),
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  profileDetails!.mmId.toUpperCase(),
                                  style: MmmTextStyles.bodyRegular(
                                      textColor: gray3),
                                ),
                                // BlocProvider(
                                //   create: (context) =>
                                //       AboutBloc(widget.userRepository),
                                //   child: BlocConsumer<AboutBloc, AboutState>(
                                //     listener: (context, state) {},
                                //     builder: (context, state) {
                                // TextButton(
                                //   child: Text("Edit",
                                //       style: MmmTextStyles.bodyRegular(
                                //           textColor: kPrimary)),
                                //   onPressed: () {
                                //     onEdit();
                                //   },
                                // )
                                //     },
                                //   ),
                                // )
                              ],
                            ))
                      ]);
                    } else
                      return Container(
                          // child: Text(
                          //   'else',
                          //   style: MmmTextStyles.heading4(textColor: kDark5),
                          // ),
                          );
                  },
                ),
              ),

              SizedBox(
                height: 40,
              ),
              MmmButtons.verifyAccountFliterScreen(context),
              SizedBox(
                height: 16,
              ),

              SizedBox(
                height: 16,
              ),
              // MmmButtons.myProfileButtons('Aboutttfdgdfg', action: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) =>
              //           ABoutProfile(userRepository: widget.userRepository),
              //     ),
              //   );
              // }),
              SizedBox(
                height: 16,
              ),
              MmmButtons.myProfileButtons('Edit partner preference',
                  action: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PartnerPrefsScreen(
                            userRepository: widget.userRepository,
                          )),
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => PartnerPrefsScreen(
                //             userRepository: widget.userRepository,
                //           )),
                // );
                // var userRepo =
                //     BlocProvider.of<SignInBloc>(context).userRepository;
                // Navigator.of(context).pushAndRemoveUntil(
                //     MaterialPageRoute(
                //         builder: (context) => ProfilePreference(
                //               userRepository: userRepository,
                //             )),
                //     (route) => false);
              }),
              SizedBox(
                height: 16,
              ),
              MmmButtons.myProfileButtons('Add interests ', action: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddIterests()),
                );
              }),
              SizedBox(
                height: 16,
              ),
              MmmButtons.myProfileButtons('Change Status', action: () {
                print("Hello");
                // showStatusDilogue(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatusScreen()),
                );
              }),
              SizedBox(
                height: 16,
              ),
              // MmmButtons.myProfileButtons('Matching Percentage', action: () {
              //   Navigator.of(context).push(
              //     MaterialPageRoute(
              //         builder: (context) => MatchingPercentageScreen(
              //             userRepository: userRepository)),
              //   );
              // })
            ],
          ),
        ),
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
    // if (file != null) {
    // print("saurabh uplaod${file!.path}");
    print("saurabh uplaod${file!.path}");
    if (file != null) {
      print("saurabh uplaod 1${file!.path}");

      BlocProvider.of<BioBloc>(context).add(AddImage(file.path));
      print("saurabh uplaod 3${file.path}");
    }
    // }
  }

  void onEdit() {
    print("hekllo222");
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => AboutScreen()));
    //var userRepository = BlocProvider.of<AboutBloc>(context).userRepository;
    print("hekllo333");
    Navigator.of(context).push(
      MaterialPageRoute<AboutBloc>(
        builder: (context) => BlocProvider<AboutBloc>(
          create: (context) => AboutBloc(widget.userRepository),
          child: AboutScreen(),
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

  void showStatusDilogue(BuildContext context) {
    MmmWidgets.selectStatusWidget(context);
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            alignment: Alignment.center,
            height: 450,
            width: 370,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 70),
                Text(
                  "Select your Status",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(height: 30),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15), // Image border
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(42), // Image radius
                    child: Image.asset('images/profile.png', fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Abhishek Sharma",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),
                Row(children: [
                  Container(
                    margin: const EdgeInsets.only(left: 130),
                    child: const Text(
                      "MMY23456",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Container(
                    child: SvgPicture.asset(
                      'images/Verifiedred.svg',
                      height: 20,
                      width: 20,
                    ),
                  ),
                ]),
                const SizedBox(height: 6),
                const Divider(
                  color: Color.fromARGB(248, 233, 217, 217),
                  thickness: 1,
                  indent: 15.0,
                  endIndent: 15.0,
                ),
                const SizedBox(height: 18),
                // ignore: unnecessary_new, sized_box_for_whitespace
                new Container(
                  width: 300,
                  height: 42,
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 182, 40, 87),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),

                      // filled: true,
                      hintStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        height: .5,
                      ),
                      hintText: "Keep me Online",
                    ),
                  ),
                ),
                const SizedBox(height: 17),
                // ignore: unnecessary_new, sized_box_for_whitespace
                new Container(
                  width: 300,
                  height: 42,
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),

                      // filled: true,
                      hintStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        height: .5,
                      ),
                      hintText: "Keep me Offline",
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        //  AlertDialog(
        //   title: new Text("Alert!!"),
        //   content: new Text("You are awesome!"),
        //   actions: <Widget>[
        //     GestureDetector(
        //       child: new Text("OK"),
        //       onTap: () {
        //         Navigator.of(context).pop();
        //       },
        //     ),
        //   ],
        // );
      },
    );
  }
}
