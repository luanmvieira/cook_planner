
import 'package:cloud_firestore/cloud_firestore.dart';

class ReceitaModel {
  String nome;
  String tempo;
  String ingredientes;
  String modoPreparo;
  String email;
  String pathPhoto;
  int nota;


  ReceitaModel({
    this.nome = '',
    this.tempo = '',
    this.ingredientes = '',
    this.modoPreparo = '',
    this.email = '',
    this.pathPhoto = '',
    this.nota = 0,
  }
      );

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "nome" : nome,
      "tempo" : tempo,
      "ingredientes" : ingredientes,
      "modo_preparo" : modoPreparo,
      "email" : email,
      "path_photo" : pathPhoto,
      "nota" : nota,
    };
    return map;

  }

  factory ReceitaModel.fromMap(DocumentSnapshot doc) {
    return ReceitaModel(
      nome: doc['nome'],
      tempo: doc['tempo'],
      ingredientes: doc['ingredientes'],
      modoPreparo: doc['modo_preparo'],
      email: doc['email'],
      pathPhoto: doc['path_photo'],
      nota: doc['nota'],
    );
  }
}
