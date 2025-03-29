import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/superhero_model.dart';

class AuthService{
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static void saveLoginState(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userId', userId);
  }

  Future<void> registerSuperhero(
      SuperheroModel newHero) async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: newHero.email,
        password: newHero.password!,
      );

      String uid = userCredential.user!.uid;

      SuperheroModel superheroWithId = newHero.copyWith(id: uid);

      await saveSuperheroToFirestore(superheroWithId);

    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveSuperheroToFirestore(SuperheroModel superhero) async {
    try {
      CollectionReference superheroes =
      FirebaseFirestore.instance.collection('superheroes');

      await superheroes.doc(superhero.id).set(superhero.toMap());

    } catch (e) {
      rethrow;
    }
  }

  Future<bool> signInSuperhero(SuperheroModel hero) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: hero.email,
        password: hero.password!,
      );
      saveLoginState(userCredential.user!.uid);
      return userCredential.user != null;;
    } catch (e) {
      rethrow;
    }
  }
}



