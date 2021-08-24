import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';

import 'occupation_event.dart';
import 'occupation_state.dart';

class OccupationBloc extends Bloc<OccupationEvent, OccupationState> {
  final UserRepository userRepository;

  String? occupation;
  Education? education;
  late String nameOfOrg;
  late String income;
  late String country;
  late String stateName;
  late String city;

  OccupationBloc(this.userRepository) : super(OccupationInitialState());

  @override
  Stream<OccupationState> mapEventToState(OccupationEvent event) async* {
    yield OnOccupationLoading();

    if (event is OnOccupationSelected) {
      this.occupation = event.occupation;
      yield OccupationInitialState();
    }
    if (event is OnEducationSelected) {
      this.education = event.education;
      yield OccupationInitialState();
    }
    if (event is UpdateCareer) {
      this.nameOfOrg = event.name;
      this.income = event.income;
      this.country = event.country;
      this.stateName = event.stateName;
      this.city = event.city;
      if (this.nameOfOrg == '') {
        yield OnError('Enter name of organisation employeed in.');
      } else if (this.income == '') {
        yield OnError('Enter annual income.');
      } else if (this.country == '') {
        yield OnError('Enter name of country belonging to.');
      } else if (this.stateName == '') {
        yield OnError('Enter name of state belonging to.');
      } else if (this.city == '') {
        yield OnError('Enter name of city belonging to.');
      } else if (this.occupation == null) {
        yield OnError('select your occupation.');
      } else if (this.education == null) {
        yield OnError('select your educational qualifications.');
      } else {
        var result = await this.userRepository.career(
              this.nameOfOrg,
              this.occupation,
              this.income,
              this.education,
              this.country,
              this.stateName,
              this.city,
            );

        if (result.status == AppConstants.SUCCESS) {
          // this.userRepository.useDetails = result.userDetails;
          // await this.userRepository.saveUserDetails();
          yield MoveToFamily();
        } else {
          yield OnError(result.message);
        }
      }
    }
  }
}
