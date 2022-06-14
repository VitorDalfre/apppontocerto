import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pontocerto/home/banco_horas/banco_horasDAO.dart';
import 'package:pontocerto/login/loginDAO.dart';

import 'database_creator.dart';

// import 'database.dart';

class Tools {
  Future<void> goTo(BuildContext context, Widget page) async {
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: page,
            duration: const Duration(milliseconds: 800)));
  }

  Future<void> loadDatabase() async {
    await DatabaseCreator().initDatabase();

    await LoginDAO().getUsuario();
    await BancoHorasDAO().getBancoHoras();
  }
}
