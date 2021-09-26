// ignore: file_names
// ignore_for_file: non_constant_identifier_names, prefer_const_constructors_in_immutables, file_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/Api.dart';

import 'Friend.dart';

class FriendsForm extends StatefulWidget {
  FriendsForm({Key? key}) : super(key: key);

  @override
  _FriendsFormState createState() => _FriendsFormState();
}

class _FriendsFormState extends State<FriendsForm> {
  final first_name_controller = TextEditingController();
  final last_name_controller = TextEditingController();
  final email_controller = TextEditingController();
  final job_controller = TextEditingController();
  final friend = Friend();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomFormField(
          textInputType: TextInputType.text,
          hint_text: 'First Name',
          textEditingController: first_name_controller,
        ),
        CustomFormField(
          textInputType: TextInputType.text,
          hint_text: 'Last Name',
          textEditingController: last_name_controller,
        ),
        CustomFormField(
          textInputType: TextInputType.emailAddress,
          hint_text: 'Email',
          textEditingController: email_controller,
        ),
        CustomFormField(
          textInputType: TextInputType.text,
          hint_text: 'Job',
          textEditingController: job_controller,
        ),
        TextButton(
          onPressed: () {
            friend.first_name = first_name_controller.text.toString();
            friend.last_name = last_name_controller.text.toString();
            friend.email = email_controller.text.toString();
            friend.job = job_controller.text.toString();
            createFriend(friend);
            clear_fields();
          },
          style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              primary: Colors.white,), // ignore: prefer_const_constructors
          child: const Text("Add Friend"),
        ),
      ],
    );
  }

  void clear_fields() {
    first_name_controller.clear();
    last_name_controller.clear();
    email_controller.clear();
    job_controller.clear();
  }
}

// ignore: must_be_immutable
class CustomFormField extends StatefulWidget {
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  String hint_text;
  CustomFormField(
      {Key? key,
      required this.textInputType,
      required this.hint_text,
      required this.textEditingController})
      : super(key: key);

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: TextFormField(
              controller: widget.textEditingController,
              decoration: InputDecoration(
                hintText: widget.hint_text,
              ),
              keyboardType: widget.textInputType,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Field is required";
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
