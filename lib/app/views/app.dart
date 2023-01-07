import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/app/bloc/app_bloc.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/views/splash/splash_screen.dart';

class MyApp extends StatefulWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<AppBloc>(context).updateOnlineStatus(true);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch(state){
      case AppLifecycleState.resumed:
        {
          BlocProvider.of<AppBloc>(context).updateOnlineStatus(true);
          break;
        }
      case AppLifecycleState.inactive:
        // TODO: Handle this case.
        break;
      case AppLifecycleState.paused:
        {
          BlocProvider.of<AppBloc>(context).updateOnlineStatus(false);
          break;
        }
      case AppLifecycleState.detached:
       {
         BlocProvider.of<AppBloc>(context).updateOnlineStatus(false);
         break;
       }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Make My Marry',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "MakeMyMarry", backgroundColor: Colors.white,
        // is not restarted.
        primarySwatch: Colors.pink,
      ),
      home: Splash(),
    );
  }
}


