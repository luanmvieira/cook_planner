
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String nome;
  String email;
  String password;


  UserModel({
    this.nome = '',
    this.email = '',
    this.password = '',
  }
  );

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "nome" : nome,
      "email" : email,
    };
    return map;

  }

  factory UserModel.fromMap(DocumentSnapshot doc) {
    return UserModel(
      nome: doc['nome'],
      email: doc['email'],
    );
  }
}
