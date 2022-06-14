import 'package:intl/intl.dart';
import '../global.dart';
import 'detalhadoVO.dart';

class DetalhadoDAO {
  Future<List<DetalhadoVO>> selectAll() async {
    var sql = ''' SELECT * 
    FROM PONTO A
    ORDER BY A.dataHora ''';

    final data = await dbMaster!.rawQuery(sql);
    List<DetalhadoVO> objVOs = [];

    for (final node in data) {
      final objVO = DetalhadoVO.fromJson(node);
      objVOs.add(objVO);
    }
    return objVOs;
  }

  Future<List<DetalhadoDiasVO>> selectDias() async {
    String nomeForn = gmatricula;
    var sql;

    sql = ''' SELECT dataHora
    FROM PONTO P
    ''';

    if (nomeForn == null || nomeForn == '') {
      sql = sql + ''' GROUP BY dataHora  ''';
    } else {
      sql = sql + ''' WHERE matricula = '$nomeForn' GROUP BY dataHora  ''';
    }

    final data = await dbMaster!.rawQuery(sql);

    List<DetalhadoDiasVO> objVOs = [];

    for (var node in data) {
      String dataForn = DateFormat("yyyy-MM-dd")
          .format(DetalhadoDiasVO.fromJson(node, []).dia!);

      var sql2 = ''' SELECT A.*, 'loja' as loja
        FROM PONTO A
        WHERE strftime('%Y-%m-%d',A.dataHora)  = '$dataForn'  ''';
      if (nomeForn != "") {
        sql2 = sql2 + '''AND A.matricula = '$nomeForn' ''';
      }
      sql2 = sql2 + ''' ORDER BY dataHora ''';

      var resulForn = await dbMaster!.rawQuery(sql2);

      List<DetalhadoVO> listForn = [];

      for (var nodeForn in resulForn) {
        DetalhadoVO fornecedorVO = DetalhadoVO.fromJson(nodeForn);
        listForn.add(fornecedorVO);
      }

      DetalhadoDiasVO objVO = DetalhadoDiasVO.fromJson(node, listForn);
      objVOs.add(objVO);
    }

    var sqlForn = ''' SELECT matricula, operador
    FROM PONTO A ''';

    if (nomeForn == null || nomeForn == '') {
      sqlForn = sqlForn + ''' GROUP BY matricula, operador ''';
    } else {
      print(nomeForn);
      sqlForn = sqlForn +
          ''' WHERE A.matricula = '$nomeForn' GROUP BY matricula, operador ''';
    }

    final dataForn = await dbMaster!.rawQuery(sqlForn);
    List<FornecedorAgenda> objForn = [];

    for (final node in dataForn) {
      final obj = FornecedorAgenda.fromJson(node);
      objForn.add(obj);
    }

    gProviderNotifier!.eventoAF.carregar(objVOs);
    return objVOs;
  }

  static Future<void> deleteAll() async {
    String sql = ''' DELETE FROM PONTO ''';
    await dbMaster!.execute(sql);
  }
}
