// ignore_for_file: file_names
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'Friend.dart';

Future<http.Response> createFriend(Friend friend) {
  return http.post(
    Uri.parse('http://127.0.0.1:8000/friends/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id': friend.id.toString(),
      'first_name': friend.first_name!,
      'last_name': friend.last_name!,
      'email': friend.email!,
      'job': friend.job!,
    }),
  );
}

Future<List<Friend>> fetchFriends() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/friends/'));

  if (response.statusCode == 200) {
    return parseFriends(response.body);
  } else {
    throw Exception('Failed to get Friends');
  }
}

List<Friend> parseFriends(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Friend>((json) => Friend.fromJson(json)).toList();
}

Future deleteFriend(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('http://127.0.0.1:8000/delete/$id/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    return parseFriends(response.body);
  } else {
    throw Exception('Failed to delete Friend');
  }
}
