import 'package:cloud_firestore/cloud_firestore.dart';

import 'enums.dart';

class MissionModel{
  final String? id;
  final String heroId;
  final String missionName;
  final TreatLevelEnum treatLevel;
  final StatusEnum status;
  final String text;
  final DateTime createdAt;
  final DateTime? completedAt;

  MissionModel({
    this.id,
    required this.heroId,
    required this.missionName,
    required this.treatLevel,
    required this.status,
    required this.text,
    required this.createdAt,
    this.completedAt,
  });

  MissionModel copyWith({
    String? id,
    String? heroId,
    String? missionName,
    TreatLevelEnum? treatLevel,
    StatusEnum? status,
    String? text,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return MissionModel(
      id: id ?? this.id,
      heroId: heroId ?? this.heroId,
      missionName: missionName ?? this.missionName,
      treatLevel: treatLevel ?? this.treatLevel,
      status: status ?? this.status,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  factory MissionModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return MissionModel(
      id: doc.id,
      heroId: data['heroId'],
      missionName: data['missionName'],
      treatLevel: TreatLevelEnum.values.firstWhere((e) => e.toString() == 'TreatLevelEnum.${data['treatLevel']}'),
      status: StatusEnum.values.firstWhere((e) => e.toString() == 'StatusEnum.${data['status']}'),
      text: data['text'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      completedAt: data['completedAt'] != null ? (data['completedAt'] as Timestamp).toDate() : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'heroId': heroId,
      'missionName': missionName,
      'treatLevel': treatLevel.toString().split('.').last,
      'status': status.toString().split('.').last,
      'text': text,
      'createdAt': createdAt,
      'completedAt': completedAt,
    };
  }
}