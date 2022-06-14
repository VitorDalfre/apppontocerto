import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pontocerto/global.dart';
import 'package:pontocerto/login/loginDAO.dart';

final dio = Dio();

class CadastroUsuario {
  Future<bool> setCliente(String login, String senha, String nome,
      String chaveGerente, bool gerente) async {
    var response;
    var url = '$linkServidor/setusuario';
    dio.options.headers = {
      'accept': 'application/json',
      'content-type': 'application/json'
    };
    try {
      response = await dio.post(
        url,
        data: json.encode({
          'login': login,
          'senha': senha,
          'nome': nome,
          'chavegerente': chaveGerente,
          'gerente': gerente
        }),
      );
    } finally {
      print(response.body);
      dio.close();
    }

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Cadastrado",
        backgroundColor: Colors.green,
      );
      await LoginDAO().getUsuario();
      return true;
    } else {
      return false;
    }
  }
}
