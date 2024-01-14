import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:makemymarry/datamodels/interests_model.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/helper.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/connect_pages/call/in_app_call.dart';

import '../../../../../app/bloc/app_bloc.dart';
import '../../../../../locator.dart';
import '../../../../../repo/chat_repo.dart';
import '../../../../chat_room/chat_page.dart';
import '../../../../profile_detail_view/profile_view.dart';
import 'bloc/accepted_bloc.dart';
import 'bloc/accepted_events.dart';
import 'bloc/accepted_states.dart';

class Accepted extends StatelessWidget {
  final List<ActiveInterests> listAccepted;
  final UserRepository userRepository;

  const Accepted(
      {Key? key, required this.listAccepted, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AcceptedBloc(userRepository),
      child: AcceptedScreen(),
    );
  }
}

class AcceptedScreen extends StatelessWidget {
  //const AcceptedScreen({Key? key}) : super(key: key);
  late List<ActiveInterests> listAccepted;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<AcceptedBloc, AcceptedStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          initData(context);
          if (state is AcceptedInitialState) {
            BlocProvider.of<AcceptedBloc>(context)
                .add(CheckAcceptedListIsEmpty());
          }
          if (state is AcceptedListIsEmptyState) {
            return Center(
              child: Text(
                'No requests accepted yet..',
                style: TextStyle( fontFamily: 'MakeMyMarry', color: kPrimary),
              ),
            );
          }
          return Container(
              color: Colors.white24,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: buildList(context),
                    ),
                  ),
                  state is OnLoading
                      ? MmmWidgets.buildLoader2(context)
                      : Container()
                ],
              ));

        },
      ),
    );
  }

  List<Widget> buildList(BuildContext context) {
    List<Widget> list = [];
    for (var index = 0; index < listAccepted.length; index++) {
      list.add(Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(listAccepted[index].user.imageURL,
                      height: MediaQuery.of(context).size.width * 0.28,
                      width: MediaQuery.of(context).size.width * 0.28,
                      fit: BoxFit.cover,
                      errorBuilder: (context, obj, str) => Container(
                          color: Colors.grey, child: Icon(Icons.error))),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              var data = await getIt<UserRepository>()
                                  .getOtheruserDetails(
                                      listAccepted[index].user.id,
                                      ProfileActivationStatus.Verified);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProfileView(
                                        userRepository: getIt<UserRepository>(),
                                        profileDetails: data.profileDetails,
                                      )));
                            },
                            child: Text(
                              listAccepted[index].user.displayId.toUpperCase(),
                              textScaleFactor: 1.0,
                              style: MmmTextStyles.bodyRegular(
                                  textColor: kPrimary),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04,
                          ),
                          listAccepted[index].user.activationStatus ==
                                  ActivationStatus.Verified.index
                              ? SvgPicture.asset(
                                  'images/Verified.svg',
                                  color: kPrimary,
                                )
                              : Container(),
                          Spacer(),
                          Container(
                            child: FutureBuilder<int>(
                              future: getIt<ChatRepo>().getMessageCount(
                                userId: getIt<UserRepository>().useDetails!.id,
                                otherUser: getIt<UserRepository>()
                                            .useDetails!
                                            .id ==
                                        listAccepted[index]
                                            .requestingUserBasicId
                                    ? listAccepted[index].requestedUserBasicId
                                    : listAccepted[index].requestingUserBasicId,
                              ),
                              builder: (context, snapshot) {
                                return (snapshot.hasData &&
                                        ((snapshot.data ?? 0) > 0))
                                    ? Stack(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              Navigator.of(context).push(
                                                  (await ChatPage.getRoute(
                                                      context,
                                                      getIt<UserRepository>()
                                                                  .useDetails!
                                                                  .id ==
                                                              listAccepted[
                                                                      index]
                                                                  .requestingUserBasicId
                                                          ? listAccepted[index]
                                                              .requestedUserBasicId
                                                          : listAccepted[index]
                                                              .requestingUserBasicId)));
                                            },
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              child: Container(
                                                height: 32,
                                                width: 32,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: kLight4),
                                                child: SvgPicture.asset(
                                                  'images/chat.svg',
                                                  height: 18,
                                                  color: kNotify,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Container(
                                              width: 15,
                                              height: 15,
                                              //alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: kPrimary),
                                              child: Text(
                                                snapshot.data?.toString() ??
                                                    "0",
                                                textAlign: TextAlign.center,
                                                style: MmmTextStyles.footer(
                                                    textColor: kLight4),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox();
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        listAccepted[index].user.name,
                        textScaleFactor: 1.0,
                        style: MmmTextStyles.heading5(textColor: kDark5),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "${AppHelper.getAgeFromDob(listAccepted[index].user.dateOfBirth)} Years, ${listAccepted[index].user.height.isNotNullEmpty ? AppHelper.heightString(double.parse(listAccepted[index].user.height)) : ""}, ${listAccepted[index].user.highestEducation}",
                        overflow: TextOverflow.ellipsis,
                        textScaleFactor: 1.0,
                        maxLines: 3,
                        softWrap: true,
                        style: MmmTextStyles.footer(textColor: gray3),
                      ),
                      Text(
                        "${listAccepted[index].user.careerCity}, ${listAccepted[index].user.careerState}, ${listAccepted[index].user.careerCountry}",
                        textScaleFactor: 1.0,
                        maxLines: 2,
                        style: MmmTextStyles.footer(textColor: gray3),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.30,
                    ),
                    // listAccepted[index].user.connectStatus
                    //     ? MmmButtons.connectButton('Call Now', action: () {})
                    //     :
                    MmmButtons.connectButton(
                      'Connect Now',
                      action: () async {
                        if (listAccepted[index].user.connectStatus) {
                          var otherUser = await getIt<ChatRepo>().getChatUser(
                              id: listAccepted[index].user.id);
                          var chatRoom = await getIt<ChatRepo>().getChatRoom(
                              getIt<UserRepository>()
                                  .useDetails!
                                  .id,
                              otherUser);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                                room: chatRoom,
                                userRepo: getIt<UserRepository>(),
                              ),
                            ),
                          );
                        } else {
                          BlocProvider.of<AppBloc>(navigatorKey.currentContext!)
                              .connectNow(
                                  otherUserId:
                                  listAccepted[index].user.id,
                                  onDone: () async {
                                    navigatorKey.currentState?.push(
                                        (await ChatPage.getRoute(
                                            navigatorKey.currentContext!,
                                            listAccepted[index].user.id)));
                                  },
                                  onError: () async {},
                                  profileDetails: listAccepted[index],
                                  context: navigatorKey.currentContext!);
                        }
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
      ));
    }
    return list;
  }

  void initData(BuildContext context) {
    this.listAccepted = BlocProvider.of<AcceptedBloc>(context).listAccepted;
  }

  void navigateToInAppCall(BuildContext context, InterestUser user) {
    var userRepo = BlocProvider.of<AcceptedBloc>(context).userRepository;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => InAppCall(
              userRepository: userRepo,
              image: user.imageURL,
              name: user.name,
              destinationUserId: user.id,
            )));
  }
}
