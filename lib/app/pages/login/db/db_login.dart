import 'package:app_receitas/app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';





class DbLogin {
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<UserModel> getUserDataLogin(String emailLogin) async {
    UserModel _user = UserModel();
    QuerySnapshot _userQueryMatricula = await _db.collection("usuarios").where("email", isEqualTo: emailLogin).get();
    if(_userQueryMatricula.docs.isNotEmpty){
      _user = UserModel.fromMap(_userQueryMatricula.docs.first);
    }else{
    }
    return _user;
  }
  Future cadastrarUsuario(UserModel user) async {
    try {
      QuerySnapshot _userQueryMatricula = await _db.collection("usuarios").where("email", isEqualTo: user.email).get();
      if(_userQueryMatricula.docs.isNotEmpty){
        Fluttertoast.showToast(
            msg: "E-MAIL JA CADASTRADO, TENTE NOVAMENTE COM OUTRO EMAIL",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return false;
      }else{
        await _db.collection("usuarios").doc(user.email).set(user.toMap());
        print("Usuario Criado");
        await auth.createUserWithEmailAndPassword(
            email: user.email, password: user.password);
        return true;
      }
    } catch (e) {
      print("erro ao criar user $e");
      return false;
    }
  }

  Future logarUsuario(UserModel user) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      print("Login efetuado com sucesso");
      return true;
    } catch (error) {
      print("Logar usuario: erro " + error.toString());
      return false;
    }
  }
}
