import 'package:makemymarry/base_event_state.dart';
import 'package:makemymarry/datamodels/notification_response.dart';

class NotificationState extends BaseEventState {}

class NotificationIdleState extends NotificationState {

  final List<Notification> data;

  NotificationIdleState({required this.data});

}

class NotificationLoadingState extends NotificationState {}

class NotificationEmptyState extends NotificationState {}

class NotificationErrorState extends NotificationState {}

