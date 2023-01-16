import 'package:makemymarry/base_event_state.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

import 'lifestyle_details_view.dart';

class LifeStyleEvent extends BaseEventState {}

class LoadLifeCycleData extends LifeStyleEvent {}

class SaveLifeStyleData extends LifeStyleEvent {}


class LifeStyleToggled extends LifeStyleEvent {
  final LifeStyleData data;
  final LifeStyleType type;

  LifeStyleToggled(this.data, this.type);
}

class LifeStyleData {
  final bool openToPets;
  final bool ownsCar;
  final bool ownsHouse;
  final bool ownsTwoWheeler;
  final bool ownsBusiness;
  final bool haveOther;

  const LifeStyleData(
      {required this.openToPets,
      required this.ownsCar,
      required this.ownsHouse,
      required this.ownsTwoWheeler,
      required this.ownsBusiness,
      required this.haveOther});

  LifeStyleData copyWith({
    bool? openToPets,
    bool? ownsCar,
    bool? ownsHouse,
    bool? ownsTwoWheeler,
    bool? ownsBusiness,
    bool? haveOther,
  }) =>
      LifeStyleData(
          openToPets: openToPets ?? this.openToPets,
          ownsCar: ownsCar ?? this.ownsCar,
          ownsHouse: ownsHouse ?? this.ownsHouse,
          ownsTwoWheeler: ownsTwoWheeler ?? this.ownsTwoWheeler,
          ownsBusiness: ownsBusiness ?? this.ownsBusiness,
          haveOther: haveOther ?? this.haveOther);
}
