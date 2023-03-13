import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/profilescreens/occupation/views/occupation.dart';
import 'package:makemymarry/views/profilescreens/religion/bloc/religion_bloc.dart';
import 'package:makemymarry/views/profilescreens/religion/bloc/religion_event.dart';
import 'package:makemymarry/views/profilescreens/religion/views/religion_bottom_sheet.dart';
import 'package:makemymarry/views/profilescreens/religion/views/subcast_bottom_sheet.dart';

import '../../../stackviewscreens/sidebar screens/my_profile/myprofile.dart';
import '../bloc/religion_state.dart';
import 'cast_bottom_sheet.dart';
import 'gothra_bottom_sheet.dart';
import 'mother_tongue_bottom_sheet.dart';

class Religion extends StatelessWidget {
  final UserRepository userRepository;
  final bool toUpdate;

  const Religion(
      {Key? key, required this.userRepository, this.toUpdate = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReligionBloc(userRepository),
      child: ReligionScreen(
        toUpdate: toUpdate,
      ),
    );
  }
}

class ReligionScreen extends StatefulWidget {
  final bool toUpdate;

  const ReligionScreen({super.key, required this.toUpdate});
  @override
  State<StatefulWidget> createState() {
    return ReligionScreenState();
  }
}

class ReligionScreenState extends State<ReligionScreen> {
  String religiontext = 'Select your religion';

  String casttext = 'Select your cast';

  String subcasttext = 'Select your sub cast';

  String mothertonguetext = 'Select your mother tongue';

  String gothratext = 'Select your gothra';

  SimpleMasterData? religion;
  dynamic subCaste;
  late CastSubCast cast;
  SimpleMasterData? motherTongue;
  late dynamic gothra;
  Manglik? isManglik;
  late UserDetails userDetails;
  @override
  Widget build(BuildContext context) {
    this.userDetails =
        BlocProvider.of<ReligionBloc>(context).userRepository.useDetails!;
      BlocProvider.of<ReligionBloc>(context)
          .add(onReligionDataLoad(userDetails.id));
    BlocProvider.of<ReligionBloc>(context).add(GetUserReligionMasterData());
    return Scaffold(
      body: BlocConsumer<ReligionBloc, ReligionState>(
        builder: (context, state) {
          initData();
          return Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  child: buildForm(context),
                ),
              ),
              Positioned(
                child: widget.toUpdate
                    ? InkWell(
                        onTap: () {
                          BlocProvider.of<ReligionBloc>(context).add(
                              UpdateReligion(
                                  this.motherTongue,
                                  this.gothra,
                                  this.isManglik!,
                                  this.religion,
                                  this.subCaste,
                                  widget.toUpdate));
                        },
                        child: MmmIcons.saveIcon(),
                      )
                    : InkWell(
                        onTap: () {
                          BlocProvider.of<ReligionBloc>(context).add(
                              UpdateReligion(
                                  this.motherTongue,
                                  this.gothra,
                                  this.isManglik!,
                                  this.religion,
                                  this.subCaste,
                                  widget.toUpdate));
                        },
                        child: MmmIcons.rightArrowEnabled(),
                      ),
                bottom: 24,
                right: 24,
              ),
              state is OnReligionLoading
                  ? MmmWidgets.buildLoader(context)
                  : Container()
            ],
          );
        },
        listener: (context, state) {
          if (state is OnError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: kError,
            ));
          }
          if (state is MoveToCarrer) {
            navigateToCarrer();
          }
          if (state is OnNavigationToMyProfiles) {
            navigateToMyProfile();
            // navigateToHabits();
          }
        },
      ),
    );
  }

  Widget buildForm(BuildContext context) {
    return Container(
      child: Column(
        children: [
          MmmButtons.appBarCurved('Religion', context: context),
          Container(
            padding: kMargin16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MmmButtons.categoryButtons(
                    'Religion',
                    religion != null && religion!.title != ''
                        ? '${religion!.title}'
                        : 'Select your religion',
                    'Select your religion',
                    'images/rightArrow.svg', action: () {
                  selectReligion(context);
                }),
                // SizedBox(
                //   height: 24,
                // ),
                // MmmButtons.categoryButtons(
                //     'Caste',
                //     cast != null ? '${cast!.cast}' : 'Select your caste',
                //     'images/rightArrow.svg', action: () {
                //   selectCast(context);
                // }),
                BlocProvider.of<ReligionBloc>(context).checkCaste()
                    ? Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 24,
                            ),
                            MmmButtons.categoryButtons(
                                'Caste',
                                // cast.subCasts.length != 0
                                this.subCaste != null &&
                                        this.subCaste.length > 0
                                    ? this.subCaste
                                    : 'Select your caste',
                                'Select your caste',
                                'images/rightArrow.svg', action: () {
                              print("religion$religion");
                              if (religion != null) selectSubCast(context);
                            })
                          ],
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 24,
                ),
                MmmButtons.categoryButtons(
                    'Mother Tongue',
                    motherTongue != null && motherTongue!.title != ''
                        ? '${motherTongue!.title}'
                        : 'Select your mother tongue',
                    'Select your mother tongue',
                    'images/rightArrow.svg', action: () {
                  selectMotherToungue(context);
                }),
                this.religion != null &&
                        this.religion!.title.toLowerCase().contains("hindu")
                    ? Column(
                        children: [
                          SizedBox(
                            height: 24,
                          ),
                          MmmButtons.categoryButtons(
                              'Gothra',
                              this.gothra != null && this.gothra != ''
                                  ? '$gothra'
                                  : 'Select your gothra',
                              'Select your gothra',
                              'images/rightArrow.svg', action: () {
                            selectGothra(context);
                          }, required: true),
                          SizedBox(
                            height: 24,
                          ),
                        ],
                      )
                    : Container(),
                this.religion != null &&
                        this.religion!.title.toLowerCase().contains("hindu")
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 8),
                            child: Text(
                              'Manglik',
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
                                  child: Radio<Manglik?>(
                                    activeColor: Colors.pinkAccent,
                                    value: Manglik.Yes,
                                    groupValue: this.isManglik,
                                    onChanged: (Manglik? val) {
                                      BlocProvider.of<ReligionBloc>(context)
                                          .add(OnMaglikChanged(Manglik.Yes));
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Yes',
                                  style: MmmTextStyles.bodySmall(
                                      textColor: kDark5),
                                ),
                                SizedBox(
                                  width: 22,
                                ),
                                Transform.scale(
                                  scale: 1.2,
                                  child: Radio<Manglik?>(
                                      activeColor: Colors.pinkAccent,
                                      value: Manglik.No,
                                      groupValue: this.isManglik,
                                      onChanged: (val) {
                                        BlocProvider.of<ReligionBloc>(context)
                                            .add(OnMaglikChanged(Manglik.No));
                                      }),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'No',
                                  style: MmmTextStyles.bodySmall(
                                      textColor: kDark5),
                                ),
                                SizedBox(
                                  width: 22,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          )
        ],
      ),
    );
  }

  void navigateToCarrer() {
    var userRepo = BlocProvider.of<ReligionBloc>(context).userRepository;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Occupations(
              userRepository: userRepo,
            )));
  }

  void navigateToMyProfile() {
    Navigator.of(context).pop();
  }

  void initData() {
    this.isManglik = BlocProvider.of<ReligionBloc>(context).isManglik;
    this.gothra = BlocProvider.of<ReligionBloc>(context).gothra;
    this.motherTongue = BlocProvider.of<ReligionBloc>(context).motherTongue;
    this.cast = BlocProvider.of<ReligionBloc>(context).cast;
    this.subCaste = BlocProvider.of<ReligionBloc>(context).subCaste;
    this.religion = BlocProvider.of<ReligionBloc>(context).religion;
    if (BlocProvider.of<ReligionBloc>(context).profileDetails != null &&
        context.read<ReligionBloc>().state is ReligionDetailsState) {
      if (this.religion == null) {
        var religionName =
            BlocProvider.of<ReligionBloc>(context).profileDetails!.religion;
        var religionId =
            BlocProvider.of<ReligionBloc>(context).profileDetails!.religionId;

        this.religion = SimpleMasterData(religionId, religionName);
      }
      if (this.motherTongue == null) {
        var motherTongueName =
            BlocProvider.of<ReligionBloc>(context).profileDetails!.motherTongue;
        var motherTongueId = BlocProvider.of<ReligionBloc>(context)
            .profileDetails!
            .motherTongueId;
        this.motherTongue = SimpleMasterData(motherTongueId, motherTongueName);
      }
      if (this.gothra == null || this.gothra == "") {
        this.gothra =
            BlocProvider.of<ReligionBloc>(context).profileDetails!.gothra;
      }
      if (this.isManglik == null) {
        this.isManglik =
            BlocProvider.of<ReligionBloc>(context).profileDetails!.manglik;
      }

      if (this.subCaste == null || this.subCaste == "") {
        this.subCaste =
            BlocProvider.of<ReligionBloc>(context).profileDetails!.cast;
      }
    }
  }

  void selectReligion(BuildContext context) async {
    var list = BlocProvider.of<ReligionBloc>(context)
        .userRepository
        .masterData
        .listReligion;
    if (religion != null) {
      list.remove(religion);
      list.insert(0, religion!);
    }
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => ReligionBottomSheet(
              list: list,
              selected: religion,
            ));
    if (result != null && result is SimpleMasterData) {
      BlocProvider.of<ReligionBloc>(context).add(OnReligionSelected(result));
    }
  }

  void selectCast(BuildContext context) async {
    var list = BlocProvider.of<ReligionBloc>(context)
        .userRepository
        .masterData
        .listCastSubCast;
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => CastBottomSheet(
              list: list,
              selected: cast,
            ));
    if (result != null && result is CastSubCast) {
      BlocProvider.of<ReligionBloc>(context).add(OnCastSelected(result));
    }
  }

  void selectSubCast(BuildContext context) async {
    var cast = BlocProvider.of<ReligionBloc>(context)
        .userRepository
        .masterData
        .listCastSubCast
        .firstWhere((element) =>
            element.cast.toLowerCase() == this.religion!.title.toLowerCase());
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => SubCastBottomSheet(
              list: cast.subCasts,
              selected: this.subCaste,
            ));
    if (result != null) {
      print("result$result");
      this.subCaste = result;
      //this.cast = CastSubCast(this.religion!.title, [result]);
      //print("this.cast${this.cast.subCasts[0]}");
      BlocProvider.of<ReligionBloc>(context).add(OnSubCastSelected(result));
    }
  }

  void selectMotherToungue(BuildContext context) async {
    var list = BlocProvider.of<ReligionBloc>(context)
        .userRepository
        .masterData
        .listMotherTongue;
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => MotherTongueBottomSheet(
              list: list,
              selected: this.motherTongue,
            ));
    if (result != null && result is SimpleMasterData) {
      BlocProvider.of<ReligionBloc>(context)
          .add(OnMotherTongueSelected(result));
    }
  }

  void selectGothra(BuildContext context) async {
    var list = BlocProvider.of<ReligionBloc>(context)
        .userRepository
        .masterData
        .listGothra;
    var result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => GothraBottomSheet(
              list: list,
              selected: this.gothra,
            ));
    if (result != null) {
      BlocProvider.of<ReligionBloc>(context).add(OnGothraSelected(result));
    }
  }
}
