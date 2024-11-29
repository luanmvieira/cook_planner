import 'dart:async';
import 'dart:typed_data';

import 'package:app_receitas/app/db/db_app.dart';
import 'package:app_receitas/app/models/receita_model.dart';
import 'package:app_receitas/app/models/user_model.dart';
import 'package:app_receitas/app/pages/login/db/db_login.dart';
import 'package:app_receitas/app/pages/login/login_page.dart';
import 'package:app_receitas/app/pages/receitas/db/db_receitas.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';

class ReceitasController {
  DbReceitas dbReceitas = DbReceitas();
  DbApp dbApp = DbApp();
  StreamController<List<ReceitaModel>> listReceitas =
      BehaviorSubject<List<ReceitaModel>>();
  StreamController<bool> progressoGetReceitas =
  BehaviorSubject<bool>();
  StreamController<bool> progressoEditReceitas =
  BehaviorSubject<bool>();
  StreamController<bool> progressoAvaliarReceitas =
  BehaviorSubject<bool>();

  XFile? photo;

  UserModel userModel = UserModel();




  final nomeReceitaController = TextEditingController();
  final tempoReceitaController = TextEditingController();
  final ingredietesReceitaController = TextEditingController();
  final modoPreparoReceitaController = TextEditingController();


  getTodasReceitas() async {
    progressoGetReceitas.add(true);
    List<ReceitaModel> listaReceitas = await dbReceitas.getDataAllReceitas();
    List<ReceitaModel> newListReceitas = [];
    for(var receita in listaReceitas){
      receita.pathPhoto = await getPathDownload(receita.pathPhoto);
      newListReceitas.add(receita);
    }
    listReceitas.add(newListReceitas);
    progressoGetReceitas.add(false);
  }

  Future <String> getPathDownload(String path) async {
    final ref = FirebaseStorage.instance.ref().child(path);
    if(path.contains("https://")){
      return path;
    }else{
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    }

  }

  getUser() async {
    userModel = await dbReceitas.getUserDataLogin();
  }

  cadastraReceita(BuildContext context) async {
    await getUser();
    progressoGetReceitas.add(true);
    if(photo != null){
      String pathPhoto = await dbReceitas.uploadPhoto("${userModel.email}_${nomeReceitaController.text}",await photo!.readAsBytes());
      if(pathPhoto != " "){
        ReceitaModel model = ReceitaModel();
        model.nome = nomeReceitaController.text;
        model.tempo = tempoReceitaController.text;
        model.ingredientes = ingredietesReceitaController.text;
        model.modoPreparo = modoPreparoReceitaController.text;
        model.email = userModel.email;
        model.nota = 3;
        model.pathPhoto = pathPhoto;
        var retorno = await dbReceitas.cadastrarNovaReceita(model);
        if(retorno){
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: 'Receita cadastrada com sucesso',
              timeInSecForIosWeb:3,
              backgroundColor: Colors.green);
          await getTodasReceitas();

        }else{
          Fluttertoast.showToast(
              msg: 'Erro ao cadastrar a receita',
              timeInSecForIosWeb:3,
              backgroundColor: Colors.red);

        }
      }else{
        Fluttertoast.showToast(
            msg: 'Ocorreu um erro, tente novamente',
            timeInSecForIosWeb:3,
            backgroundColor: Colors.red);
      }

    }else{
      Fluttertoast.showToast(
          msg: 'Adicione a foto',
          timeInSecForIosWeb:3,
          backgroundColor: Colors.red);
    }


    progressoGetReceitas.add(false);
  }


  editarReceita(BuildContext context, ReceitaModel receita) async {
    await getUser();
    progressoEditReceitas.add(true);
    var retorno = await dbReceitas.cadastrarNovaReceita(receita);
    if(retorno){
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: 'Receita editada com sucesso',
          timeInSecForIosWeb:3,
          backgroundColor: Colors.green);
      await getTodasReceitas();
    }else{
      Fluttertoast.showToast(
          msg: 'Erro ao editar a receita, tente novamente',
          timeInSecForIosWeb:3,
          backgroundColor: Colors.red);

    }

    progressoEditReceitas.add(false);
  }

  avaliarReceita(BuildContext context, ReceitaModel receita) async {
    await getUser();
    progressoAvaliarReceitas.add(true);
    var retorno = await dbReceitas.cadastrarNovaReceita(receita);
    if(retorno){
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: 'Receita avaliada com sucesso',
          timeInSecForIosWeb:3,
          backgroundColor: Colors.green);
      await getTodasReceitas();
    }else{
      Fluttertoast.showToast(
          msg: 'Erro ao avaliada a receita, tente novamente',
          timeInSecForIosWeb:3,
          backgroundColor: Colors.red);

    }

    progressoAvaliarReceitas.add(false);
  }

  logOut(BuildContext context) async {
    progressoAvaliarReceitas.add(true);
    var retorno = await dbApp.logOut();
    if(retorno){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
      Fluttertoast.showToast(
          msg: 'Logout efetuado com sucesso',
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green);
    }else{
      Fluttertoast.showToast(
          msg: 'Erro ao efetuar o Logout, tente novamente',
          timeInSecForIosWeb:3,
          backgroundColor: Colors.red);
    }

    progressoAvaliarReceitas.add(false);
  }


}
