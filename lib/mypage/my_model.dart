import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class MyModel extends ChangeNotifier {
  bool isLoading = false;
  String? email;
  String? name;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void fetchUser() async{
    final user = FirebaseAuth.instance.currentUser;
    email = user?.email;
    name = user?.displayName;

    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot =
    await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final data = snapshot.data();
    name = data?['name'];

    notifyListeners();
  }
}