import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/bloc/splash/splash_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/elevations.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';

class Notifications extends StatefulWidget {
  final UserRepository userRepository;
  const Notifications({Key? key, required this.userRepository})
      : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var index;

  void navigateToNotification() {
    print('Hello');
    // var userRepo = BlocProvider.of<SplashBloc>(context).userRepository;
    // Navigator.of(context).pushReplacement(MaterialPageRoute(
    //     builder: (context) => Notifications(
    //           userRepository: userRepo,
    //         )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('Notifications', context: context),
      body: Container(
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
                          child: Image.asset(
                            'images/bio.jpg',
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )),
                    ),
                    trailing: Text(
                      '8m ago',
                      style: MmmTextStyles.caption(textColor: gray1),
                    ),
                    title: Text(
                      'Header',
                      style: MmmTextStyles.heading5(),
                    ),
                    subtitle: Text(
                      "He'll want to use your yacht, and I don't want this thing smelling",
                      style: MmmTextStyles.bodySmall(),
                    ),
                  );
                },
                itemCount: 8,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              ),
            ),
            // Row(
            //   children: [
            //     Expanded(
            //         child: (Container(
            //       height: 68,
            //       decoration: BoxDecoration(boxShadow: [
            //         MmmShadow.elevationStack(),
            //       ]),
            //       padding: EdgeInsets.only(top: 8, bottom: 8),
            //       child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceAround,
            //           children: [
            //             MmmWidgets.bottomBarUnits('images/Search.svg', 'Search',
            //                 index == 0 ? kPrimary : gray3, action: () {
            //               setColor(0);
            //             }),
            //             MmmWidgets.bottomBarUnits(
            //                 'images/filter2.svg',
            //                 'Filter',
            //                 index == 1 ? kPrimary : gray3, action: () {
            //               setColor(1);
            //             }),
            //             MmmWidgets.bottomBarUnits(
            //                 'images/connect.svg',
            //                 'Connect',
            //                 index == 2 ? kPrimary : gray3, action: () {
            //               setColor(2);
            //             }),
            //             MmmWidgets.bottomBarUnits(
            //                 'images/Search.svg',
            //                 'Notifications',
            //                 index == 3 ? kPrimary : gray3, action: () {
            //               setColor(3);
            //             }),
            //             MmmWidgets.bottomBarUnits('images/menu.svg', 'More',
            //                 index == 4 ? kPrimary : gray3, action: () {
            //               setColor(4);
            //             })
            //           ]),
            //     ))),
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  void setColor(int indexCode) {
    setState(() {
      index = indexCode;
    });
  }
}
