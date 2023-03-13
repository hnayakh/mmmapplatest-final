import 'package:flutter/material.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/views/connects/views/video_call.dart';

import '../../../datamodels/agora_token_response.dart';
import '../../../locator.dart';
import '../../../repo/user_repo.dart';
import '../../../utils/colors.dart';
import '../../../utils/text_styles.dart';
import 'audio_call.dart';

class CallAnswerPage extends StatelessWidget {
  const CallAnswerPage(
      {Key? key,
      required this.callType,
      required this.name,
      required this.userImage,
      required this.token})
      : super(key: key);

  final CallType callType;
  final String name;
  final String userImage;
  final AgoraToken token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(this.userImage),fit: BoxFit.cover, opacity: 0.4)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              foregroundImage: NetworkImage(this.userImage),
              radius: 44,
            ),
            Text(
              this.name,
              style: MmmTextStyles.heading4(textColor: kDark5),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration:
                      BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (this.callType == CallType.audioCall) {
                      navigatorKey.currentState!.pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => AudioCallView(
                            uid: '',
                            imageUrl: this.userImage,
                            userRepo: getIt<UserRepository>(),
                            agoraToken: this.token,
                          ),
                        ),
                      );
                    } else {
                      navigatorKey.currentState!.pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => VideoCallView(
                            uid: '',
                            imageUrl: this.userImage,
                            agoraToken: this.token,
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      this.callType == CallType.audioCall
                          ? Icons.phone
                          : Icons.videocam,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
