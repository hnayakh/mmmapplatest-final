import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/views/matching_percentage/matching_percentage_event.dart';
import 'package:makemymarry/views/matching_percentage/matching_percentage_state.dart';

import '../../datamodels/martching_profile.dart';

class MatchingPercentageBloc
    extends Bloc<MatchingPercentageEvent, MatchingPercentageState> {
  final UserRepository userRepository;
  final ProfileDetails profileDetails;

  int matchingPercentage = 0;
  String images = '';
  String userImage = '';
  String name = '';
  List matchingFieldList = [];
  List differentFieldList = [];

  MatchingPercentageBloc(
    this.userRepository,
    this.profileDetails,
  ) : super(MatchingPercentageInitialState());

  @override
  Stream<MatchingPercentageState> mapEventToState(
      MatchingPercentageEvent event) async* {
    if (event is MatchProfile) {
      print("Details...");
      print(profileDetails);
      //yield OnLoading();
      var response =
          await this.userRepository.getMatchPercentage(this.profileDetails.id);

      if (response.status == AppConstants.SUCCESS) {
        this.matchingPercentage = response.percent;
        this.images = this.profileDetails.images[0];
        this.userImage = response.userImage;
        this.name = this.profileDetails.name;
        this.matchingFieldList = response.matchingFields;
        this.differentFieldList = response.differentFields;
        yield OnProfileVisited(this.matchingPercentage, this.images,
            this.matchingFieldList, this.differentFieldList, this.name);
      } else {
        yield OnError(response.message);
      }
    }

    // if (event is MatchProfileImages) {
    //   //yield OnLoading();
    //   var response =
    //       await this.userRepository.getMatchPercentage(this.profileDetails.id);
    //   if (response.status == AppConstants.SUCCESS) {
    //     this.matchingPercentage = response.percent;
    //     yield OnProfileVisited(
    //         this.matchingPercentage, this.profileDetails.images[0]);
    //   } else {
    //     yield OnError(response.message);
    //   }
    // }
  }
}
