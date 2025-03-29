import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/enums.dart';
import '../models/mission_model.dart';


class MissionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createMission(MissionModel mission) async {
    try {
      await _firestore.collection('missions').add(mission.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateMission(MissionModel mission) async {
    try {
      await _firestore.collection('missions').doc(mission.id).update(mission.toMap());
    } catch (e) {
      throw Exception(e);    }
  }

  Stream<List<MissionModel>> getHeroMissionsStream() {
    String heroId = FirebaseAuth.instance.currentUser!.uid;

    try {
      return _firestore
          .collection('missions')
          .where('heroId', isEqualTo: heroId)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) => MissionModel.fromFirestore(doc)).toList();
      });
    } catch (e) {
      throw Exception(e);    }
  }

  Future<void> deleteMission(String missionId) async {
    try {
      await _firestore.collection('missions').doc(missionId).delete();
    } catch (e) {
      throw Exception(e);    }
  }

  int getPendingMissions(List<MissionModel> missions) {
    return missions.where((mission) => mission.status != StatusEnum.completed).length;
  }
}