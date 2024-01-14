import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/meet/bloc/meet_form_state.dart';
import 'package:makemymarry/views/settings/settings_bloc.dart';
import 'package:makemymarry/views/settings/settings_state.dart';

class Hide extends StatelessWidget {
  const Hide({Key? key}) : super(key: key);
  static Route<dynamic> getRoute() => MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (_) => SettingsBloc(),
        child: Hide(),
      ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('Hide/Deactivate', context: context),
      body: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state.viewState == CustomFormState.success ||
              state.viewState == CustomFormState.success) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message ?? ""),
              backgroundColor: state.viewState == CustomFormState.success
                  ? kSuccess
                  : kError,
            ));
          }
        },
        builder: (context, state) {
          if (state.viewState == CustomFormState.loading ||
              state.viewState == CustomFormState.uploading) {
            return MmmWidgets.buildLoader(context);
          }
          return Container(
            padding: const EdgeInsets.all(10),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 62,
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.symmetric(
                        horizontal: BorderSide(color: kBorder),
                        vertical: BorderSide(color: kBorder)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Hide/Deactive",
                        style: MmmTextStyles.bodyMediumNotification(
                            textColor: kDark5),
                      ),
                      Container(
                        child: FlutterSwitch(
                          width: 50.0,
                          height: 30.0,
                          activeColor: Colors.pink,
                          valueFontSize: 30.0,
                          toggleSize: 20.0,
                          value: state.settings.isHidden,
                          borderRadius: 30.0,
                          padding: 3.0,
                          onToggle: (val) {
                            context
                                .read<SettingsBloc>()
                                .updateSettings(isHidden: val);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
