import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_t/data/models/mission_model.dart';
import 'package:marvel_t/data/services/missions_service.dart';
import 'package:marvel_t/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/enums.dart';
import '../../state_management/progress_cubit.dart';


class TaskBlockView extends StatefulWidget {
  const TaskBlockView({
    super.key,
    required this.mission, required this.missions

  });

  final MissionModel mission;
  final List<MissionModel> missions;

  @override
  State<TaskBlockView> createState() => _TaskBlockViewState();
}

class _TaskBlockViewState extends State<TaskBlockView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Colors.white,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xfff0f0f7),
            Color(0xfff0f1f8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(10, 10),
          ),
          if(widget.mission.status == StatusEnum.ongoing)
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(-10, -8),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.mission.missionName} - ",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.mission.text,
                      style: Theme.of(context).textTheme.labelMedium,
                      maxLines: null,
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Treat level - ',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.mission.treatLevel.toString().split('.').last,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: widget.mission.treatLevel == TreatLevelEnum.worldEnding
                            ? primaryColor
                            : null,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Status - ',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          widget.mission.status.toString().split('.').last,
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: widget.mission.status == StatusEnum.completed
                                ? Colors.green
                                : null,
                          ),                    ),
                        SizedBox(width: 10,),
                        GestureDetector(
                          onTap: () async {
                            final prefs = await SharedPreferences.getInstance();
                            double savedEnergy = prefs.getDouble('energy') ?? 1.0;

                            double energyRequired = 0.0;

                            switch (widget.mission.treatLevel) {
                              case TreatLevelEnum.low:
                                energyRequired = 0.1;
                                break;
                              case TreatLevelEnum.medium:
                                energyRequired = 0.25;
                                break;
                              case TreatLevelEnum.high:
                                energyRequired = 0.45;
                                break;
                              case TreatLevelEnum.worldEnding:
                                energyRequired = 0.7;
                                break;
                            }

                            if (savedEnergy < energyRequired) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Your energy is too low!'))
                              );
                              return;
                            }

                            MissionModel updatedMission = widget.mission.copyWith(
                              status: StatusEnum.completed,
                              completedAt: DateTime.now(),
                            );
                            await MissionService().updateMission(updatedMission);

                            double newEnergy = (savedEnergy - energyRequired).clamp(0.0, 1.0);
                            await prefs.setDouble('energy', newEnergy);

                            context.read<ProgressCubit>().updateProgress(widget.mission);

                          },


                          child: Icon(
                              widget.mission.status == StatusEnum.completed
                                ? Icons.done
                                : Icons.close,
                              size: 18,
                              color: widget.mission.status == StatusEnum.completed
                               ? Colors.green
                              : primaryColor
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
