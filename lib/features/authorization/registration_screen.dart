import 'package:flutter/material.dart';
import 'package:marvel_t/features/authorization/iron_man_speech.dart';
import 'package:marvel_t/features/background.dart';
import 'package:marvel_t/theme.dart';

import '../hello_screen/speech_buble.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
         Background(),
          Positioned(
            left: 0,
            right: 0,
            top: 70,
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Text('REGISTRATION',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      // controller: passwordController,
                      style: Theme.of(context).textTheme.titleSmall,
                      decoration: InputDecoration(
                        labelText: 'SUPERHERO Name',
                        labelStyle: Theme.of(context).textTheme.titleSmall,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                            color: primaryColor,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      // controller: passwordController,
                      style: Theme.of(context).textTheme.titleSmall,
                      decoration: InputDecoration(
                        labelText: 'SUPER Email',
                        labelStyle: Theme.of(context).textTheme.titleSmall,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                            color: primaryColor,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                     // controller: passwordController,
                      style: Theme.of(context).textTheme.titleSmall,
                      decoration: InputDecoration(
                        labelText: 'SUPER SECRET Password',
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.remove_red_eye_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                        labelStyle: Theme.of(context).textTheme.titleSmall,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                            color: primaryColor,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.0),
                          ),
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Text(
                          'Create an account',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black),

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          IronManSpeech(ironManText: 'Let\'s create account for you!',),
          Positioned(
            bottom: 50,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/entering');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 15),
                child: Text(
                  'I\'m a superhero already!',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(color: primaryColor),

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
