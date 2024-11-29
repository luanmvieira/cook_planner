
import 'package:app_receitas/app/pages/home/home_page.dart';
import 'package:app_receitas/app/pages/login/login_controller.dart';
import 'package:flutter/material.dart';


class CadastroPage extends StatefulWidget {
  LoginController controller = LoginController();
  CadastroPage({super.key, required this.controller});
  @override
  CadastroPageState createState() => CadastroPageState();
}


class CadastroPageState extends State<CadastroPage> {

  @override
  void dispose() {
    widget.controller.limparControllers();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 230),
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
                              'Cadastro',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextField(
                            controller: widget.controller.nomeCompletoController,
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
                              hintText: 'Nome Completo',
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
                            controller: widget.controller.emailController,
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
                            controller: widget.controller.senhaController,
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
                              var retorno = await widget.controller.cadastrarUser();
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
                              'CADASTRAR',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 16),
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
  }
}