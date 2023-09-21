//import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> signIn({
    required String email,
    required String password,
    required String username,
    required String bio,
    //required Uint8 file
}) async{
    String response = "Something went wrong";
    try{
      if(email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty){
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential.user!.uid);
        await _firestore.collection('users').doc(userCredential.user!.uid).set(
            {
          'username': username,
          'uid': userCredential.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': []
        });
        response = 'success';
      }
    }
    catch(err){
      response = err.toString();
    }
    return response;
  }
}
