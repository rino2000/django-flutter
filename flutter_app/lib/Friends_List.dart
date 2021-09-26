// ignore: file_names
// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, duplicate_ignore, camel_case_types, file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_app/Api.dart';

import 'Friend.dart';

// ignore: camel_case_types
class Items extends StatefulWidget {
  late final List<Friend>? friendsList;
  Items({
    Key? key,
    required this.friendsList,
  }) : super(key: key);

  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.friendsList!.length,
      itemBuilder: (BuildContext context, int index) {
        final item = widget.friendsList![index];
        return Dismissible(
          background: Container(color: Colors.red),
          onDismissed: (direction) => setState(() {
            deleteFriend(item.id.toString());
            widget.friendsList!.removeAt(index);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text("Friend deleted"),
                duration: Duration(milliseconds: 500),
              ),
            );
          }),
          key: UniqueKey(),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: ListTile(
                title: Text(item.first_name! + " " + item.last_name!),
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                    item.first_name!.characters
                        .elementAt(0)
                        .toUpperCase()
                        .toString(),
                  ),
                ),
                trailing: Text(item.email!),
                subtitle: Text(item.job!),
              ),
            ),
          ),
        );
      },
    );
  }
}
