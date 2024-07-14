import '../const/const.dart';

final defaultUserModel = UserModel(
  id: currentUserId,
  name: 'John',
  lastName: 'Doe',
  startTime: '${DateTime.now()}',
  endTime: '',
  isStarted: true,
);

class UserModel {
  final String id;
  final String name;
  final String lastName;
  final String startTime;
  final String endTime;
  final bool isStarted;

  const UserModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.startTime,
    required this.endTime,
    required this.isStarted,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'startTime': startTime,
      'endTime': endTime,
      'isStarted': isStarted ? 1 : 0, // convert bool to int
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      lastName: json['lastName'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      isStarted: json['isStarted'] == 1, // convert int to bool
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? lastName,
    String? startTime,
    String? endTime,
    bool? isStarted,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isStarted: isStarted ?? this.isStarted,
    );
  }
}
