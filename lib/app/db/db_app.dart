import 'package:app_receitas/app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class DbApp {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  UserModel _user = UserModel();


  bool resultado = false;

  Future<bool> checkCurrentUser() async {
    User? user = await _auth.currentUser;
    return user != null ? true : false;
  }

  Future <UserModel> getCurrentUser() async{
    QuerySnapshot _userQuery = await _db.collection("usuarios").where("email", isEqualTo: _auth.currentUser!.email).get();
    if(_userQuery.docs.isNotEmpty){
      _user = UserModel.fromMap(_userQuery.docs.first);
    }else{
    }
    return _user;
  }

  Future <bool> logOut() async {
    try{
      await _auth.signOut();
      return true;
    }catch(e){
      return false;
    }

  }

}