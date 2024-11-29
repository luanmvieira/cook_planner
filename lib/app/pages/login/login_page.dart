
import 'package:app_receitas/app/pages/home/home_page.dart';
import 'package:app_receitas/app/pages/login/cadastro_page.dart';
import 'package:app_receitas/app/pages/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}


class LoginPageState extends State<LoginPage> {

  LoginController controller = LoginController();

  @override
  void initState() {
    controller.checarLogado(context);
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<bool>(
        stream: controller.progressLogin.stream,
        initialData: true,
        builder: (context, snapshot) {
          return !snapshot.hasData || snapshot.data == true?
          Container(
            color: const Color(0xFF3D3D3D),
            child: const SpinKitFadingCircle(
              color: Color(0xFF531E0E),
              size: 45,
            ),
          )
              : Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                const SizedBox(height: 230),
                Center(
                  child: Image.asset(
                    'assets/images/logo1.png',
                    height: 80,
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0,left: 16.0),
                    child: SingleChildScrollView(
                      scrollDirection:Axis.vertical ,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top:50,left:40, right: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Center(
                                  child:Text(
                                      'Acesse sua conta',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)
                                  ),
                                ),
                                const SizedBox(height: 5),
                                TextField(
                                  controller: controller.emailLoginController,
                                  decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(12)),
                                      borderSide: BorderSide(
                                        width: 1.18,
                                        color: Colors.black,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(12)),
                                      borderSide: BorderSide(
                                        width: 1.18,
                                        color: Color(0xFF531E0E),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'E-mail',
                                    hintStyle: const TextStyle(
                                      color: Color(0xFF3D3D3D),
                                      fontSize: 15,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 21),
                                TextField(
                                  controller: controller.senhaLoginController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(12)),
                                      borderSide: BorderSide(
                                        width: 1.18,
                                        color: Colors.black,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(12)),
                                      borderSide: BorderSide(
                                        width: 1.18,
                                        color: Color(0xFF531E0E),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Senha',
                                    hintStyle: const TextStyle(
                                      color: Color(0xFF3D3D3D),
                                      fontSize: 15,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () async {
                                    var retorno = await controller.realizarLogin();
                                    if(retorno){
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomePage(),
                                        ),
                                      );
                                    }

                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: const Color(0xFF531E0E),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'ENTRAR',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CadastroPage(controller: controller,),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.yellow,
                                    backgroundColor: const Color(0xFFB87333),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'CRIAR CONTA',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );

        });
  }
}