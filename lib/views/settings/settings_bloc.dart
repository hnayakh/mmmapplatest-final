import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/views/meet/bloc/meet_form_state.dart';

import 'settings_state.dart';

class SettingsBloc extends Cubit<SettingsState> {
  SettingsBloc() : super(SettingsState.initial()) {
    getSettings();
  }

  final UserRepository userRepository = getIt<UserRepository>();

  Future<void> getSettings() async {
    try {
      emit(state.copyWith(viewState: CustomFormState.loading));
      var res = await userRepository.getSettings();
      if (res.status == 'SUCCESS' && res.data != null) {
        emit(state.copyWith(viewState: CustomFormState.idle, data: res.data!));
      } else {
        emit(state.copyWith(
            viewState: CustomFormState.error,
            message: 'Something went wrong. Please try again later!!!'));
      }
    } catch (e) {
      emit(state.copyWith(
          viewState: CustomFormState.error, message: e.toString()));
    }
  }

  Future<void> updateSettings({
    bool? showEmail,
    bool? showPhone,
    bool? isHidden,
    bool? isNotification,
  }) async {
    try {
      emit(state.copyWith(viewState: CustomFormState.uploading));
      var res = await userRepository.updateSettings(
          showEmail: showEmail ?? state.settings.showEmail,
          showPhone: showPhone ?? state.settings.showPhone,
          isHidden: isHidden ?? state.settings.isHidden,
          isNotification: isNotification ?? state.settings.isNotification);
      if (res.status == 'SUCCESS' && res.data != null) {
        emit(state.copyWith(viewState: CustomFormState.idle, data: res.data!, message: 'Settings Updated.'));
      } else {
        emit(state.copyWith(
            viewState: CustomFormState.error,
            message: 'Something went wrong. Please try again later!!!'));
      }
    } catch (e) {
      emit(state.copyWith(
          viewState: CustomFormState.error, message: e.toString()));
    }
  }
}
