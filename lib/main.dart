import 'package:flutter/material.dart';
import 'package:pills_reminder/blocs/events_bloc.dart';
import 'package:pills_reminder/screens/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

final eventsBloc = EventsBloc();

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => eventsBloc,
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MainScreen(),
      ),
    );
  }

  @override
  void dispose() {
    eventsBloc.dispose();
    super.dispose();
  }
}
