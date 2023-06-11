import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/utility_service.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/home/notifications/bloc/notification_bloc.dart';
import 'package:makemymarry/views/home/notifications/bloc/notification_state.dart';

class Notifications extends StatefulWidget {
  static Widget getWidget({required UserRepository userRepository}) =>
      BlocProvider(
        create: (_) => NotificationBloc(userRepository),
        child: Notifications(
          userRepository: userRepository,
        ),
      );
  final UserRepository userRepository;
  const Notifications({Key? key, required this.userRepository})
      : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('Notifications'),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoadingState) {
            return MmmWidgets.buildLoader(context);
          } else if (state is NotificationIdleState) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8)),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8)),
                                  child: Image.network(
                                    state.data[index].image,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (a, b, c) =>
                                        Icon(Icons.error),
                                  )),
                            ),
                            trailing: Text(
                              DateTime.now()
                                  .difference(state.data[index].createdAt)
                                  .formatDuration(),
                              style: MmmTextStyles.caption(textColor: gray1),
                            ),
                            title: Text(
                              state.data[index].header,
                              style: MmmTextStyles.heading5(),
                            ),
                            subtitle: Text(
                              state.data[index].message,
                              style: MmmTextStyles.bodySmall(),
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
            return Center(child: Text("No Notifications at this moment"));
          }
        },
      ),
    );
  }
}
