import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/views/profilescreens/family/family_details/family_details_events.dart';
import 'package:makemymarry/views/profilescreens/family/family_details/family_details_state.dart';

class FamilyDetailsBloc extends Bloc<FamilyDetailsEvent, FamilyDetailState> {
  final UserRepository userRepository;

  FamilyDetailsBloc(this.userRepository) : super(FamilyDetailInitialState());
  FatherOccupation? fatherOccupation;
  MotherOccupation? motherOccupation;

  int noOfBrothers = 0, noOfSister = 0, brotherMarried = 0, sistersMarried = 0;

  @override
  Stream<FamilyDetailState> mapEventToState(FamilyDetailsEvent event) async* {
    yield OnLoading();
    if (event is OnFathersOccupationSelected) {
      this.fatherOccupation = event.occupation;
      yield FamilyDetailInitialState();
    }
    if (event is OnMothersOccupationSelected) {
      this.motherOccupation = event.occupation;
      yield FamilyDetailInitialState();
    }
    if (event is ChangeNoOfBrothers) {
      this.noOfBrothers += event.change;
      if (noOfBrothers < 0) {
        this.noOfBrothers = 0;
      }
      yield FamilyDetailInitialState();
    }
    if (event is ChangeNoOfSisters) {
      this.noOfSister += event.change;
      if (noOfSister < 0) {
        this.noOfSister = 0;
      }
      yield FamilyDetailInitialState();
    }
    if (event is ChangeNoOfSistersMarried) {
      this.sistersMarried += event.change;
      if (sistersMarried > noOfSister) {
        this.sistersMarried = noOfSister;
      }
      yield FamilyDetailInitialState();
    }
    if (event is ChangeNoOfBrothersMarried) {
      this.brotherMarried += event.change;
      if (brotherMarried > noOfBrothers) {
        this.brotherMarried = noOfBrothers;
      }
      yield FamilyDetailInitialState();
    }
    if (event is UpdateFamilyDetails) {
      if (this.fatherOccupation == null) {
        yield OnError("Select Father's Occupation");
      } else if (this.motherOccupation == null) {
        yield OnError("Select Mother's Occupation");
      } else {
        var result = await this.userRepository.updateFamilyDetails(
            fatherOccupation!,
            motherOccupation!,
            noOfBrothers,
            noOfSister,
            brotherMarried,
            sistersMarried);
        if (result.status == AppConstants.SUCCESS) {
          yield OnFamilyDetailsUpdated();
        } else {
          yield OnError(result.message);
        }
      }
    }
  }
}
