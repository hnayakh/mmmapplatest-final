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
  @override
  Widget build(BuildContext context) {
    this.userDetails =
        BlocProvider.of<VerifyBloc>(context).userRepository.useDetails;
    print("USEDETAILS${this.userDetails}");
    return Scaffold(
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
                  onTap: () {
                    print("Hello");
                    showImagePickerDialog();
                  },
                  child: Container(
                    height: 224,
                    width: double.infinity,
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
                          height: 4,
                        ),
                        Text(
                          'Click to upload your document',
                          style: MmmTextStyles.bodySmall(textColor: gray3),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
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

  void initData() {
    this.idProof = BlocProvider.of<VerifyBloc>(context).idProof;
  }
}
