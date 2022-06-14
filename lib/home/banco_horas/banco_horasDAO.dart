import 'package:dio/dio.dart';
import 'package:pontocerto/global.dart';
import 'package:pontocerto/home/banco_horas/banco_horasVO.dart';
import 'package:pontocerto/login/login_mockado.dart';
import 'package:pontocerto/login/registro_ponto_funcionario.dart';

class BancoHorasDAO {
  final dio = Dio();

  StringBuffer sql = new StringBuffer();

  Future getBancoHoras() async {
    String servidor = "$linkServidor/getdatahora";
    try {
      var response = await dio.get(servidor);
      List<BancoHorasVO> bancoHoras = [];

      // dynamic data = JsonRead().getHorarioGeral();
      if (response.statusCode! >= 200 && response.statusCode! <= 250) {
        for (var node in response.data) {
          bancoHoras.add(BancoHorasVO.fromJson(node));
        }
      }

      await deleteBancoHoras();
      await insertBancoHoras(bancoHoras);
    } catch (e) {
      print(e);
    }
  }

  Future deleteBancoHoras() async {
    sql = new StringBuffer();

    sql.write('banco_horas');

    dbMaster!.delete(sql.toString());

    sql = new StringBuffer();

    sql.write(' horarios_registrados');

    dbMaster!.delete(sql.toString());
  }

  Future insertBancoHoras(List<BancoHorasVO> bancoHoras) async {
    sql = new StringBuffer();
    sql.write(" INSERT INTO banco_horas (");
    sql.write(" idusuario ");
    sql.write(" )");
    sql.write(" VALUES (?) ");

    for (var node in bancoHoras) {
      List params = [
        node.idUsuario,
      ];
      await dbMaster!.rawInsert(sql.toString(), params);
      await insertHorarios(node.horarios!, node.idUsuario!);
    }
  }

  Future insertHorarios(List<Horarios> horarios, int idUsuario) async {
    sql = new StringBuffer();
    sql.write(" INSERT INTO horarios_registrados (");
    sql.write(" idusuario,");
    sql.write(" data,");
    sql.write(" horario )");
    sql.write(" VALUES (?,?,?)");

    for (var node in horarios) {
      List params = [
        idUsuario,
        node.data,
        node.horario,
      ];

      await dbMaster!.rawInsert(sql.toString(), params);
    }
  }

  Future<SaldoTotal> getSaltoTotal(int idUsuario) async {
    sql = StringBuffer();
    SaldoTotal saldoTotal = SaldoTotal(saldoTotal: '0.0');
    try {
      sql.write(
          "SELECT data FROM horarios_registrados WHERE idusuario = $idUsuario GROUP BY data");
      var datas = await dbMaster!.rawQuery(sql.toString());

      for (var node in datas) {
        sql = StringBuffer();

        sql.write(
            'SELECT max(horario), min(horario) FROM horarios_registrados ');
        sql.write('WHERE DATA = "${node.values.first}"');
        var valorMinMax = await dbMaster!.rawQuery(sql.toString());

        for (var node in valorMinMax) {
          String data1 = node.values.first.toString();
          String data2 = node.values.last.toString();

          sql = new StringBuffer();
          sql.write(" SELECT ");
          sql.write(" CASE WHEN ( ");
          sql.write(" SELECT TIME ('$data1', '-$data2')  <= '08:00:00') ");
          sql.write(" THEN '0' ");
          sql.write(" ELSE (");
          sql.write(" SELECT TIME ('$data1', '-$data2'))");
          sql.write(" END saldoTotal");

          var result = await dbMaster!.rawQuery(sql.toString());

          for (var node in result) {
            saldoTotal = SaldoTotal.fromJson(node);
            return saldoTotal;
          }
        }
      }
      return saldoTotal;
    } catch (e) {
      print(e);
      return saldoTotal;
    }
  }

  Future<int> getQtdMarcacoes(String data) async {
    sql = StringBuffer();
    int qtdMarcacoes = 0;
    String dataFormatada = data.substring(0, 11);

    sql.write(" SELECT COUNT(data) ");
    sql.write(" FROM horarios_registrados");
    sql.write(" WHERE data = '$dataFormatada'");

    var result = await dbMaster!.rawQuery(sql.toString());

    for (var node in result) {
      qtdMarcacoes = int.parse(node.values.first.toString());
      return qtdMarcacoes;
    }
    return qtdMarcacoes;
  }

  Future<List<RegistroPontoFuncionario>> getDatasPontosBatidosFuncionarios(
      {required String chaveGerente}) async {
    List<RegistroPontoFuncionario> listRegistroPonto = [];
    sql = StringBuffer();

    try {
      sql.write(" SELECT u.nome, hr.data, hr.horario  ");
      sql.write(" FROM horarios_registrados as hr ");
      sql.write(" inner join usuario as u on u.id = hr.idusuario ");
      sql.write(" WHERE u.chaveGerente = '$chaveGerente' ");
      sql.write(" and u.gerente = 0 ");
      sql.write(" and hr.data not null");
      sql.write(" order by data desc ");

      var result = await dbMaster!.rawQuery(sql.toString());

      for (var node in result) {
        listRegistroPonto.add(RegistroPontoFuncionario.fromJson(node));
      }
    } catch (e) {
      print(e);
    }
    return listRegistroPonto;
  }
}
