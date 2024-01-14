import 'package:makemymarry/base_event_state.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/views/home/matching_profile/views/matching_profile.dart';

import '../../../../datamodels/martching_profile.dart';

class MatchingProfileEvent extends BaseEventState {}



class GetProfileDetails extends MatchingProfileEvent {
  final MatchingProfile profile;
  GetProfileDetails(this.profile);
}
class ToggleView extends MatchingProfileEvent {

}


class OnSearchByMMID extends MatchingProfileEvent {
  final String? mmmId;
  OnSearchByMMID(this.mmmId);
}

class FetchProfiles extends MatchingProfileEvent {
  final ProfilesFilter filter;
  final bool isStack;

  FetchProfiles({required this.filter, required this.isStack});
}

class ChangeProposalStatus extends MatchingProfileEvent {
  final ProposalStatus status;
  final MatchingProfile profile;
  ChangeProposalStatus(this.status, this.profile);
}
