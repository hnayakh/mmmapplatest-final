// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:makemymarry/datamodels/martching_profile.dart';
// import 'package:makemymarry/locator.dart';
// import 'package:makemymarry/repo/user_repo.dart';
// import 'package:makemymarry/utils/helper.dart';
// import 'package:makemymarry/utils/mmm_enums.dart';
// import 'package:makemymarry/views/meet/bloc/meet_form_bloc.dart';
// import 'package:makemymarry/views/meet/bloc/meet_form_state.dart';
//
// import '../../../utils/colors.dart';
// import '../../../utils/widgets_large.dart';
// import 'meet_location.dart';
// import 'meet_status_screen.dart';
// import 'meet_timing/schedule_meeting_date.dart';
// import 'meet_timing/schedule_meeting_time.dart';
//
// class MeetFormView extends StatelessWidget {
//   const MeetFormView({Key? key}) : super(key: key);
//
//   static Route<dynamic> getRoute({required ProfileDetails profileDetails,Meet? meet}) => PageRouteBuilder(
//         opaque: false,
//         pageBuilder: (_, __, ___) => BlocProvider(
//           create: (_) => MeetFormBloc(
//             userRepository: getIt<UserRepository>(),
//             meet: meet, profileDetails: profileDetails,
//           ),
//           child: MeetFormView(),
//         ),
//       );
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<MeetFormBloc, MeetFormState>(
//       bloc: context.watch<MeetFormBloc>(),
//       listener: (context, state) async {
//
//         print("listenere callled mdkgdngnm================================");
//         switch (state.meetViewState) {
//           case EMeetViewState.initial:
//           case EMeetViewState.typeSheet:
//             {
//               var res = await showModalBottomSheet(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(25),
//                       topRight: Radius.circular(25)),
//                 ),
//                 context: context,
//                 builder: (context) => MmmWidgets.selectMeetWidget(context),
//               );
//               context.read<MeetFormBloc>().submitMeetType(res);
//               break;
//             }
//           case EMeetViewState.selectDatePage:
//             {
//               await Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (_) => BookYourDate(
//                     selectDate: context.read<MeetFormBloc>().submitMeetDate,
//                   ),
//                 ),
//               );
//               if (state.meetType == MeetType.realTime) {
//                 // context.navigate.pop();
//               }
//               break;
//             }
//           case EMeetViewState.selectTimePage:
//             {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (_) => ScheduleMeetingTime(
//                     selectTime: context.read<MeetFormBloc>().submitMeetTime,
//                   ),
//                 ),
//               );
//               break;
//             }
//           case EMeetViewState.selectLocationPage:
//             {
//               await Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (_) => MeetLocationView(
//                     selectLocation:
//                         context.read<MeetFormBloc>().submitMeetLocation,
//                   ),
//                 ),
//               );
//               context.navigate.pop();
//               break;
//             }
//           case EMeetViewState.meetCreated: {
//             break;
//           }
//         }
//       },
//       child: Container(
//         color: Colors.transparent,
//       ),
//     );
//   }
// }
