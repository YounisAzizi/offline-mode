

import '../const/const.dart';

final defaultUserModel = UserModel(
  id: currentUserId,
  name: 'John',
  lastName: 'Doe',
  startTime: '${DateTime.now()}',
  endTime: '',
);


class UserModel {
  final String id;
  final String name;
  final String lastName;
  final String startTime;
  final String endTime;

  const UserModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      lastName: json['lastName'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? lastName,
    String? startTime,
    String? endTime,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}

