import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pontocerto/global.dart';

import 'UsuarioVO.dart';

class LoginDAO {
  final dio = Dio();
  StringBuffer sql = new StringBuffer();

  Future getUsuario() async {
    String servidor = "$linkServidor/getusuario";
    var response = await dio.get(servidor);
    List<UsuarioVO> usuario = [];

    // dynamic data = JsonRead().usuario();

    if (response.statusCode! >= 200 && response.statusCode! <= 250) {
      for (var node in response.data) {
        usuario.add(UsuarioVO.fromJson(node));
      }
    }
    await deleteAllUsuario();
    await insertAllUsuario(usuario);
  }

  Future deleteAllUsuario() async {
    sql = new StringBuffer();

    sql.write('usuario');

    await dbMaster!.delete(sql.toString());
  }

  Future insertAllUsuario(List<UsuarioVO> usuario) async {
    sql = new StringBuffer();
    sql.write(" INSERT INTO usuario ( ");
    sql.write(" id, ");
    sql.write(" login, ");
    sql.write(" senha, ");
    sql.write(" nome,  ");
    sql.write(" chaveGerente,  ");
    sql.write(" gerente ) ");
    sql.write("VALUES (?, ?, ?, ?, ?, ?) ");

    for (UsuarioVO node in usuario) {
      List params = [
        node.id,
        node.login,
        node.senha,
        node.nome,
        node.chaveGerente,
        node.gerente
      ];

      await dbMaster!.rawInsert(sql.toString(), params);
    }
  }

  Future<UsuarioLogadoVO> selectUsuario(String login, String senha) async {
    UsuarioLogadoVO usuarioVO = UsuarioLogadoVO();
    try {
      sql = StringBuffer();

      sql.write(" SELECT * FROM USUARIO ");
      sql.write(" WHERE login = '$login' ");
      sql.write(" AND senha = '$senha' ");

      final data = await dbMaster!.rawQuery(sql.toString());

      if (data.isNotEmpty) {
        for (final node in data) {
          final usuario = UsuarioLogadoVO.fromJson(node);
          usuarioVO = usuario;
        }
      }
    } catch (e) {
      if (login.isEmpty || senha.isEmpty) {
        Fluttertoast.showToast(
          msg: '$e',
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    }
    return usuarioVO;
  }
}
