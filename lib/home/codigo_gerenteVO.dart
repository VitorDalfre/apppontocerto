class CodigoGerenteVO {
  String? chaveGerente;

  CodigoGerenteVO({this.chaveGerente});

  factory CodigoGerenteVO.fromJson(Map<String, dynamic> json) {
    return CodigoGerenteVO(
      chaveGerente: json['chaveGerente'],
    );
  }
}
