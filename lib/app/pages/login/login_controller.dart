import 'dart:async';

import 'package:app_receitas/app/db/db_app.dart';
import 'package:app_receitas/app/models/user_model.dart';
import 'package:app_receitas/app/pages/home/home_page.dart';
import 'package:app_receitas/app/pages/login/db/db_login.dart';
import 'package:app_receitas/app/pages/login/init_page.dart';
import 'package:app_receitas/app/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';

class LoginController{
  DbLogin dbLogin = DbLogin();
  DbApp dbApp = DbApp();

  UserModel usuarioLogin = UserModel();

  StreamController<bool> progressLogin = BehaviorSubject<bool>();



  UserModel usuario = UserModel();


  final nomeCompletoController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  final emailLoginController = TextEditingController();
  final senhaLoginController = TextEditingController();

  limparControllers(){
    nomeCompletoController.clear();
    emailController.clear();
    senhaController.clear();
    emailLoginController.clear();
    senhaLoginController.clear();

  }

  checarLogado(BuildContext context) async {
    progressLogin.add(true);
    var retorno = await dbApp.checkCurrentUser();
    if(retorno){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
      progressLogin.add(false);
    }else{
      progressLogin.add(false);
    }

  }

  Future <bool> realizarLogin() async {
    bool retorno = false;
    if(emailLoginController.text.isNotEmpty  && senhaLoginController.text.isNotEmpty ){
      progressLogin.add(true);
      usuarioLogin = await dbLogin.getUserDataLogin(emailLoginController.text);
      usuarioLogin.password = senhaLoginController.text;
      if (usuarioLogin != null){
        var resultLogin = await dbLogin.logarUsuario(usuarioLogin);
        if (resultLogin == true){
          retorno = true;
          Fluttertoast.showToast(msg: 'LOGIN EFETUADO COM SUCESSO', timeInSecForIosWeb:3,backgroundColor: Colors.green);
        } else {
          retorno = false;
          Fluttertoast.showToast(msg: 'REVISE SUAS CREDENCIAIS', timeInSecForIosWeb:3,backgroundColor: Colors.red);
        }
      }
      progressLogin.add(false);
    }else{
      retorno = false;
      Fluttertoast.showToast(msg: 'INFORME SUAS CREDENCIAIS', timeInSecForIosWeb:3);
    }

    return retorno;


  }




  Future<bool> cadastrarUser () async {
    dynamic resultCadastro = false;
    if(emailController.text.isNotEmpty &&
        nomeCompletoController.text.isNotEmpty &&
        senhaController.text.isNotEmpty ) {
      if(senhaController.text.length < 6 ){
        Fluttertoast.showToast(
            msg: 'A senha cadastrada deve conter pelo menos 6 caracteres',
            timeInSecForIosWeb:3,
            backgroundColor: Colors.red);
      }else{
        usuario.email = emailController.text;
        usuario.nome = nomeCompletoController.text;
        usuario.password = senhaController.text;
        resultCadastro = await dbLogin.cadastrarUsuario(usuario);
        if (resultCadastro) {
          print("novo usuario criado com sucesso:${usuario.email}");
          print("---------Sucesso");
          resultCadastro = true;
        }else{
          resultCadastro = false;
        }

      }
    }else{
      Fluttertoast.showToast(
          msg: 'Preencha todos os dados para cadastrar',
          timeInSecForIosWeb:3,
          backgroundColor: Colors.red);
    }
    return resultCadastro;
  }
}