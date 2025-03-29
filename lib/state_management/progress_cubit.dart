import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:marvel_t/data/models/mission_model.dart';
import '../data/models/enums.dart';

class ProgressCubit extends Cubit<double> {
  ProgressCubit() : super(1.0) {
    _loadEnergy();
    _startEnergyRecovery();
  }

  Timer? _recoveryTimer;

  Future<void> initializeEnergy() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('energy', 1.0);
    emit(1.0);
  }

  Future<void> _loadEnergy() async {
    final prefs = await SharedPreferences.getInstance();
    double savedEnergy = prefs.getDouble('energy') ?? 1.0;
    emit(savedEnergy);
  }

  Future<void> _saveEnergy(double energy) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('energy', energy);
  }

  void updateProgress(List<MissionModel> missions) async {
    double energy = state;

    for (var mission in missions) {
      if (mission.status == StatusEnum.completed) {
        switch (mission.treatLevel) {
          case TreatLevelEnum.low:
            energy -= 0.06;
            break;
          case TreatLevelEnum.medium:
            energy -= 0.1;
            break;
          case TreatLevelEnum.high:
            energy -= 0.25;
            break;
          case TreatLevelEnum.worldEnding:
            energy -= 0.5;
            break;
        }
      }
    }

    energy = energy.clamp(0.0, 1.0);
    emit(energy);
    await _saveEnergy(energy);
  }

  void _startEnergyRecovery() {
    _recoveryTimer = Timer.periodic(Duration(seconds: 10), (timer) async {
      double newEnergy = (state + 0.1).clamp(0.0, 1.0);
      emit(newEnergy);
      await _saveEnergy(newEnergy);
    });
  }

  @override
  Future<void> close() {
    _recoveryTimer?.cancel();
    return super.close();
  }
}
