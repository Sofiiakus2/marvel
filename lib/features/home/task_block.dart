import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_t/data/models/mission_model.dart';
import 'package:marvel_t/data/services/missions_service.dart';
import 'package:marvel_t/theme.dart';

import '../../data/models/enums.dart';
import '../../state_management/progress_cubit.dart';


class TaskBlockView extends StatefulWidget {
  const TaskBlockView({
    super.key,
    required this.mission
  });

  final MissionModel mission;

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
                          onTap: (){
                            MissionModel updatedMission = widget.mission.copyWith(
                                status: StatusEnum.completed,
                                completedAt: DateTime.now(),
                            );

                            MissionService().updateMission(updatedMission);
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
