import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/helper.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/blocked_users/bloc/blocked_users_bloc.dart';
import 'package:makemymarry/views/blocked_users/bloc/blocked_users_event.dart';
import 'package:makemymarry/views/home/notifications/bloc/notification_bloc.dart';
import 'package:makemymarry/views/home/notifications/bloc/notification_state.dart';

import '../../locator.dart';
import '../../utils/app_helper.dart';
import '../../utils/mmm_enums.dart';
import '../profile_detail_view/profile_view.dart';
import 'bloc/blocked_users_state.dart';

class BlockedUsers extends StatefulWidget {
  static Route<dynamic> getRoute({required UserRepository userRepository}) =>
      MaterialPageRoute(builder: (_) => BlocProvider(
        create: (_) => BlockedUsersBloc(userRepository),
        child: BlockedUsers(
          userRepository: userRepository,
        ),
      ));
  final UserRepository userRepository;
  const BlockedUsers({Key? key, required this.userRepository})
      : super(key: key);

  @override
  _BlockedUsersState createState() => _BlockedUsersState();
}

class _BlockedUsersState extends State<BlockedUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('Blocked Profiles', context: context),
      body: BlocBuilder<BlockedUsersBloc, BlockedUsersState>(
        builder: (context, state) {
          if (state is BlockedUsersLoadingState) {
            return MmmWidgets.buildLoader(context);
          } else if (state is BlockedUsersIdleState) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        state.data[index].user.userImages[0]
                                            .imageUrl,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.28,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.28,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, obj, str) =>
                                            Container(
                                                color: Colors.grey,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.28,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.28,
                                                child: Icon(Icons.error)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 14,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  var data = await getIt<
                                                          UserRepository>()
                                                      .getOtheruserDetails(
                                                          state.data[index].user
                                                              .id,
                                                          ProfileActivationStatus
                                                              .Verified);
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProfileView(
                                                              userRepository: getIt<
                                                                  UserRepository>(),
                                                              profileDetails: data
                                                                  .profileDetails,
                                                            )),
                                                  );
                                                },
                                                child: Text(
                                                  state.data[index].user
                                                      .displayId
                                                      .toUpperCase(),
                                                  textScaleFactor: 1.0,
                                                  style:
                                                      MmmTextStyles.bodyRegular(
                                                          textColor: kPrimary),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                              ),
                                              state.data[index].user
                                                          .activationStatus ==
                                                      ActivationStatus
                                                          .Verified.index
                                                  ? SvgPicture.asset(
                                                      'images/Verified.svg',
                                                      color: kPrimary,
                                                    )
                                                  : Container()
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                              state.data[index].user
                                                  .userAbouts[0].name,
                                              textScaleFactor: 1.0,
                                              style: MmmTextStyles.heading5(
                                                  textColor: kDark5)),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            "${AppHelper.getAgeFromDob(state.data[index].user.userAbouts[0].dateOfBirth.toString())} Years, "
                                            "${state.data[index].user.userAbouts[0].height.isNotNullEmpty ? AppHelper.heightString(double.parse(state.data[index].user.userAbouts[0].height)) : ""}, ${state.data[index].user.userCareers[0].highestEducation}",
                                            textScaleFactor: 1.0,
                                            maxLines: 3,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            style: MmmTextStyles.footer(
                                                textColor: gray3),
                                          ),
                                          Text(
                                            "${state.data[index].user.userCareers[0].city} ${state.data[index].user.userCareers[0].state}  ${state.data[index].user.userCareers[0].country}",
                                            textScaleFactor: 1.0,
                                            maxLines: 2,
                                            style: MmmTextStyles.footer(
                                                textColor: gray3),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.30,
                                        ),
                                        MmmButtons.unblockButton(
                                          'Unblock User',
                                          action: () async {
                                            context
                                                .read<BlockedUsersBloc>()
                                                .add(UnblockUser(
                                                    state.data[index].id));
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Divider()
                              ],
                            ),
                          );
                        },
                        itemCount: state.data.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            indent: 80,
                            endIndent: 25,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text("No BlockedUsers at this moment"));
          }
        },
      ),
    );
  }
}
