
import 'package:app_receitas/app/models/receita_model.dart';
import 'package:app_receitas/app/pages/receitas/receitas_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';


class AvaliarReceitaPage extends StatefulWidget {
  ReceitasController controller = ReceitasController();
  ReceitaModel receitaModel = ReceitaModel();

  AvaliarReceitaPage({Key? key, required this.controller, required this.receitaModel}) : super(key: key);
  @override
  AvaliarReceitaPageState createState() => AvaliarReceitaPageState();
}


class AvaliarReceitaPageState extends State<AvaliarReceitaPage> {

  int _rating = 0;

  void _setRating(int value) {
    setState(() {
      _rating = value;
    });
  }

  @override
  void initState() {
    _setRating(widget.receitaModel.nota);
    super.initState();

  }

  @override
  void dispose() {

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: widget.controller.progressoAvaliarReceitas.stream,
        initialData: false,
        builder: (context, snapshot) {
          return !snapshot.hasData || snapshot.data == true ?
          Container(
            color: const Color(0xFF3D3D3D),
            child: const SpinKitFadingCircle(
              color: Color(0xFF531E0E),
              size: 45,
            ),
          )
              :Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF531E0E),
              title: Text(
                "Avalie a Receita",
                style: GoogleFonts.kings(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 32
                ),
              ),
            ),
            backgroundColor: Colors.grey[200],
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          widget.receitaModel.pathPhoto,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),

                    // Description
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Text(
                            'Nome: ${widget.receitaModel.nome}',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text('Tempo: ${widget.receitaModel.nome}', style: TextStyle(fontSize: 16)),
                          SizedBox(height: 8),
                          Text('Ingredientes: ${widget.receitaModel.ingredientes}', style: TextStyle(fontSize: 16)),
                          SizedBox(height: 8),
                          Text('Modo de Preparo: ${widget.receitaModel.modoPreparo}', style: TextStyle(fontSize: 16)),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),

                    // Rating
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Rate',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          // Widget para exibir as estrelas clicáveis
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(5, (index) {
                              return IconButton(
                                icon: Icon(
                                  index < _rating ? Icons.star : Icons.star_border,
                                  color: Colors.amber,
                                  size: 32,
                                ),
                                onPressed: () {
                                  _setRating(index + 1);
                                },
                              );
                            }),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),

                    // Button
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              widget.receitaModel.nota = _rating;
                              await widget.controller.avaliarReceita(context, widget.receitaModel);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF531E0E),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Salvar Avaliação',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        });

  }
}