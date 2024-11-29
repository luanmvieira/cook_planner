import 'package:app_receitas/app/models/receita_model.dart';
import 'package:app_receitas/app/pages/receitas/receitas_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class EditarReceitaPage extends StatefulWidget {
  ReceitasController controller = ReceitasController();
  ReceitaModel receitaModel = ReceitaModel();

  EditarReceitaPage(
      {Key? key, required this.controller, required this.receitaModel})
      : super(key: key);

  @override
  EditarReceitaPageState createState() => EditarReceitaPageState();
}

final nomeReceitaEditarController = TextEditingController();
final tempoReceitaEditarController = TextEditingController();
final ingredietesEditarReceitaController = TextEditingController();
final modoPreparoEditarReceitaController = TextEditingController();

class EditarReceitaPageState extends State<EditarReceitaPage> {
  @override
  void initState() {
    nomeReceitaEditarController.text = widget.receitaModel.nome;
    tempoReceitaEditarController.text = widget.receitaModel.tempo;
    ingredietesEditarReceitaController.text = widget.receitaModel.ingredientes;
    modoPreparoEditarReceitaController.text = widget.receitaModel.modoPreparo;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: widget.controller.progressoEditReceitas.stream,
        initialData: false,
        builder: (context, snapshot) {
          return !snapshot.hasData || snapshot.data == true
              ? Container(
                  color: const Color(0xFF3D3D3D),
                  child: const SpinKitFadingCircle(
                    color: Color(0xFF531E0E),
                    size: 45,
                  ),
                )
              : Scaffold(
                  appBar: AppBar(
                    backgroundColor: Color(0xFF531E0E),
                    title: Text(
                      "Edite sua Receita",
                      style: GoogleFonts.kings(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 32),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  body: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 16.0, left: 16.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text("Nome da receita"),
                                TextField(
                                  controller: nomeReceitaEditarController,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(0)),
                                      borderSide: BorderSide(
                                        width: 1.18,
                                        color: Colors.black,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(0)),
                                      borderSide: BorderSide(
                                        width: 1.18,
                                        color: Color(0xFF531E0E),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
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
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Tempo"),
                                TextField(
                                  controller: tempoReceitaEditarController,
                                  decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(0)),
                                      borderSide: BorderSide(
                                        width: 1.18,
                                        color: Colors.black,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(0)),
                                      borderSide: BorderSide(
                                        width: 1.18,
                                        color: Color(0xFF531E0E),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
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
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Ingredientes"),
                                TextField(
                                  controller:
                                      ingredietesEditarReceitaController,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(0)),
                                      borderSide: BorderSide(
                                        width: 1.18,
                                        color: Colors.black,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(0)),
                                      borderSide: BorderSide(
                                        width: 1.18,
                                        color: Color(0xFF531E0E),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
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
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Modo de Preparo"),
                                TextField(
                                  controller:
                                      modoPreparoEditarReceitaController,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(0)),
                                      borderSide: BorderSide(
                                        width: 1.18,
                                        color: Colors.black,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(0)),
                                      borderSide: BorderSide(
                                        width: 1.18,
                                        color: Color(0xFF531E0E),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
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
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  // O botão ocupará toda a largura disponível
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      widget.receitaModel.nome =
                                          nomeReceitaEditarController.text;
                                      widget.receitaModel.tempo =
                                          tempoReceitaEditarController.text;
                                      widget.receitaModel.ingredientes =
                                          ingredietesEditarReceitaController
                                              .text;
                                      widget.receitaModel.modoPreparo =
                                          modoPreparoEditarReceitaController
                                              .text;
                                      await widget.controller.editarReceita(
                                          context, widget.receitaModel);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor: const Color(0xFF531E0E),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      'EDITAR RECEITA',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
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
