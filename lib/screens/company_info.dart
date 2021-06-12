import 'package:flutter/material.dart';
import 'package:hoblist_movies/utilities/constants.dart';

class CompanyInfo extends StatefulWidget {
  const CompanyInfo({Key? key}) : super(key: key);

  @override
  _CompanyInfoState createState() => _CompanyInfoState();
}

class _CompanyInfoState extends State<CompanyInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Details'),
        centerTitle: true,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Company: Geeksynergy Technologies Pvt Ltd',
                style: style,
              ),
              Text(
                'Address:  Sanjayanagar, Bengaluru-56',
                style: style,
              ),
              Text(
                'Phone:XXXXXXXXX09',
                style: style,
              ),
              Text(
                'Email: XXXXXX@gmail.com',
                style: style,
              ),
            ],
          )),
    );
  }
}
