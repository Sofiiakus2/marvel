import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_t/features/authorization/entering_screen.dart';
import 'package:marvel_t/features/authorization/registration_screen.dart';
import 'package:marvel_t/features/hello_screen/hello_screen.dart';
import 'package:marvel_t/features/home/home_screen.dart';
import 'package:marvel_t/state_management/progress_cubit.dart';
import 'package:marvel_t/theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBgxj5t2avsPwVRBb43D_3BuhWClVURaK8',
          appId: '1:543688558218:android:8a3d89e0f94994c74f0f73',
          messagingSenderId: '543688558218',
          projectId: 'marvel-t'
      )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProgressCubit>(
          create: (context) => ProgressCubit(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Marvel',
        theme: lightTheme,
        initialRoute: '/',
        routes: {
          '/':(context) => HelloScreen(),
          '/registration':(context)=> RegistrationScreen(),
          '/entering':(context)=>EnteringScreen(),
          '/home':(context)=>HomeScreen(),
        },
      ),
    );
  }
}
