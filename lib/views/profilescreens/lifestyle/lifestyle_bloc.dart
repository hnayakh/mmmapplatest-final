import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/views/profilescreens/lifestyle/lifestyle_details_view.dart';
import 'package:makemymarry/views/profilescreens/lifestyle/lifestyle_event.dart';
import 'package:makemymarry/views/profilescreens/lifestyle/lifestyle_state.dart';

class LifeStyleBloc extends Bloc<LifeStyleEvent, LifeStyleState> {
  LifeStyleBloc() : super(LifeStyleInitialState());

  @override
  Stream<LifeStyleState> mapEventToState(LifeStyleEvent event) async* {
    yield LifeStyleLoadingState();
    if (event is LifeStyleDataLoaded) {
      yield LifeStyleIdleState(data: event.data);
    }
    if (event is LifeStyleToggled) {
      var data = event.type.toggle(event.data);
      yield LifeStyleIdleState(data: data);
    }
  }
}
