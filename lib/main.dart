import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/app/bloc/app_bloc.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/repo/chat_repo.dart';
import 'package:makemymarry/repo/user_repo.dart';

import 'app/views/app.dart';

void main() async {
  await setUpDependency();
  runApp(
    BlocProvider<AppBloc>(
      create: (context) => AppBloc(
        getIt<ChatRepo>(),
        getIt<UserRepository>(),
      ),
      child: MyApp(),
    ),
  );
}
