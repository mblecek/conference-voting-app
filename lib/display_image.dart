// A widget that displays the picture taken by the user.
import 'dart:io';

import 'package:conference_voting_app/app_state.dart';
import 'package:conference_voting_app/take_picture_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayImage extends StatelessWidget {
  final int voteIndex;

  DisplayImage({Key key, @required this.voteIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context);

    String imagePath = appState.images[this.voteIndex];

    return Card(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.image),
          // title: new Text(this.imageName),
          title: Text('Vote $voteIndex'),
          //subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
        ),
        imagePath != null
            ? Expanded(
                child: Container(
                    child: Center(
                        child: Image.file(
                  File(imagePath),
                  fit: BoxFit.fill,
                ))),
                flex: 2,
              )
            : Expanded(
                child:
                    Container(child: Center(child: Text("Please take image"))),
                flex: 2,
              ),
        ButtonBar(
          children: <Widget>[
            Ink(
              decoration: const ShapeDecoration(
                color: Colors.lightBlue,
                shape: CircleBorder(),
              ),
              child: IconButton(
                  icon: Icon(Icons.camera_alt),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, TakePictureScreen.routeName,
                        arguments: voteIndex);
                  }),
            )
          ],
        ),
      ],
    ));
  }
}
