import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pontocerto/home/banco_horas/banco_horasDAO.dart';
import 'package:pontocerto/home/banco_horas/banco_horasVO.dart';
import 'package:pontocerto/login/cadastro_usuario/cadastro_usuarioUI.dart';
import 'package:pontocerto/login/loginDAO.dart';
import 'package:pontocerto/tools.dart';

import '../global.dart';
import '../home/home.dart';
import 'UsuarioVO.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({Key? key}) : super(key: key);

  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> with SingleTickerProviderStateMixin {
  AnimationController? animController;
  Animation? animUser;
  Animation? animPass;
  Animation? animOpacity;
  Animation? animButtonWidth;
  Animation? animButtonCirc;
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  FocusNode loginFocus = FocusNode();
  FocusNode senhaFocus = FocusNode();
  SaldoTotal saldoTotal = SaldoTotal();
  int? qtdMarcados;
  UsuarioLogadoVO? usuario;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    animController!.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    animUser = Tween<double>(begin: 0.0, end: 365.0).animate(CurvedAnimation(
        parent: animController!,
        curve: const Interval(0.0, 0.5, curve: Curves.bounceOut)));
    animPass = Tween<double>(begin: 0.0, end: 365.0).animate(CurvedAnimation(
        parent: animController!,
        curve: const Interval(0.0, 0.5, curve: Curves.bounceOut)));
    animOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        curve: const Interval(0.2, 0.6, curve: Curves.easeInOut),
        parent: animController!));
    animButtonWidth = Tween<double>(begin: 300.0, end: 55.0).animate(
        CurvedAnimation(
            curve: const Interval(0.0, 0.4, curve: Curves.bounceOut),
            parent: animController!));
    animButtonCirc = Tween<double>(begin: 10.0, end: 40.0).animate(
        CurvedAnimation(
            curve: const Interval(0.0, 0.4, curve: Curves.bounceOut),
            parent: animController!));
  }

  void goRoute() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomeUI()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: gappBar,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Center(
                    child: Container(
                      child: const Center(
                        child: Icon(
                          Icons.access_alarm,
                          color: Colors.white,
                          size: 70,
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                          color: gcorPrincipal,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(80),
                              bottomRight: Radius.circular(80),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Esse campo não pode ficar em branco";
                            }
                            return null;
                          },
                          onEditingComplete: () {
                            senhaFocus.requestFocus();
                          },
                          controller: loginController,
                          focusNode: loginFocus,
                          autofocus: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Login',
                              hintText: 'Login'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Esse campo não pode ficar em branco";
                            }
                            return null;
                          },
                          obscureText: true,
                          controller: senhaController,
                          focusNode: senhaFocus,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Senha',
                              hintText: 'Senha'),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedBuilder(
                  animation: animController!,
                  builder: (BuildContext context, child) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: MaterialButton(
                        child: Container(
                          decoration: BoxDecoration(
                              color: gcorPrincipal,
                              borderRadius:
                                  BorderRadius.circular(animButtonCirc!.value)),
                          child: Center(
                            child: animController!.value > 0
                                ? const CircularProgressIndicator()
                                : const Text(
                                    'ENTRAR',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                          ),
                          height: 50,
                          width: animButtonWidth!.value,
                        ),
                        onPressed: () async {
                          if (animController!.value > 0) {
                            animController!.reverse();
                          } else {
                            if (_formKey.currentState!.validate()) {
                              usuario = await LoginDAO().selectUsuario(
                                loginController.text,
                                senhaController.text,
                              );
                            }
                            if (usuario?.login != null) {
                              await animController!.forward();
                              saldoTotal = await BancoHorasDAO()
                                  .getSaltoTotal(usuario!.id!);
                              qtdMarcados = await BancoHorasDAO()
                                  .getQtdMarcacoes(DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month,
                                          DateTime.now().day - 1)
                                      .toString());
                              Future.delayed(
                                const Duration(milliseconds: 500),
                                () async {
                                  Tools().goTo(
                                      context,
                                      HomeUI(
                                        usuarioVO: usuario,
                                        saldoLogin: saldoTotal,
                                        qtdMarcacoes: qtdMarcados ?? 0,
                                      ));
                                },
                              );
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Login ou senha inválidos");
                            }
                          }
                        },
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: const Text("Criar novo cadastro!"),
                    onTap: () {
                      Tools().goTo(context, CadastroUsuarioUI());
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
