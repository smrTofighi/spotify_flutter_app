import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_app/data/auth/model/create_user_req_model.dart';
import 'package:spotify_app/data/auth/model/login_user_req_model.dart';
import 'package:spotify_app/data/auth/model/user_model.dart';
import 'package:spotify_app/domain/auth/entity/user_entity.dart';

abstract class AuthFirebaseService {
  Future<Either> signIn(LoginUserReqModel user);
  Future<Either> signUp(CreateUserReqModel user);
  Future<Either> getUser();
  Future<bool> checkLogin();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signIn(LoginUserReqModel user) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      return Right('Login was successful!');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'The email address is not valid.';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided for that user';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signUp(CreateUserReqModel user) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      FirebaseFirestore.instance.collection('Users').doc(data.user?.uid).set({
        'name': user.fullName,
        'email': data.user!.email,
      });
      return Right('SignUp was successful!');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = await firebaseFirestore
          .collection('Users')
          .doc(firebaseAuth.currentUser?.uid)
          .get();

      log(user.data().toString());
      UserModel userModel = UserModel.fromJson(user.data()!);
      userModel.imageURL =
          firebaseAuth.currentUser?.photoURL ??
          "https://cdn-icons-png.flaticon.com/512/10542/10542486.png";

      UserEntity userEntity = userModel.toEntity();
      return Right(userEntity);
    } catch (e) {
      log(e.toString());
      return Left('Something went wrong');
    }
  }

  @override
  Future<bool> checkLogin() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final user = auth.currentUser;
      if (user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
