import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/views/meet/bloc/meet_list_state.dart';

class MeetListBloc extends Cubit<MeetListState> {
  MeetListBloc({required this.userRepository})
      : super(MeetListState.initial()) {
    fetchAllMeets();
  }

  final UserRepository userRepository;

  fetchAllMeets() async {
    try {
      emit(state.copWith(viewState: ViewState.loading));
      var res = await userRepository.fetchALlMeets();
      if (res.status == "SUCCESS" && res.data != null) {
        emit(state.copWith(
            sentMeets: res.data!.activeSent,
            receivedMeets: res.data!.activeInvites,
            activeMeets: res.data!.activeconnections,
            viewState: ViewState.idle,
            message: "Meet fetched successfully."));
      } else {
        emit(state.copWith(
            viewState: ViewState.error, message: "No Meets Found"));
      }
    } catch (e) {
      emit(state.copWith(viewState: ViewState.error, message: e.toString()));
    }
  }

  acceptMeetRequest(Activeconnection meet) async {
    try {
      emit(state.copWith(viewState: ViewState.loading));
      var res = await userRepository.updateMeetStatus(meet: meet, status: 1);
      if (res.status  == "SUCCESS") {
        fetchAllMeets();
      } else {
        fetchAllMeets();
        emit(state.copWith(
            viewState: ViewState.error,
            message: "Something went wrong. Please try again."));
      }
    } catch (e) {
      emit(state.copWith(
          viewState: ViewState.error,
          message: "Something went wrong. Please try again."));
    }
  }

  cancelMeetRequest(Activeconnection meet) async {
    try {
      emit(state.copWith(viewState: ViewState.loading));
      var res = await userRepository.updateMeetStatus(meet: meet, status: 3);
      if (res.status  == "SUCCESS") {
        fetchAllMeets();
      } else {
        fetchAllMeets();
        emit(state.copWith(
            viewState: ViewState.error,
            message: "Something went wrong. Please try again."));
      }
    } catch (e) {
      emit(state.copWith(
          viewState: ViewState.error,
          message: "Something went wrong. Please try again."));
    }
  }

  rejectMeetRequest(Activeconnection meet) async {
    try {
      emit(state.copWith(viewState: ViewState.loading));
      var res = await userRepository.updateMeetStatus(meet: meet, status: 2);
      if (res.status == "SUCCESS") {
        fetchAllMeets();
      } else {
        fetchAllMeets();
        emit(state.copWith(
            viewState: ViewState.error,
            message: "Something went wrong. Please try again."));
      }
    } catch (e) {
      emit(state.copWith(
          viewState: ViewState.error,
          message: "Something went wrong. Please try again."));
    }
  }
}
