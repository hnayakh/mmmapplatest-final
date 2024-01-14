import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/views/meet/bloc/meet_form_state.dart';

const defaultSettingsData = SettingsData(
    id: '',
    createdBy: '',
    updatedBy: 'updatedBy',
    isActive: true,
    status: 1,
    showPhone: true,
    showEmail: true,
    isHidden: true,
    isNotification: true);

class SettingsState {
  final SettingsData settings;
  final CustomFormState viewState;
  final String? message;

  const SettingsState({
    this.settings = defaultSettingsData,
    required this.viewState,
    this.message,
  });

  factory SettingsState.initial() =>
      SettingsState(viewState: CustomFormState.idle);

  SettingsState copyWith({
  SettingsData? data,
  CustomFormState? viewState,
  String? message,
}) => SettingsState(viewState: viewState ?? this.viewState , settings: data ?? this.settings, message:  message ?? this.message);
}
