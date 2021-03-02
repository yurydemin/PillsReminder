import 'package:flutter/material.dart';
import 'package:pills_reminder/models/pills_event.dart';
import 'package:pills_reminder/providers/pills_provider.dart';
import 'package:pills_reminder/screens/event_detailed_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<PillsProvider>(context).bloc;
    return Scaffold(
      appBar: AppBar(
        title: Text('Pills Reminder'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<PillsEvent>>(
        stream: bloc.events,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          var events = snapshot.data;
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              // events[index].activate();
              // bloc.changeEvents(events);
              return ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.bookmark),
                ),
                title: Text(events[index].timeOfDay),
                subtitle: Text(events[index].description),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EventDetailedScreen(
                        eventId: events[index].id.toString(),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EventDetailedScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
