import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/helper.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/home/matching_profile/bloc/matching_profile_bloc.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import '../bloc/matching_profile_event.dart';

class ProfilesGridView extends StatelessWidget {
  final List<MatchingProfile> list;

  final bool isLoading;
  const ProfilesGridView(
      {Key? key, required this.list, required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: kMargin16,
        child: list.isNotNullEmpty
            ? isLoading
                ? SingleChildScrollView(
                    child: SkeletonLoader(
                      builder: gridViewContent(),
                      //  ),
                      items: 2,
                      highlightColor: Colors.grey,
                      direction: SkeletonDirection.ltr,
                    ),
                  )
                : gridViewContent()
            : Center(
                child: Text("No Matching Profiles Found!!!"),
              ),
      ),
    );
  }

  Widget gridViewContent() {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 60),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 4 / 5,
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16),
      itemBuilder: (context, index) {
        MatchingProfile item = list[index];
        return InkWell(
          child: Card(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  child: Image.network('${item.imageUrl}',
                      width: (MediaQuery.of(context).size.width - 48) / 2,
                      fit: BoxFit.cover,
                      errorBuilder: (context, obj, str) => Container(
                          color: Colors.grey, child: Icon(Icons.error))),
                  borderRadius: BorderRadius.circular(4),
                ),
                item.activationStatus == ProfileActivationStatus.Verified
                    ? Positioned(
                        child: Container(
                          child: SvgPicture.asset(
                            "images/Verified.svg",
                            color: kSecondary,
                          ),
                        ),
                        top: 2,
                        right: 2,
                      )
                    : Container(),
                Positioned(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${item.name}, ${AppHelper.getAgeFromDob(item.dateOfBirth)} yrs",
                          style: MmmTextStyles.heading6(textColor: gray6),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "images/location.svg",
                              color: Colors.white,
                              width: 16,
                              height: 16,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                "${item.city}, ${item.state}",
                                textScaleFactor: 1.0,
                                style: MmmTextStyles.bodySmall(
                                  textColor: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    width: (MediaQuery.of(context).size.width - 48) / 2,
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(50),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                      ),
                    ),
                  ),
                  bottom: 0,
                )
              ],
            ),
          ),
          onTap: () {
            BlocProvider.of<MatchingProfileBloc>(context)
                .add(GetProfileDetails(list[index]));
          },
        );
      },
      itemCount: list.length,
    );
  }
}
