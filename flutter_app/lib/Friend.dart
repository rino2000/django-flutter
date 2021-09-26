// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: non_constant_identifier_names, file_names

class Friend {
  String? first_name, last_name, email, job;
  int? id;

  Friend({this.id, this.first_name, this.last_name, this.email, this.job});

  @override
  String toString() => 'Friend($id,$first_name,$last_name,$email,$job)';

  Map<String, dynamic> toMap() {
    return {
      'id': id!.toString(),
      'first_name': first_name!,
      'last_name': last_name!,
      'email': email!,
      'job': job!,
    };
  }

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      email: json['email'],
      job: json['job'],
    );
  }
}
