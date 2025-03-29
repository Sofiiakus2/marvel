import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marvel_t/data/models/enums.dart';
import 'package:marvel_t/data/models/mission_model.dart';
import 'package:marvel_t/data/services/missions_service.dart';
import 'package:marvel_t/theme.dart';

class AddMissionDialog extends StatefulWidget {


  const AddMissionDialog();

  @override
  _AddMissionDialogState createState() => _AddMissionDialogState();
}

class _AddMissionDialogState extends State<AddMissionDialog> {
  final _formKey = GlobalKey<FormState>();
  final _missionNameController = TextEditingController();
  final _textController = TextEditingController();
  TreatLevelEnum _treatLevel = TreatLevelEnum.low;
  StatusEnum _status = StatusEnum.ongoing;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add new mission'),
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
      backgroundColor: primaryColor,
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                style: Theme.of(context).textTheme.titleSmall,
                controller: _missionNameController,
                decoration: InputDecoration(labelText: 'Mission name', labelStyle: Theme.of(context).textTheme.titleSmall),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter mission name';
                  }
                  return null;
                },
              ),
              TextFormField(
                style: Theme.of(context).textTheme.titleSmall,
                controller: _textController,
                decoration: InputDecoration(labelText: 'Description', labelStyle: Theme.of(context).textTheme.titleSmall),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter description';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<TreatLevelEnum>(
                value: _treatLevel,
                items: TreatLevelEnum.values.map((level) {
                  return DropdownMenuItem<TreatLevelEnum>(
                    value: level,
                    child: Text(level.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _treatLevel = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Treat level'),
              ),
              DropdownButtonFormField<StatusEnum>(
                value: _status,
                items: StatusEnum.values.map((status) {
                  return DropdownMenuItem<StatusEnum>(
                    value: status,
                    child: Text(status.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _status = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Status'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel',
          style: Theme.of(context).textTheme.titleMedium,
    ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final newMission = MissionModel(
                heroId: FirebaseAuth.instance.currentUser!.uid,
                missionName: _missionNameController.text,
                text: _textController.text,
                treatLevel: _treatLevel,
                status: _status,
                createdAt: DateTime.now(),
              );
              MissionService().createMission(newMission);
              Navigator.of(context).pop();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            side: BorderSide(color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text('Create',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}