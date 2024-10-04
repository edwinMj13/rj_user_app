import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rj/utils/common.dart';

class AuthRepository {
  final firebaseAuth = FirebaseAuth.instance;
  final google = GoogleSignIn();

  //registration Method
  Future<User?> createUserWithUserNamePassword(
      {required String email, required String password}) async {
    try {
      final creds = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return creds.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak_password') {
        throw Exception('This Password is Weak');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email');
      }
    } catch (e) {
      // unknown errors
      throw Exception(e.toString());
    }
  }

  Future<User?> signInWithGoogle() async {
    User? user;
    try {
      final googleUser = await google.signIn();
      print("googleUser$googleUser");
      //if (googleUser == null) return null;
      final googleAuth = await googleUser!.authentication;
      final creds = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await firebaseAuth.signInWithCredential(creds);
      user = userCredential.user;
    } catch (e) {
      if (e is PlatformException) {
        print(" Exception Message : ${e.toString()}");
        print(" Exception Code : ${e.code}");
        //user.
      } else {
        print("Other Exception------ ${e.toString()}");
      }
    }

    return user;
  }

  Future<void> googleSignOut() async {
    print("SignOut Clicked");
    // Future.delayed(Duration(seconds: 3)).then((q){
    //   callback();
    // });
    final isSignedIn = await google.isSignedIn();
      print("Google SignOut Status $isSignedIn");
      if (isSignedIn) {
        try {
          await google.signOut().then((v){
          });
        }catch(e){
          print("Google SignOut Error  ${e.toString()}");
        }
      }

  }

  Future<bool> isLoggedIn() async {
    bool isSignedIn=false;
    try {
      isSignedIn = await google.isSignedIn();
    } catch (e) {
      //snackbar(context, s)
      print("await google.isSignedIn() Exception ${e.toString()}");
    }
    return isSignedIn;
  }



}
