import 'package:dio/dio.dart';
import 'package:pontocerto/global.dart';

class CadastroUsuarioDAO {
  final dio = Dio();
  StringBuffer? sql;

  Future<bool> getChaveGerente(String chave) async {
    sql = new StringBuffer();

    sql!.write(" SELECT id FROM USUARIO");
    sql!.write(" WHERE chaveGerente = '$chave'");
    sql!.write(" LIMIT 1");

    List<Map<String, Object?>> result =
        await dbMaster!.rawQuery(sql.toString());

    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
