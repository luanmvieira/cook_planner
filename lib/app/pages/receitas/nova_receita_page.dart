
import 'dart:io';

import 'package:app_receitas/app/pages/receitas/receitas_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';


class NovaReceitaPage extends StatefulWidget {
  ReceitasController receitasController = ReceitasController();

  NovaReceitaPage({Key? key, required this.receitasController}) : super(key: key);
  @override
  NovaReceitaPageState createState() => NovaReceitaPageState();
}


class NovaReceitaPageState extends State<NovaReceitaPage> {

  @override
  void dispose() {

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF531E0E),
        title: Text(
          "Cadastrar Receita",
          style: GoogleFonts.kings(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 32
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0,left: 16.0),
              child: SingleChildScrollView(
                scrollDirection:Axis.vertical ,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    Text("Nome da receita"),
                    TextField(
                      controller: widget.receitasController.nomeReceitaController,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide: BorderSide(
                            width: 1.18,
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
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
                    SizedBox(height: 10,),
                    Text("Tempo"),
                    TextField(
                      controller: widget.receitasController.tempoReceitaController,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide: BorderSide(
                            width: 1.18,
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
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
                    SizedBox(height: 10,),
                    Text("Ingredientes"),
                    TextField(
                      controller: widget.receitasController.ingredietesReceitaController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide: BorderSide(
                            width: 1.18,
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
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
                    SizedBox(height: 10,),
                    Text("Modo de Preparo"),
                    TextField(
                      controller: widget.receitasController.modoPreparoReceitaController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide: BorderSide(
                            width: 1.18,
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
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

                    widget.receitasController.photo != null ?
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0,bottom: 16.0),
                      child: Center(
                        child:Image.file(
                          File(widget.receitasController.photo!.path),
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        ) ,
                      ),
                    )
                    : const Padding(
                      padding: EdgeInsets.only(top: 16.0,bottom: 16.0),
                      child: Center(
                        child:SizedBox(
                          child: Text("A foto ainda não foi adicionada"),),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? photo = await picker.pickImage(
                              source: ImageSource.camera);
                          if(photo!= null){
                            widget.receitasController.photo = photo;
                            setState(() {
                              
                            });
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt, color: Colors.white,),
                            SizedBox(width: 10,),
                            Text(
                              'ADICIONAR FOTO',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                          ],
                        )
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          widget.receitasController.cadastraReceita(context);
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
                          'CADASTRAR RECEITA',
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
  }
}