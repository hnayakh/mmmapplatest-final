import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/views/home/menu/wallet/connect_history/connect_history_bloc.dart';
import 'package:makemymarry/views/home/menu/wallet/connect_history/connect_history_event.dart';
import 'package:makemymarry/views/home/menu/wallet/connect_history/connect_history_state.dart';

import '../../../../../datamodels/connect.dart';
import '../../../../../utils/app_helper.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/text_styles.dart';
import '../../../../../utils/widgets_large.dart';

class ConnectHistory extends StatelessWidget {
  final UserRepository userRepository;

  const ConnectHistory({Key? key, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConnectHistoryBloc(userRepository),
      child: ConnectHistoryScreen(),
    );
  }
}

class ConnectHistoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ConnectHistoryScreenState();
  }
}

class ConnectHistoryScreenState extends State<ConnectHistoryScreen> {
  late List<ConnectHistoryItem> list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocConsumer<ConnectHistoryBloc, ConnectHistoryState>(
          builder: (context, state) {
            if (state is ConnectHistoryInitialState) {
              BlocProvider.of<ConnectHistoryBloc>(context)
                  .add(GetConnectHistory());
            }
            this.list = BlocProvider.of<ConnectHistoryBloc>(context).list;
            return Container(
              child: Stack(
                children: [
                  buildList(),
                  state is OnLoading
                      ? MmmWidgets.buildLoader2(context)
                      : Container()
                ],
              ),
            );
          },
          listener: (context, state) {},
        ),
      ),
    );
  }

  Widget buildList() {
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(
          title: Row(
            children: [
              list[index].transactionType != 2
                  ? CircleAvatar(
                      child: ClipOval(
                          child: Image.network(
                        list[index].thumbnailURL,
                        width: 38,
                        height: 38,
              errorBuilder: (context, obj, str) => Container(
                  color: Colors.grey,
                  child: Icon(Icons.error))

                      )),
                    )
                  : Container(
                      width: 38,
                    ),
              SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    list[index].name != null ? list[index].name : "By Admin",
                    textScaleFactor: 1.0,
                    style: MmmTextStyles.bodyRegular(),
                  ),
                  Row(
                    children: [
                      Text(
                        AppHelper.getReadableDateTImeFromServer(
                            list[index].updatedAt),
                        // list[index].date,
                        textScaleFactor: 1.0,
                        style: MmmTextStyles.bodyRegular(textColor: gray1),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Text(
                        getTransactionType(list[index].transactionType),
                        textScaleFactor: 1.0,
                        style: MmmTextStyles.bodySmall(textColor: Colors.green),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        );
      },
      itemCount: list.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }

  String getTransactionType(int transactionType) {
    switch (transactionType) {
      case 0:
        return "Debit";
      case 1:
        return "Refund";
      default:
        return "Referral";
    }
  }
}
