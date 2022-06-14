import 'dart:convert';

class JsonRead {
  var jsonDecode;

  dynamic usuario() {
    jsonDecode = '''
            [
              {
              "id": 1,
              "login":"gus",
              "senha":"1",
              "nome":"gustavo",
              "chaveGerente": "123AbC456dEf",
              "gerente": true
              },
              {
              "id": 2,
              "login":"b1",
              "senha":"2",
              "nome":"bruno",
              "chaveGerente": "123AbC456dEf",
              "gerente": false
              }
            ]''';
    return json.decode(jsonDecode);
  }

  dynamic getHorarioGeral() {
    jsonDecode = '''
       [
          {
            "idusuario": 1,
            "saldototal": 24.12,
            "horarios": [
              {
                "data":"2021-05-27",
                "horario":"08:00:00"
              },
              {
                "data":"2021-05-27",
                "horario":"13:00:00"
              },
              {
                "data":"2021-05-27",
                "horario":"14:00:00"
              },
              {
                "data":"2021-05-27",
                "horario":"17:00:00"
              }
            ]
          },
           {
            "idusuario": 2,
            "saldototal": 29.54,
            "horarios": [
              {
                "data":"2021-05-27",
                "horario":"08:00:00"
              },
              {
                "data":"2021-05-27",
                "horario":"13:00:00"
              },
              {
                "data":"2021-05-27",
                "horario":"14:00:00"
              },
              {
                "data":"2021-05-27",
                "horario":"17:00:00"
              }
            ]
          }
        ]
    ''';
    return json.decode(jsonDecode);
  }
}
