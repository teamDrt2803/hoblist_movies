import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hoblist_movies/controllers/movie_controller.dart';
import 'package:hoblist_movies/models/movie_model.dart';

import 'company_info.dart';
import 'webview.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen(
      (event) {
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
      body: Container(
        child: FutureBuilder<MovieList?>(
          future: MovieController().fetchMovies(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data?.result.length,
                    itemBuilder: (context, index) {
                      var result = snapshot.data?.result[index];
                      var size = MediaQuery.of(context).size;
                      var date = DateTime.fromMillisecondsSinceEpoch(
                          result!.releasedDate * 1000);
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        color: Colors.white,
                        height: size.height * 0.30,
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Votes(size: size, result: result),
                                  Poster(result: result, size: size),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          result.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        DetailTextWidget(
                                          result: result,
                                          text1: 'Genre:',
                                          text2: ' ${result.genre}',
                                        ),
                                        DetailTextWidget(
                                          result: result,
                                          text1: 'Director:',
                                          text2: ' ${result.director[0]}',
                                        ),
                                        DetailTextWidget(
                                          result: result,
                                          text1: 'Starring:',
                                          text2: ' ${result.stars[0]}',
                                        ),
                                        Text(
                                          'Mins | ' +
                                              '${result.language} | ' +
                                              date.day.toString() +
                                              ' ' +
                                              date.month.month(),
                                        ),
                                        Text(
                                          '${result.pageViews} views | Voted by ${result.totalVoted} People',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              ?.copyWith(
                                                color: Colors.blue,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _buildWatchTrailer(),
                            Divider(
                              color: Colors.grey.shade400,
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : snapshot.hasError
                    ? Container(
                        child: Center(
                          child: Text('error' + snapshot.error.toString()),
                        ),
                      )
                    : Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
          },
        ),
      ),
    );
  }

  Padding _buildWatchTrailer() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(5),
        ),
        height: 40,
        child: Center(
          child: Text(
            'Watch Trailer',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.7,
            ),
          ),
        ),
      ),
    );
  }
}

class DetailTextWidget extends StatelessWidget {
  const DetailTextWidget({
    Key? key,
    required this.result,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  final Result? result;
  final String text1, text2;

  @override
  Widget build(BuildContext context) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: Theme.of(context).textTheme.headline6?.copyWith(
              fontSize: 15,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
        text: text1,
        children: [
          TextSpan(
            text: text2,
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
          ),
        ],
      ),
    );
  }
}

class Poster extends StatelessWidget {
  const Poster({
    Key? key,
    required this.result,
    required this.size,
  }) : super(key: key);

  final Result? result;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            result?.poster ?? "",
          ),
        ),
      ),
      width: size.width * 0.2,
    );
  }
}

class Votes extends StatelessWidget {
  const Votes({
    Key? key,
    required this.size,
    required this.result,
  }) : super(key: key);

  final Size size;
  final Result? result;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.keyboard_arrow_up,
            size: 48,
          ),
          Text(
            result?.totalVoted.toString() ?? '',
            style: Theme.of(context).textTheme.headline6,
          ),
          Icon(
            Icons.keyboard_arrow_down,
            size: 48,
          ),
          Text(
            'Votes',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}

extension MonthExtension on int {
  String month() {
    switch (this) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      default:
        return 'Dec';
    }
  }
}
