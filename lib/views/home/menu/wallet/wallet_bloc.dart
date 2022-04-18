import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/views/home/menu/wallet/wallet_event.dart';
import 'package:makemymarry/views/home/menu/wallet/wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final UserRepository userRepository;
  late int currentBalance = 0;

  WalletBloc(this.userRepository) : super(WalletInitialState());

  @override
  Stream<WalletState> mapEventToState(WalletEvent event) async* {
    yield OnLoading();
    if (event is FetchCurrentBalance) {
      var response = await this.userRepository.fetchCurrentBalance();
      if (response.status == AppConstants.SUCCESS) {
        this.currentBalance = response.balance;
        yield OnGotWalletBalance();
      } else {
        yield OnError(response.message);
      }
    }
    if (event is AddNewConnects) {
      this.currentBalance += event.count;
      yield OnGotWalletBalance();
    }
  }
}
