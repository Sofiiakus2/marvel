import 'package:bloc/bloc.dart';
import 'package:marvel_t/data/models/mission_model.dart';

import '../data/models/enums.dart';

class ProgressCubit extends Cubit<double> {
  ProgressCubit() : super(0.0);

  void updateProgress(List<MissionModel> missions) {
    if (missions.isEmpty) {
      emit(0.0);
      return;
    }

    int totalTasks = missions.length;
    int completedTasks = missions.where((mission) => mission.status == StatusEnum.completed).length;

    double progress = completedTasks / totalTasks;

    emit(progress);
  }
}