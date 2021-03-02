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
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.bookmark),
                ),
                title: Text(snapshot.data[index].time.toString()),
                subtitle: Text(snapshot.data[index].description),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EventDetailedScreen(
                        event: snapshot.data[index],
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
              builder: (context) => EventDetailedScreen(
                event: PillsEvent(id: UniqueKey()),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
