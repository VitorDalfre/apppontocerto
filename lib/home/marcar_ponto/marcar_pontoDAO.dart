import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pontocerto/global.dart';

final dio = Dio();

class MarcarPontoDAO {
  Future setMarcarPonto(int idUsuario) async {
    Response? response;
    var url = '$linkServidor/setdatahora';
    dio.options.headers = {
      'accept': 'application/json',
      'content-type': 'application/json'
    };

    try {
      response = await dio.post(
        url,
        data: json.encode({
          'id': idUsuario,
        }),
      );
    } catch (e) {
      print(e);
      print(response?.data);
    }

    if (response != null && response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Ponto registrado",
        backgroundColor: Colors.green,
      );
      return true;
    } else {
      return false;
    }
  }
}
