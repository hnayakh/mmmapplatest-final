import 'package:flutter/material.dart';
import 'package:makemymarry/repo/user_repo.dart';

class Transaction extends StatelessWidget {
  final UserRepository userRepository;

  const Transaction({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransactionScreen();
  }
}

class TransactionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TransactionScreenState();
  }
}

class TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
