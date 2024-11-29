
import 'package:app_receitas/app/pages/home/home_page.dart';
import 'package:app_receitas/app/pages/login/cadastro_page.dart';
import 'package:app_receitas/app/pages/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class InitPage extends StatefulWidget {
  const InitPage({Key? key}) : super(key: key);
  @override
  InitPageState createState() => InitPageState();
}


class InitPageState extends State<InitPage> {

  LoginController controller = LoginController();

  @override
  void initState() {
    super.initState();
    controller.checarLogado(context);

  }

  @override
  void dispose() {

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return  Container(
      color: const Color(0xFF3D3D3D),
      child: const SpinKitFadingCircle(
        color: Color(0xFFFFD702),
        size: 45,
      ),
    );
  }
}