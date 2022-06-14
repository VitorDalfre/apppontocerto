class BancoHorasVO {
  int? id;
  int? idUsuario;
  List<Horarios>? horarios;

  BancoHorasVO({this.id, this.idUsuario, this.horarios});

  BancoHorasVO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUsuario = json['idusuario'];
    if (json['horarios'] != null) {
      horarios = [];
      json['horarios'].forEach((v) {
        horarios!.add(Horarios.fromJson(v));
      });
    }
  }
}

class Horarios {
  // int idUsuario;
  String? data;
  String? horario;

  Horarios({this.data, this.horario});

  Horarios.fromJson(Map<String, dynamic> json) {
    // idUsuario = json['idusuario'];
    data = json['data'];
    horario = json['hora'];
  }
}

class SaldoTotal {
  String? saldoTotal;

  SaldoTotal({this.saldoTotal});

  SaldoTotal.fromJson(Map<String, dynamic> json) {
    saldoTotal = json['saldoTotal'];
  }
}
