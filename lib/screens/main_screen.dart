import 'package:flutter/material.dart';
import 'package:pills_reminder/blocs/events_bloc.dart';
import 'package:pills_reminder/models/pills_event.dart';
import 'package:pills_reminder/screens/event_detailed_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<EventsBloc>(context);
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
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: events.length,
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
                ),
              ),
            ],
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
