import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_t/data/models/mission_model.dart';
import 'package:marvel_t/data/services/missions_service.dart';
import 'package:marvel_t/data/services/notification/notification_service.dart';
import 'package:marvel_t/features/authorization/iron_man_speech.dart';
import 'package:marvel_t/features/home/task_block.dart';
import 'package:marvel_t/theme.dart';

import '../../data/models/enums.dart';
import '../../state_management/progress_cubit.dart';
import 'add_mission_dialog.dart';

class TasksListView extends StatelessWidget {
  List<MissionModel> missions = [];
  TasksListView({super.key});

  void checkPendingMissions() {
    int pendingMissions = missions.where((mission) => mission.status != StatusEnum.completed).length;

    if (pendingMissions > 5) {  // Show alert if more than 5 missions are pending
      NotificationService.showEmergencyAlert();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MissionModel>>(
      stream: MissionService().getHeroMissionsStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        missions = snapshot.data ?? [];
        if (missions.isEmpty) {
          return SizedBox(
            height: 500,
              child: GestureDetector(
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (context) => AddMissionDialog(),
                  );
                },
                  child: IronManSpeech(ironManText: 'Tap to create first mission!')));
        }
        checkPendingMissions();
       // NotificationService().checkPendingMissions(missions);
        return SizedBox(
          height: 500,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: missions.length + 1  ,
            itemBuilder: (context, index) {

              if (index < missions.length) {
                return GestureDetector(
                  onLongPress: (){
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: primaryColor,
                        title: Text('Delete this mission?'),
                        titleTextStyle: Theme.of(context).textTheme.titleMedium,
                        content: Text('Are you sure?'),
                        contentTextStyle: Theme.of(context).textTheme.titleMedium,
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel', style: Theme.of(context).textTheme.titleMedium,),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              MissionService().deleteMission(missions[index].id!);
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              side: BorderSide(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text('Delete', style: Theme.of(context).textTheme.titleMedium,),
                          ),
                        ],
                      ),
                    );
                  },
                    child: TaskBlockView(mission:missions[index], missions: missions,));
              } else {
                return _buildAddButton(context);
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddMissionDialog(),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text('Add new mission',
        style: Theme.of(context).textTheme.titleMedium,),
      ),
    );
  }
}
