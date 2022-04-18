import 'package:makemymarry/bloc/base_event_state.dart';

class WalletEvent extends BaseEventState{

}
class FetchCurrentBalance extends WalletEvent{

}
class AddNewConnects extends WalletEvent{
  final int count;

  AddNewConnects(this.count);
}