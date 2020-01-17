import 'dart:io';
import 'dart:math';

import 'package:conference_voting_app/app_state.dart';
import 'package:conference_voting_app/display_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image/image.dart' as image;

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Conference Vote App"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(child: DisplayImage(voteIndex: 1)),
              flex: 2,
            ),
            Expanded(
              child: Container(child: DisplayImage(voteIndex: 2)),
              flex: 2,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(color: Colors.white),
              ),
              flex: 1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var body = {};

          appState.images.forEach((int key, String path) {
            if (path != null) {
              File file = File(path);
              image.Image img = image.decodeImage(file.readAsBytesSync());

              var r, g, b, max_rgb;
              var light = 0;
              var dark = 0;

              for (var x = 0; x < img.data.length; x += 4) {
                r = img.data[x];
                g = img.data[x + 1];
                b = img.data[x + 2];

                max_rgb = max<int>(max<int>(r, g), b);
                if (max_rgb < 128)
                  dark++;
                else
                  light++;
              }

             // var dl_diff = (light - dark) / (img.width * img.height);
              //body['$key'] = 'data:image/png;base64,' + base64Encode(bytes);
              body['$key'] = light;
            }
          });

          // const url =
          //     "https://europe-west1-voting-gun.cloudfunctions.net/computeVotes";
          // var response = await http.post(url, body: body);

          // print(response.body);

          showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                title: new Text("Evaluation"),
                content: new Text(
                  "95 / 5",
                  style: TextStyle(fontSize: 30.0),
                ),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Compute',
        child: Icon(Icons.play_arrow),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
