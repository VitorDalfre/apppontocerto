import 'package:flutter/material.dart';
import 'detalhado/detalhadoVO.dart';
import 'global.dart';

class ProviderNotifier with ChangeNotifier {
  EventoDetalhado eventoAF = EventoDetalhado();

  void notifyProvider() {
    notifyListeners();
  }
}

class EventoDetalhado with ChangeNotifier {
  DetalhadoJsonVO? agendaJson;
  Map<DateTime, List<dynamic>>? agendaEvento;
  List selectedEvents = [];

  void carregar(List<DetalhadoDiasVO> listaDias) {
    agendaEvento = DetalhadoJsonVO().toJson(listaDias);
    notificar();
  }

  DetalhadoVO getList(int i) {
    return DetalhadoVO.fromJson(this.selectedEvents[i]);
  }

  DetalhadoVO getMarker(Map<String, dynamic> events) {
    return DetalhadoVO.fromJson(events);
  }

  void notificar() {
    gProviderNotifier!.notifyProvider();
  }
}
