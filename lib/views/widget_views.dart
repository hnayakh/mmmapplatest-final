import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/icons.dart';

class WidgetView extends StatefulWidget {
  final int pos;
  final String title;

  const WidgetView({Key? key, required this.pos, required this.title})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WidgetViewState();
  }
}

class WidgetViewState extends State<WidgetView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: buildUi(),
      ),
    );
  }

  Widget buildUi() {
    switch (widget.pos) {
      case 0:
        return MmmButtons.primaryButton(widget.title, () {});
        break;
      case 1:
        return MmmButtons.enabledRedButton328x50bodyMedium('Connect via Email');
        break;
      case 2:
        return MmmButtons.enabledRedButton328x50heading5('Connect via OTP');
        break;
      case 3:
        return MmmButtons.enabledRedButton50bodyMedium('Resend OTP');
        break;
      case 4:
        return MmmButtons.enabledRedButtonbodyMedium(50, 'Sign in');
        break;
      case 5:
        return MmmButtons.enabledRedButton280x42heading6('Continue');
        break;
      case 6:
        return MmmButtons.disabledGreyButton(50, 'Send OTP');
        break;
      case 7:
        return MmmButtons.facebookSigninButton();
        break;
      case 8:
        return MmmButtons.googleSigninButton();
        break;
      case 9:
        return MmmButtons.facebookSignupButton();
        break;
      case 10:
        return MmmButtons.googleSignupButton();
        break;
      case 11:
        return MmmButtons.emailButton();
        break;
      case 12:
        return MmmButtons.cancelButtonForgotPassword();
        break;
      case 13:
        return MmmButtons.confirmButtonForgotPassword();
        break;
      case 14:
        return MmmButtons.habitsEnabled(
            50, 152, 'images/Veg2.svg', 'Vegeterian');
        break;
      case 15:
        return MmmButtons.habitsDisabled(
            50, 152, 'images/Veg2.svg', 'Vegeterian');
        break;
      case 16:
        return MmmButtons.changePasswordSidebarNavigation();
        break;
      case 17:
        return MmmButtons.logoutSidebarNavigation();
        break;
      case 18:
        return MmmButtons.deleteAccountSidebarNavigation();
        break;
      case 19:
        return MmmButtons.searchScreenButtons(
            'images/online.svg', 'Online Members');
        break;
      case 20:
        return MmmButtons.virtualDateMeetScreen();
        break;
      case 21:
        return MmmButtons.cancelButtonBookYourDate();
        break;
      case 22:
        return MmmButtons.cancelButtonMeet();
        break;
      case 23:
        return MmmButtons.cancelButtonBookyourlocation();
        break;
      case 24:
        return MmmButtons.rescheduleButtonMeet();
        break;
      case 25:
        return MmmButtons.preferenceFliterScreen('Marital status');
        break;
      case 26:
        return MmmButtons.acceptInterestScreen(() {});
        break;
      case 27:
        return MmmButtons.cancelButtonInterestScreen(() {});
        break;
      case 28:
        return MmmButtons.rejectButtonInterestScreen(() {});
        break;
      case 29:
        return MmmButtons.verifyAccountFliterScreen(context);
        break;
      case 30:
        return MmmButtons.interestSelected();
        break;
      case 31:
        return MmmIcons.heart(gray7);
        break;
      case 32:
        return MmmIcons.meet(context);
        break;
      case 33:
        return MmmIcons.cancel();
        break;
      case 34:
        return MmmIcons.connect();
        break;
      default:
        return Container();
    }
  }
}
