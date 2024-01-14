import 'package:flutter/material.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/text_styles.dart';

class Alert {
  // ignore: avoid_void_async
  static Future<void> message(
    BuildContext context, {
    required String message,
    bool popsAutomatically = true,
    String title = "Message",
    String buttonText = "Ok",
    bool barrierDismissible = true,
    Function? onPressed,
  }) async {
    final theme = Theme.of(context);
    await showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Center(
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              width: MediaQuery.of(context).size.width * .75,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title,
                    style: MmmTextStyles.heading3(),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    message,
                    style: MmmTextStyles.bodyMedium(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  MmmButtons.enabledRedButtonbodyMedium(50, 'Done',
                      action: () {
                        if (popsAutomatically) {
                          Navigator.pop(context);
                        }
                        if (onPressed != null) {
                          onPressed();
                        }
                      }),
                  const SizedBox(height: 16),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
