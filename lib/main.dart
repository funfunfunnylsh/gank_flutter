import 'package:flutter/material.dart';
import 'ui/page/page_splash.dart';
import 'ui/page/page_home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      routes: {
        SplahsScreen.ROUTER_NAME: (context) => SplahsScreen(),
        HomePage.ROUTER_NAME: (context) => HomePage(),
//        LoginPage.ROUTER_NAME: (context) => LoginPage(),
//        SearchPage.ROUTER_NAME: (context) => SearchPage(),
//        AboutPage.ROUTER_NAME: (context) => AboutPage(),
      },
      home: SplahsScreen(),
    );
  }
}
