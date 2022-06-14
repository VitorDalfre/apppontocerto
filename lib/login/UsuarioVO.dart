class UsuarioVO {
  int? id;
  String? login;
  String? senha;
  String? nome;
  String? chaveGerente;
  bool? gerente;

  UsuarioVO({
    this.id,
    this.login,
    this.nome,
    this.senha,
    this.chaveGerente,
    this.gerente,
  });

  factory UsuarioVO.fromJson(Map<String, dynamic> json) {
    return UsuarioVO(
      id: json['id'],
      login: json['login'],
      senha: json['senha'],
      nome: json['nome'],
      chaveGerente: json['chavegerente'],
      gerente: json['gerente'],
    );
  }
}

class UsuarioLogadoVO {
  int? id;
  String? login;
  String? senha;
  String? nome;
  String? chaveGerente;
  int? gerente;

  UsuarioLogadoVO({
    this.id,
    this.login,
    this.nome,
    this.senha,
    this.chaveGerente,
    this.gerente,
  });

  factory UsuarioLogadoVO.fromJson(Map<String, dynamic> json) {
    return UsuarioLogadoVO(
      id: json['id'],
      login: json['login'],
      senha: json['senha'],
      nome: json['nome'],
      chaveGerente: json['chaveGerente'],
      gerente: json['gerente'],
    );
  }
}
