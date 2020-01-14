import 'package:camera/camera.dart';
import 'package:conference_voting_app/app_state.dart';
import 'package:conference_voting_app/home_screen.dart';
import 'package:conference_voting_app/take_picture_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      
      child: MaterialApp(/*theme: ThemeData.dark(),*/ initialRoute: '/', 
      onGenerateRoute: (settings) {
        // If you push the PassArguments route
        if (settings.name == TakePictureScreen.routeName) {
          // Cast the arguments to the correct type: ScreenArguments.
          final String args = settings.arguments;

          // Then, extract the required data from the arguments and
          // pass the data to the correct screen.
          return MaterialPageRoute(
            builder: (context) {
              return TakePictureScreen(
                 camera: firstCamera
              );
            },
          );
        }
      },
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => HomeScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        TakePictureScreen.routeName: (context) => TakePictureScreen(
              camera: firstCamera,
            )
      })));
}
