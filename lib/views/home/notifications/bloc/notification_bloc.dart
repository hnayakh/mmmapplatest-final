
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/views/home/notifications/bloc/notification_event.dart';
import 'package:makemymarry/views/home/notifications/bloc/notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvents, NotificationState>{
  NotificationBloc(this.userRepository):super(NotificationEmptyState()){
    add(GetListOfNotifications());
  }

  final UserRepository userRepository;

  @override
  Stream<NotificationState> mapEventToState(NotificationEvents event) async* {
    yield NotificationLoadingState();
    if(event is GetListOfNotifications){
      try {
        var res = await this.userRepository.getNotifications(
            this.userRepository.useDetails!.id);
        yield NotificationIdleState(data: res.data);
      }catch(e){
        yield NotificationErrorState();
      }
    }
  }
}