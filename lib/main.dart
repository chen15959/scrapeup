import 'package:flutter/material.dart';
import 'package:scrapeup/game.dart';
import 'package:scrapeup/size_fit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '凑合吧，Mia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FitPage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mia的凑合"),
      ),
      body:
      Center(
          child: buildMenu(context)
      ),
    );

  }


  Widget buildMenu(BuildContext context) {
    return ListView(children: [
      ListTile(title: const Text('目标：4'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          GamePage(target: 4)))),
      ListTile(title: const Text('目标：5'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          GamePage(target: 5)))),

      ListTile(title: const Text('目标：6'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          GamePage(target: 6)))),
      ListTile(title: const Text('目标：7'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          GamePage(target: 7)))),
      ListTile(title: const Text('目标：8'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          GamePage(target: 8)))),
      ListTile(title: const Text('目标：9'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          GamePage(target: 9)))),
      ListTile(title: const Text('目标：10'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          GamePage(target: 10)))),

      ListTile(title: const Text('目标：11'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          GamePage(target: 11, max: 9,)))),
      ListTile(title: const Text('目标：11*'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          GamePage(target: 11)))),

      ListTile(title: const Text('目标：12'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          GamePage(target: 12, max: 9,)))),
      ListTile(title: const Text('目标：12*'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          GamePage(target: 12)))),

      ListTile(title: const Text('目标：13'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          GamePage(target: 13, max: 9,)))),
      ListTile(title: const Text('目标：13*'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          GamePage(target: 13)))),

      ListTile(title: const Text('目标：14'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          GamePage(target: 14, max: 9,)))),
      ListTile(title: const Text('目标：14*'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          GamePage(target: 14)))),

      ListTile(title: const Text('目标：15'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          GamePage(target: 15, max: 9,)))),
      ListTile(title: const Text('目标：15*'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          GamePage(target: 15)))),

      ListTile(title: const Text('目标：16'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          GamePage(target: 16, max: 9,)))),
      ListTile(title: const Text('目标：16*'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          GamePage(target: 16)))),

      ListTile(title: const Text('目标：17'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          GamePage(target: 17, max: 9,)))),
      ListTile(title: const Text('目标：17*'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          GamePage(target: 17)))),

      ListTile(title: const Text('目标：18*'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          GamePage(target: 18)))),
      ListTile(title: const Text('目标：19*'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          GamePage(target: 19)))),

    ],);

  }


}
