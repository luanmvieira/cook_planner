import 'package:app_receitas/app/models/receita_model.dart';
import 'package:app_receitas/app/pages/receitas/avaliar_receita_page.dart';
import 'package:app_receitas/app/pages/receitas/editar_receita_page.dart';
import 'package:app_receitas/app/pages/receitas/receitas_controller.dart';
import 'package:app_receitas/app/pages/receitas/nova_receita_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  ReceitasController controller = ReceitasController();

  @override
  void initState() {
    super.initState();
    controller.getTodasReceitas();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: controller.progressoGetReceitas.stream,
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
                  floatingActionButton: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: FloatingActionButton(
                        backgroundColor: const Color(0xFFB87333),
                        elevation: 10,
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 35,
                        ),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NovaReceitaPage(
                                receitasController: controller,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  appBar: AppBar(
                    backgroundColor: Color(0xFF531E0E),
                    title: Text(
                      "Minhas Receitas",
                      style: GoogleFonts.kings(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 32),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: GestureDetector(
                          onTap: (){
                            controller.getTodasReceitas();
                          },
                          child: Icon(Icons.refresh, color: Colors.white,),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: GestureDetector(
                          onTap: (){
                            controller.logOut(context);
                          },
                          child: Icon(Icons.exit_to_app, color: Colors.white,),
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.white,
                  body: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 16.0, left: 16.0),
                          child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: StreamBuilder<List<ReceitaModel>>(
                                  stream: controller.listReceitas.stream,
                                  initialData: [],
                                  builder: (context, snapshot) {
                                    return GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 16,
                                      ),
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        final receita = snapshot.data![index];
                                        return _cardReceita(receita);
                                      },
                                    );
                                  })),
                        ),
                      ),
                    ],
                  ),
                );
        });
  }

  Widget _cardReceita(ReceitaModel receita) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AvaliarReceitaPage(
              controller: controller,
              receitaModel: receita,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Image.network(
                receita.pathPhoto,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      receita.nome,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditarReceitaPage(
                            controller: controller,
                            receitaModel: receita,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.edit,
                      size: 16,
                      color: Color(0xFF531E0E),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
