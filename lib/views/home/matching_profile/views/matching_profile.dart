import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/home/filter_screens/filter_screen.dart';
import 'package:makemymarry/views/home/matching_profile/bloc/matching_profile_bloc.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import '../../../../utils/buttons.dart';
import '../bloc/matching_profile_event.dart';
import '../bloc/matching_profile_state.dart';
import 'matching_profile_grid.dart';
import 'matching_profile_stack.dart';

class MatchingProfileScreen extends StatelessWidget {
  const MatchingProfileScreen({
    Key? key,
    required this.list,
    this.filter = ProfilesFilter.recommendedProfile,
    this.isTopLevel = true,
  }) : super(key: key);

  final ProfilesFilter filter;
  final List<MatchingProfile> list;
  final bool isTopLevel;
  final String selectedAsset = 'images/icons/shuffle-icon.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray5,
      appBar: !isTopLevel
          ? MmmButtons.appBarCurved('Search', context: context)
          : null,
      body: BlocProvider<MatchingProfileBloc>(
        create: (context) =>
            MatchingProfileBloc(getIt<UserRepository>(), list, filter),
        child: Builder(
          builder: (context) {
            return BlocConsumer<MatchingProfileBloc, MatchingProfileState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Container(
                  height: MediaQuery.of(context).size.height - 72,
                  width: MediaQuery.of(context).size.width,
                  color: gray5,
                  child: Stack(
                    children: [
                      if (state is MatchingProfileInitialState)
                        !state.isStack
                            ? ProfilesGridView(

                                list: state.list, isLoading: state is OnLoading)
                            : MatchingProfileStackView(
                                list: state.list,
                              ),
                      if (state is OnGotProfiles)
                        !state.isStack
                            ? ProfilesGridView(

                                list: state.list, isLoading: state is OnLoading)
                            : MatchingProfileStackView(
                                list: state.list,
                              ),
                      Container(
                        margin: new EdgeInsets.symmetric(
                            vertical: !isTopLevel ? 12 : 48.0),
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                BlocProvider.of<MatchingProfileBloc>(context)
                                    .add(ToggleView());
                              },
                              child: Container(
                                height: 44,
                                width: 44,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.85),
                                    borderRadius: BorderRadius.circular(6)),
                                child: SvgPicture.asset(
                                  !state.isStack
                                      ? "images/stack.svg"
                                      : "images/grid_view.svg",

                                  color: kShadowColorForGrid,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(

                              child: !state.isStack
                                  ? buildScreenHeader(
                                      state.currentFilter,
                                    )
                                  : Container(height: 44),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            InkWell(
                              onTap: () {
                                var bloc = BlocProvider.of<MatchingProfileBloc>(
                                    context);
                                showDialog(
                                  barrierColor: Colors.black26,
                                  context: context,
                                  builder: (context) {
                                    return FiltersDialog(
                                        bloc: bloc,
                                        isStack: state.isStack,
                                        currentFilter: state.currentFilter);

                                  },
                                );
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child:
                                    state.currentFilter.asset.split('.').last ==
                                            'png'
                                        ? Image.asset(state.currentFilter.asset)
                                        : SvgPicture.asset(
                                            state.currentFilter.asset),
                              ),

                            )
                          ],
                        ),
                      ),
                      if (state is OnLoading)

                        // MmmWidgets.buildLoader(context,
                        //     color: Colors.transparent)
                        SingleChildScrollView(
                          child: SkeletonLoader(
                            builder: !state.isStack
                                ? ProfilesGridView(
                                    list: list, isLoading: state is OnLoading)
                                : MatchingProfileStackView(
                                    list: list,
                                  ),
                            //  ),
                            items: 2,
                            highlightColor: Colors.grey,
                            direction: SkeletonDirection.ltr,
                          ),
                        )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget buildScreenHeader(ProfilesFilter filter) {
    return Container(
      height: 44,
      //margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color.fromARGB(174, 181, 178, 178))),
      child: Row(
        children: [
          filter.asset.split(".").last == 'png'
              ? Image.asset(
                  filter.asset,
                  color: Colors.black,
                  fit: BoxFit.cover,
                  height: 24.0,
                  width: 24.0,
                )
              : SvgPicture.asset(
                  filter.asset,
                  color: Colors.black,
                  height: 40.0,
                  width: 40.0,
                ),
          SizedBox(
            width: 12,
          ),

          Flexible(
            child: Text(
              filter.label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.clip,
              softWrap: true,
              style:
                  TextStyle(fontFamily: "MakeMyMarrySemiBold", color: kDark5),
            ),
          ),
        ],
      ),
    );
  }

  void navigateToFilter(BuildContext context) async {
    var result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Filter(userRepository: getIt<UserRepository>())));
  }
}

class FiltersDialog extends StatelessWidget {
  const FiltersDialog(
      {Key? key,
      required this.bloc,
      required this.isStack,
      required this.currentFilter})

      : super(key: key);

  final MatchingProfileBloc bloc;
  final bool isStack;
  final ProfilesFilter currentFilter;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Dialog(
            insetPadding: const EdgeInsets.all(0),
            elevation: 0,
            backgroundColor:  Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(

              margin: EdgeInsets.only(top: 56),
              width: 25,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...ProfilesFilter.values
                      .map((e) => FilterPopupTile(
                            filter: e,
                            bloc: this.bloc,
                            isStack: this.isStack,
                            selected: this.currentFilter == e,
                          ))
                      .toList(),
                ],
              ),
            )),
      ],
    );

  }
}

class FilterPopupTile extends StatelessWidget {
  const FilterPopupTile({
    Key? key,
    required this.filter,
    required this.bloc,
    required this.isStack,
    required this.selected,
  }) : super(key: key);


  final ProfilesFilter filter;
  final bool isStack;
  final MatchingProfileBloc bloc;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigatorKey.currentState?.pop();
        bloc.add(FetchProfiles(filter: filter, isStack: isStack));
      },
      child: Container(
margin: EdgeInsets.all(4),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: selected ? Color(0xffFCDDEC) : Colors.transparent,
            border: Border.all(color: selected ? kInputBorder : Color.fromARGB(118, 158, 158, 158)),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            filter.asset.split(".").last == 'png'
                ? Image.asset(
                    filter.asset,
                    height: 24,
                    width: 24,
                  )
                : SvgPicture.asset(filter.asset),

            SizedBox(
              width: 20,
            ),
            Flexible(
              child: Text(
                filter.label,
                maxLines: 1,
                overflow: TextOverflow.clip,
                softWrap: true,
                style: MmmTextStyles.bodyMediumSmall(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum ProfilesFilter {
  recommendedProfile,
  onlineMembers,
  premiumMembers,
  profileVisitor,
  recentlyViewed
}

extension ProfilesFilterExtension on ProfilesFilter {
  String get label {
    switch (this) {
      case ProfilesFilter.recommendedProfile:
        return "Recommended Profile";
      case ProfilesFilter.onlineMembers:
        return "Online Members";
      case ProfilesFilter.premiumMembers:
        return "Premium Members";
      case ProfilesFilter.profileVisitor:
        return "Profile Visitors";
      case ProfilesFilter.recentlyViewed:
        return "Recently Viewed";
    }
  }

  String get asset {
    switch (this) {
      case ProfilesFilter.recommendedProfile:
        return "images/recomendedprofiles.png";
      case ProfilesFilter.onlineMembers:
        return "images/onlinemembers.png";
      case ProfilesFilter.premiumMembers:
        return "images/crown.png";
      case ProfilesFilter.profileVisitor:
        return "images/profilevisitor.png";
      case ProfilesFilter.recentlyViewed:
        return "images/recentlyviewed.png";
    }
  }
}
