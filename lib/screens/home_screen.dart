import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hoblist_movies/controllers/movie_controller.dart';
import 'package:hoblist_movies/screens/company_info.dart';
import 'package:hoblist_movies/screens/webview.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  Function(String)? handleClick;
  @override
  initState() {
    // TODO: implement initState
    super.initState();

    getMovie();

    FirebaseMessaging.onMessage.listen(
      (event) {
        print('Message Received.');

        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 1,
            title: event.notification!.title,
            body: event.notification!.body,
            channelKey: 'Key123456789',
            largeIcon: event.notification!.android!.imageUrl,
            bigPicture: event.notification!.android!.imageUrl,
            hideLargeIconOnExpand: false,
          ),
        );
      },
    );
    getToken();
  }

  getToken() {
    _firebaseMessaging.getToken().then((token) {
      print(token);
    });
  }

  void getMovie() async {
    await MovieController().fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (result) {
              if (result == '0') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CompanyInfo(),
                  ),
                );
              } else if (result == '1') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebViewEx(),
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Company Info'),
                value: '0',
              ),
              PopupMenuItem(
                child: Text('Hoblist'),
                value: '1',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
