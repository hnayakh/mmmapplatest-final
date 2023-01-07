import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    print(bloc.state);
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase bloc) {
    print(bloc.stream.toString());
    super.onClose(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(stackTrace);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition.toString());
    super.onTransition(bloc, transition);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    print(change.toString());
    super.onChange(bloc, change);
  }

}