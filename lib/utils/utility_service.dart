import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:makemymarry/utils/helper.dart';
import 'package:url_launcher/url_launcher.dart';

final logger = Logger();

class UtilityService {
  // Display a message to the user.

  // Print message on console
  static void cprint(
    String message, {
    dynamic error,
    String? label,
    StackTrace? stackTrace,
    bool enableLogger = true,
  }) {
    if (kDebugMode) {
      // ignore: avoid_print
      if (error != null) {
        logger.e(message, error, stackTrace);
      } else {
        if (enableLogger) {
          logger.i(
            "[${label ?? 'Log'}] ${DateTime.now().toIso8601String().toHMTime} $message",
          );
        } else {
          // ignore: avoid_print
          print("[${label ?? 'Log'}] $message");
        }
      }
    }
  }

  static String encodeStateMessage(String? message) {
    if (message != null) {
      final mess = '$message ##${DateTime.now().microsecondsSinceEpoch}';
      return mess;
    }
    return '';
  }

  static String decodeStateMessage(String? message) {
    if (message != null && message.contains('##')) {
      return message.split('##')[0];
    }
    return '';
  }

  static Future<void> launch(String? url) async {
    if (!url.isNotNullEmpty) {
      return;
    }
    var uri = Uri.tryParse(url!)!;
    if (uri.scheme.isEmpty) {
      uri = Uri.parse('https://$url');
    }

    await launchUrl(uri);
  }
}

extension DurationFormatter on Duration {
  String formatDuration() {
    return this.inDays > 30
        ? '${(this.inDays ~/ 30)} months ago'
        : this.inDays > 0
            ? '${this.inDays}d ago'
            : this.inHours > 0
                ? '${this.inHours}h ago'
                : this.inMinutes > 0
                    ? '${this.inMinutes}m ago'
                    : this.inSeconds > 0
                        ? '${this.inSeconds}secs ago'
                        : "just now";
  }
}
