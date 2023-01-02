import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/views/connect_pages/call/in_app_call_event.dart';
import 'package:makemymarry/views/connect_pages/call/in_app_call_state.dart';

class InAppCallBloc extends Bloc<InAppCallEvent,InAppCallState>{
  final UserRepository userRepository;
  final String name, destinationUserId, image;

  InAppCallBloc(this.userRepository, this.name, this.destinationUserId, this.image) : super(InAppCallInitialState());

  @override
  Stream<InAppCallState> mapEventToState(InAppCallEvent event)async* {
  }
}