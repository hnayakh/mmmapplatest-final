import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/views/home/menu/account_menu_event.dart';
import 'package:makemymarry/views/home/menu/account_menu_state.dart';

class AccountMenuBloc extends Bloc<AccountMenuEvent, AccountMenuState> {
  final UserRepository userRepository;

  ProfileDetails? profileData;

  AccountMenuBloc(this.userRepository) : super(AccountMenuInitialState());

  @override
  Stream<AccountMenuState> mapEventToState(AccountMenuEvent event) async* {
    yield OnLoading();
    if (event is FetchMyProfile) {
      var response = await this.userRepository.getOtheruserDetails(
          userRepository.useDetails!.id,
          ProfileActivationStatus
              .values[userRepository.useDetails!.activationStatus]);
      print('saurabh 1${response.profileDetails.images}');

      print(response);
      if (response.status == AppConstants.SUCCESS) {
        this.profileData = response.profileDetails;
        print('saurabh 2$profileData}');
        yield OnGotProfile();
      } else {
        print('etywgfyuegtwqyuetwqetwquyteuywqteuy');
        print(response);
        yield OnError(response.message);
      }
    }
  }
}
