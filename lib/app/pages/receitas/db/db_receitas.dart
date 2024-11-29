import 'dart:typed_data';

import 'package:app_receitas/app/models/receita_model.dart';
import 'package:app_receitas/app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';





class DbReceitas {
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<ReceitaModel>> getDataAllReceitas() async {
    List<ReceitaModel> receitas = [];
    QuerySnapshot _userQueryReceitas = await _db.collection("receitas")
        .where("email", isEqualTo: auth.currentUser!.email).get();
    if(_userQueryReceitas.docs.isNotEmpty){
      for(var doc in _userQueryReceitas.docs){
        receitas.add(ReceitaModel.fromMap(doc));
      }
    }
    return receitas;
  }
  Future<UserModel> getUserDataLogin() async {
    UserModel _user = UserModel();
    QuerySnapshot _userQueryMatricula = await _db.collection("usuarios").where("email", isEqualTo: auth.currentUser!.email).get();
    if(_userQueryMatricula.docs.isNotEmpty){
      _user = UserModel.fromMap(_userQueryMatricula.docs.first);
    }else{
    }
    return _user;
  }

  Future <String> uploadPhoto(String ref,Uint8List arquivo) async {
    final storageRef = FirebaseStorage.instance.ref();
    try {
      final spaceRef = storageRef.child("imagens/$ref");
      final path = spaceRef.fullPath;
      await spaceRef.putData(arquivo);
      print("Uploading complete to $path");
      return path;
    } catch (e) {
      print("Error uploading : $e");
      return " ";
    }
  }



  Future<bool> cadastrarNovaReceita(ReceitaModel receita) async {
    try {
      await _db.collection("receitas").doc("${receita.nome}_${receita.email}").set(receita.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

}
