import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/widgets_large.dart';

import 'hobby_bloc.dart';
import 'hobby_event.dart';
import 'hobby_state.dart';


class HobbyBody extends StatelessWidget {
  const HobbyBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HobbyBloc, HobbyState>(
      listener: (context, state) {
        if (state is NavigateToMyProfile) {
          // Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if ((state is HobbyIdleState) || (state is HobbyInitialState)) {
          dynamic castedState = state is HobbyIdleState
              ? state as HobbyIdleState
              : state as HobbyInitialState;
          return Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            runAlignment: WrapAlignment.start,
            alignment: WrapAlignment.start,
            children: HobbyType.values
                .map(
                  (e) => MmmButtons.lifeStyleChip(
                    56,
                    double.infinity,
                    e.asset,
                    e.label,
                    e.activeStatus(castedState.data),
                    () {
                      BlocProvider.of<HobbyBloc>(context)
                          .add(HobbyToggled(castedState.data, e));
                    },
                  ),
                )
                .toList(),
          );
        } else if (state is HobbyErrorState) {
          return Container();
        } else if (state is HobbyLoadingState) {
          return MmmWidgets.buildLoader(context, color: Colors.transparent);
        }
        return Container();
      },
    );
  }
}



enum HobbyType {
  collectingAntiques,
  writing,
  collectingCoins,
  collectingStamps,
  acting,
  cooking,
  artOrHandcrafts,
  readingBooks,
  Painting,
  filmMaking,
  photography,
  modelBuilding,
  gardening,
  fishing,
  virtualDesigning,
  petCare,
  socialMediaInfluencer,
  playingMusic,
  dancing,
  clubbing,
  roadTrip,
  adventureLover,
  mountainHiking,
  astrology,
  solvingPuzzles,
  others
}

extension HobbyExtension on HobbyType {
  String get label {
    switch (this) {
      case HobbyType.collectingAntiques:
        return "Collecting Antiques";
      case HobbyType.writing:
        return "Writing";
      case HobbyType.collectingCoins:
        return "Collecting Coins";
      case HobbyType.collectingStamps:
        return "Collecting Stamps";
      case HobbyType.acting:
        return "Acting";
      case HobbyType.cooking:
        return "Cooking";
      case HobbyType.artOrHandcrafts:
        return "Art/Handicrafts";
      case HobbyType.readingBooks:
        return "Reading Books";
      case HobbyType.Painting:
        return "Painting";
      case HobbyType.filmMaking:
        return "Film-Making";
      case HobbyType.photography:
        return "Photography";
      case HobbyType.modelBuilding:
        return "Model-Building";
      case HobbyType.gardening:
        return "Gardening";
      case HobbyType.fishing:
        return "Fishing";
      case HobbyType.virtualDesigning:
        return "Virtual Designing";
      case HobbyType.petCare:
        return "Taking Care of Pets";
      case HobbyType.socialMediaInfluencer:
        return "Social Media Influencer";
      case HobbyType.playingMusic:
        return "Playing Music Instrument";
      case HobbyType.dancing:
        return "Dancing";
      case HobbyType.clubbing:
        return "Clubbing";
      case HobbyType.roadTrip:
        return "Road Trip";
      case HobbyType.adventureLover:
        return "Adventure Lover";
      case HobbyType.mountainHiking:
        return "Mountain Hiking";
      case HobbyType.astrology:
        return "Astrology/Palmistry";
      case HobbyType.solvingPuzzles:
        return "Solving crossword/ puzzle";
      case HobbyType.others:
        return "Other";
    }
  }

  String get asset {
    switch (this) {
      case HobbyType.collectingAntiques:
        return "images/icons/hobbies/antiques_vector.svg";
      case HobbyType.writing:
        return "images/icons/hobbies/writing_vector.svg";
      case HobbyType.collectingCoins:
        return "images/icons/hobbies/coins_vector.svg";
      case HobbyType.collectingStamps:
        return "images/icons/hobbies/stamps_vector.svg";
      case HobbyType.acting:
        return "images/icons/hobbies/acting_vector.svg";
      case HobbyType.cooking:
        return "images/icons/hobbies/cooking_vector.svg";
      case HobbyType.artOrHandcrafts:
        return "images/icons/hobbies/arts_vector.svg";
      case HobbyType.readingBooks:
        return "images/icons/hobbies/books_vector.svg";
      case HobbyType.Painting:
        return "images/icons/hobbies/painting_vector.svg";
      case HobbyType.filmMaking:
        return "images/icons/hobbies/film_making.svg";
      case HobbyType.photography:
        return "images/icons/hobbies/photography_vector.svg";
      case HobbyType.modelBuilding:
        return "images/icons/hobbies/model_building_vector.svg";
      case HobbyType.gardening:
        return "images/icons/hobbies/gardening_vector.svg";
      case HobbyType.fishing:
        return "images/icons/hobbies/fishing_vector.svg";
      case HobbyType.virtualDesigning:
        return "images/icons/hobbies/designing_vector.svg";
      case HobbyType.petCare:
        return "images/icons/hobbies/pet_care_vector.svg";
      case HobbyType.socialMediaInfluencer:
        return "images/icons/hobbies/influencer_vector.svg";
      case HobbyType.playingMusic:
        return "images/icons/hobbies/music_vector.svg";
      case HobbyType.dancing:
        return "images/icons/hobbies/dancing_vector.svg";
      case HobbyType.clubbing:
        return "images/icons/hobbies/clubbing_vector.svg";
      case HobbyType.roadTrip:
        return "images/icons/hobbies/road_trip_vector.svg";
      case HobbyType.adventureLover:
        return "images/icons/hobbies/adventure_vector.svg";
      case HobbyType.mountainHiking:
        return "images/icons/hobbies/hiking_vector.svg";
      case HobbyType.astrology:
        return "images/icons/hobbies/astrology_vector.svg";
      case HobbyType.solvingPuzzles:
        return "images/icons/hobbies/puzzle_vector.svg";
      case HobbyType.others:
        return "images/icons/hobbies/others_vector.svg";
    }
  }

  bool activeStatus(HobbyData data) {
    return data.hobbies.contains(this);
  }

  HobbyData toggle(HobbyData data) {
    if (data.hobbies.contains(this)) {
      var list = <HobbyType>[];
      list.addAll(data.hobbies);
      list.remove(this);
      return data.copyWith(hobbies: list);
    } else {
      var list = <HobbyType>[];
      list.addAll(data.hobbies);
      list.add(this);
      return data.copyWith(hobbies: list);
    }
  }
}
