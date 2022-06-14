import 'package:intl/intl.dart';

import '../global.dart';
import 'detalhadoDAO.dart';

class ListDetalhadoVO {
  List<DetalhadoVO>? vDetalhado;

  ListDetalhadoVO({
    this.vDetalhado,
  });

  factory ListDetalhadoVO.fromJson(Map<String, dynamic> json) {
    List vDetalhado = json['vDetalhado'];

    vDetalhado = vDetalhado.map((i) => DetalhadoVO.fromJson(i)).toList();

    DetalhadoDAO.deleteAll();
    return vDetalhado[0];
    // DetalhadoDAO.insertAll(vDetalhado);
  }
}

class DetalhadoVO {
  int? matricula;
  String? operador;
  String? dataHora;
  double? height;

  DetalhadoVO({this.matricula, this.operador, this.dataHora, this.height});

  factory DetalhadoVO.fromJson(Map<String, dynamic> json) {
    var venda = DetalhadoVO(
      operador: json['operador'],
      matricula: json['matricula'],
      dataHora: json['dataHora'],
      height: 60.0,
    );
    return venda;
  }

  Map<String, dynamic> toJson() {
    return {"operador": operador, "matricula": matricula, "dataHora": dataHora};
  }
}

class DetalhadoDiasVO {
  DateTime? dia;
  List<DetalhadoVO>? listaFornecedor;

  DetalhadoDiasVO({this.dia, this.listaFornecedor});

  factory DetalhadoDiasVO.fromJson(
      Map<String, dynamic> json, List<DetalhadoVO> list) {
    var dias = DetalhadoDiasVO(
        dia: DateTime.parse(json['dataHora']), listaFornecedor: list);

    return dias;
  }
}

class DetalhadoJsonVO {
  List<DetalhadoDiasVO>? listDias;

  DetalhadoJsonVO({this.listDias});

  Map<DateTime, List<dynamic>> toJson(List<DetalhadoDiasVO> list) {
    Map<DateTime, List<dynamic>> json = Map<DateTime, List<dynamic>>();
    for (var node in list) {
      json.putIfAbsent(node.dia!,
          () => node.listaFornecedor!.map((f) => f.toJson()).toList());

      if (DateFormat("yyyy-MM-dd").format(node.dia!) ==
              DateFormat("yyyy-MM-dd").format(DateTime.now()) &&
          gProviderNotifier!.eventoAF.selectedEvents.isEmpty) {
        gProviderNotifier!.eventoAF.selectedEvents =
            node.listaFornecedor!.map((f) => f.toJson()).toList();
      }
    }
    return json;
  }
}

class FornecedorAgenda extends DetalhadoVO {
  List<DetalhadoVO>? listaFornecedor;

  FornecedorAgenda({
    this.listaFornecedor,
    String? operador,
    int? matricula,
    String? dataHora,
  }) : super(
          operador: operador,
          matricula: matricula,
          dataHora: dataHora,
        );

  factory FornecedorAgenda.fromJson(Map<String, dynamic> json) {
    var fornecedor = FornecedorAgenda(
      operador: json['operador'],
      matricula: json['matricula'],
      dataHora: json['dataHora'],
    );

    return fornecedor;
  }
}
