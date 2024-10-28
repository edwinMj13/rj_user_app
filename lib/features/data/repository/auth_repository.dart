import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rj/utils/common.dart';

class AuthRepository {
  final firebaseAuth = FirebaseAuth.instance;

  Future<dynamic> createUserWithEmailAndPassword(String email,String password)async {
    try {
      final cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user!;
    }on FirebaseException catch(e){
      print("Create User With Email And Password  COMMON    $e");
      if (e.code == 'weak-password'){
        print("weak-password $e");
        return "Please Use Strong Password";
      } else if (e.code == 'email-already-in-use'){
        print("email-already-in-use $e");
        return "Email Has Already Registered";
      }else if (e.code == 'invalid-email'){
        print("invalid-email $e");
        return "Please Format the Email";
      }
    }
      //print("createUserWithEmailAndPassword $e");

    return "";
  }

  Future<dynamic> signInUserWithEmailAndPassword(String email,String password)async {
    try {
      final cred = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print("signInUserWithEmailAndPassword\n"
          "\n"
          "\n"
          "\n"
          "${cred.user!}");
      return cred.user!;
    }on FirebaseAuthException catch(e){
      print("signInUserWithEmailAndPassword COMMON  $e");
      if (e.code == 'user-not-found') {
        print("signInUserWithEmailAndPassword $e");
        return "Usr Not Found, Please Sign-Up";
      } else if (e.code == "wrong-password") {
        print("signInUserWithEmailAndPassword $e");
        return "Please Check The Password";
      }
      else if (e.code == 'invalid-credential') {
      print("signInUserWithEmailAndPassword $e");
      return "Please Check The Credentials";
      }
    }
    return "";
  }

   Future<void> signOut()async {
    try {
      await firebaseAuth.signOut();
    }catch(e){
      print("signout $e");
    }
  }

   resetPassword(String email) async {
      try {
        await firebaseAuth.sendPasswordResetEmail(email: email);
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content: Text('Password reset email sent. Check your inbox.'),
        //   ),
        // );
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        print("resetPassword $e");
        switch (e.code) {
          case 'user-not-found':
            errorMessage = 'No user found with this email.';
            break;
          case 'invalid-email':
            errorMessage = 'The email address is badly formatted.';
            break;
          default:
            errorMessage = 'An error occurred. Please try again.';
        }

      }
  }

  //final google = GoogleSignIn();

  //registration Method
  /*Future<User?> createUserWithUserNamePassword(
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

*/

}
