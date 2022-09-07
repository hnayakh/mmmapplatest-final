import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/dimens.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/utils/view_decorations.dart';
import 'package:makemymarry/views/home/menu/account_menu_bloc.dart';
import 'package:makemymarry/views/profilescreens/bio/bio.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/sidebar_about_screen.dart';

class MatchingPercentageScreen extends StatelessWidget {
  final UserRepository userRepository;

  const MatchingPercentageScreen({Key? key, required this.userRepository})
      : super(key: key);

class MatchingPercentageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MatchingPercentageScreenState();
  }
}
class MatchingPercentageScreenState extends State<MatchingPercentageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MmmButtons.appBarCurved('Matching Percentage', context: context),
      body: SingleChildScrollView(
        child: Container(
          padding: kMargin16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
              ),
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.17,
                    width: MediaQuery.of(context).size.width * 0.244,
                    //color: Colors.orangeAccent,
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(width: 0.1),
                        CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.122,
                          child: ClipOval(
                            child: Image.asset(
                              'images/stackviewImage.jpg',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 0.1),
                        Container(
                          height: 45,
                          width: 45,
                          child: Center(
                            child: SvgPicture.asset(
                              "images/heart.svg",
                              color: Colors.white,
                              height: 62,
                              width: 62,
                            ),
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: MmmDecorations.primaryGradient(),
                              border:
                                  Border.all(color: Colors.white, width: 1.2)),
                        ),
                        SizedBox(width: 0.1),
                        CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.122,
                          child: ClipOval(
                            child: Image.asset(
                              'images/stackviewImage.jpg',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ]),
                ],
              ),
              Column(
                children: [
                  Text(
                    'You Match Percentage with Alia is 70%',
                    style: MmmTextStyles.heading4(textColor: kPrimary),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  LinearProgressIndicator(
                    minHeight: 5,
                    //value: controller.value,
                    semanticsLabel: 'Linear progress indicator',
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: "25 to 31",
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Age',
                    suffixIcon: Icon(Icons.verified, color: Colors.green)),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: "5'5 to 6'0",
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Height',
                  suffixIcon: Icon(Icons.cancel, color: Colors.red),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: "Never Married",
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Maritial Status',
                    suffixIcon: Icon(Icons.verified, color: Colors.green)),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: "Private Sector",
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Working With',
                    suffixIcon: Icon(Icons.verified, color: Colors.green)),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: "Hindu",
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Religion',
                    suffixIcon: Icon(Icons.verified, color: Colors.green)),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: "Hindi",
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Mother Toungue',
                    suffixIcon: Icon(Icons.verified, color: Colors.green)),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: "India",
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Country living in',
                    suffixIcon: Icon(Icons.verified, color: Colors.green)),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: "Engineering",
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Education',
                    suffixIcon: Icon(Icons.verified, color: Colors.green)),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: "Great",
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Family Values',
                    suffixIcon: Icon(Icons.verified, color: Colors.green)),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: "Vegeterian",
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'LifeStyle',
                    suffixIcon: Icon(Icons.verified, color: Colors.green)),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: "Above INR 10Lakhs",
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Annaual Income',
                    suffixIcon: Icon(Icons.verified, color: Colors.green)),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
}
