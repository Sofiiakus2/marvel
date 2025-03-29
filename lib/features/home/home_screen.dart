import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_t/features/background.dart';
import 'package:marvel_t/features/home/avatar/avatar_circle.dart';
import 'package:marvel_t/features/home/missions/tasks.dart';

import '../../state_management/progress_cubit.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(color: Colors.black.withOpacity(0.7),),
          Positioned(
            left: 0,
            right: 0,
            top: 100,
            child: Center(
              child: BlocBuilder<ProgressCubit, double>(
                builder: (context, progress) {
                  return AvatarCircle(
                    progress: progress,
                    size: 250,
                    color: Colors.white,
                    blurRadius: 90,
                  );
                },
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 370,
            child: Column(
              children: [
                Text('Your missions',
                style: Theme.of(context).textTheme.titleMedium,
                ),
                TasksListView()
              ],
            ),
          )
        ],
      ),
    );
  }
}

