import 'package:makemymarry/base_event_state.dart';

class RechargeHistoryState extends BaseEventState{

}
class OnLoading extends RechargeHistoryState{

}
class OnGotTransactionList extends RechargeHistoryState{

}
class OnError extends RechargeHistoryState{
  final String message;

  OnError(this.message);
}
class RechargeHistoryInitialState extends RechargeHistoryState{

}