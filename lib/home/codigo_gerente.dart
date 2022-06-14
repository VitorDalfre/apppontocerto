import 'package:flutter/material.dart';
import 'package:pontocerto/home/codigo_gerenteDAO.dart';
import 'package:pontocerto/home/home.dart';
import 'package:pontocerto/login/UsuarioVO.dart';
import 'package:pontocerto/tools.dart';

class CodigoGerente extends StatefulWidget {
  final UsuarioLogadoVO? usuarioVO;

  const CodigoGerente({Key? key, this.usuarioVO}) : super(key: key);
  @override
  _CodigoGerenteState createState() => _CodigoGerenteState();
}

class _CodigoGerenteState extends State<CodigoGerente> {
  TextEditingController chaveController = new TextEditingController();
  CodigoGerenteDAO codigoDAO = CodigoGerenteDAO();

  @override
  void initState() {
    super.initState();
    valorChave();
  }

  Future valorChave() async {
    chaveController.text = await codigoDAO.getCodigoGerente(
        widget.usuarioVO!.login!, widget.usuarioVO!.senha!);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Tools().goTo(
            context,
            HomeUI(
              usuarioVO: widget.usuarioVO!,
            ));
        return true;
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Text("Seu código de gerente: ")),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        textAlign: TextAlign.center,
                        readOnly: true,
                        controller: chaveController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
