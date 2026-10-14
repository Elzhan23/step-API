import 'dart:convert';

import 'package:http/http.dart' as http;

class OfficesList {
  List<Office> users;

  OfficesList({required this.users});

  factory OfficesList.fromJson(Map<String, dynamic> json) {
    var usersJson = json['users'] as List;

    List<Office> usersList = usersJson.map((i) => Office.fromJson(i)).toList();

    return OfficesList(users: usersList);
  }
}

class Office {
  final String firstName;
  final String lastName;
  final String gender;
  final String image;

  Office({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
  });

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      gender: json['gender'] as String,
      image: json['image'] as String,
    );
  }
}

Future<OfficesList> getOfficesList() async {
  const url = 'https://dummyjson.com/users';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return OfficesList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
