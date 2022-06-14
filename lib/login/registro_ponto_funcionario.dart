class RegistroPontoFuncionario {
  final String? nome;
  final String? horarioPontoBatido;
  final String? dataPontoBatido;

  const RegistroPontoFuncionario({
    required this.nome,
    required this.horarioPontoBatido,
    required this.dataPontoBatido,
  });

  factory RegistroPontoFuncionario.fromJson(Map<String, dynamic> json) {
    return RegistroPontoFuncionario(
        nome: json['nome'],
        horarioPontoBatido: json['horario'],
        dataPontoBatido: json['data']);
  }
}
