import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/icons.dart';
import 'package:makemymarry/utils/widgets_large.dart';
import 'package:makemymarry/views/profilescreens/lifestyle/lifestyle_bloc.dart';
import 'package:makemymarry/views/profilescreens/lifestyle/lifestyle_event.dart';
import 'package:makemymarry/views/profilescreens/lifestyle/lifestyle_state.dart';


class LifeStyleView extends StatelessWidget {
  const LifeStyleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LifeStyleBloc>(
      create: (BuildContext context) =>
          LifeStyleBloc(userRepository: getIt<UserRepository>()),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: MmmButtons.appBarCurved('Life Style', context: context),
        body: Builder(
          builder: (BuildContext context) => Column(
            children: [
              LifeStyleBody(),
            ],
          ),
        ),
        floatingActionButton: Builder(builder: (context) {
          return InkWell(
            onTap: () {
              BlocProvider.of<LifeStyleBloc>(context).add(SaveLifeStyleData());
            },
            child: MmmIcons.saveIcon(),
          );
        }),
      ),
    );
  }
}

class LifeStyleBody extends StatelessWidget {
  const LifeStyleBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LifeStyleBloc, LifeStyleState>(
      listener: (context, state) {
        if (state is NavigateToMyProfile) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if ((state is LifeStyleIdleState) || (state is LifeStyleInitialState)) {
          dynamic castedState = state is LifeStyleIdleState
              ? state as LifeStyleIdleState
              : state as LifeStyleInitialState;
          return Padding(
            padding: const EdgeInsets.only(top: 108.0),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              runAlignment: WrapAlignment.start,
              alignment: WrapAlignment.start,
              children: LifeStyleType.values
                  .map(
                    (e) => MmmButtons.lifeStyleChip(
                      56,
                      double.infinity,
                      e.asset,
                      e.label,
                      e.activeStatus(castedState.data),
                      () {
                        BlocProvider.of<LifeStyleBloc>(context)
                            .add(LifeStyleToggled(castedState.data, e));
                      },
                    ),
                  )
                  .toList(),
            ),
          );
        } else if (state is LifeStyleErrorState) {
          return Container();
        } else if (state is LifeStyleLoadingState) {
          return MmmWidgets.buildLoader(context, color: Colors.transparent);
        }
        return Container();
      },
    );
  }
}

enum LifeStyleType {
  openToPets,
  ownsCar,
  ownsHouse,
  ownsBusiness,
  ownsBike,
  haveOthers,
}

extension LifeStyleExtension on LifeStyleType {
  String get label {
    switch (this) {
      case LifeStyleType.ownsCar:
        return "Own a Car";
      case LifeStyleType.openToPets:
        return "Open to Pets";
      case LifeStyleType.ownsHouse:
        return "Own a House";
      case LifeStyleType.ownsBike:
        return "Own a Bike/Scooter";
      case LifeStyleType.ownsBusiness:
        return "Own a Business";
      case LifeStyleType.haveOthers:
        return "Other if any";
    }
  }

  String get asset {
    switch (this) {
      case LifeStyleType.ownsCar:
        return "images/icons/lifestyle/car_vector.svg";
      case LifeStyleType.openToPets:
        return "images/icons/lifestyle/pets_vector.svg";
      case LifeStyleType.ownsHouse:
        return "images/icons/lifestyle/house_vector.svg";
      case LifeStyleType.ownsBike:
        return "images/icons/lifestyle/bike_vector.svg";
      case LifeStyleType.ownsBusiness:
        return "images/icons/lifestyle/business_vector.svg";
      case LifeStyleType.haveOthers:
        return "images/icons/lifestyle/others_vector.svg";
    }
  }

  bool activeStatus(LifeStyleData data) {
    switch (this) {
      case LifeStyleType.ownsCar:
        return data.ownsCar;
      case LifeStyleType.openToPets:
        return data.openToPets;
      case LifeStyleType.ownsHouse:
        return data.ownsHouse;
      case LifeStyleType.ownsBike:
        return data.ownsTwoWheeler;
      case LifeStyleType.ownsBusiness:
        return data.ownsBusiness;
      case LifeStyleType.haveOthers:
        return data.haveOther;
    }
  }

  LifeStyleData toggle(LifeStyleData data) {
    switch (this) {
      case LifeStyleType.ownsCar:
        return data.copyWith(ownsCar: !data.ownsCar);
      case LifeStyleType.openToPets:
        return data.copyWith(openToPets: !data.openToPets);
      case LifeStyleType.ownsHouse:
        return data.copyWith(ownsHouse: !data.ownsHouse);
      case LifeStyleType.ownsBike:
        return data.copyWith(ownsTwoWheeler: !data.ownsTwoWheeler);
      case LifeStyleType.ownsBusiness:
        return data.copyWith(ownsBusiness: !data.ownsBusiness);
      case LifeStyleType.haveOthers:
        return data.copyWith(haveOther: !data.haveOther);
    }
  }
}

