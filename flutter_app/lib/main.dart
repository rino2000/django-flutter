// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Add_Friend.dart';
import 'Api.dart';
import 'Friend.dart';
import 'Friends_List.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<List<Friend>>? friendsList;

  @override
  void initState() {
    super.initState();
    friendsList = fetchFriends();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Friends',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          elevation: 0,
          title: const Text('Friends'),
        ),
        body: Column(
          children: [
            FriendsForm(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: FutureBuilder<List<Friend>>(
                  future: friendsList!,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Text('Error: ${snapshot.error}');
                      case ConnectionState.done:
                        return Items(friendsList: snapshot.data!);
                      case ConnectionState.waiting:
                        return const Center(
                            child: (CircularProgressIndicator()));
                      default:
                        return const Text("Data cant load");
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    setState(() {
      friendsList = fetchFriends();
    });
  }
}
