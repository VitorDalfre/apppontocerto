import 'package:rxdart/rxdart.dart';

import 'detalhadoDAO.dart';
import 'detalhadoVO.dart';

class DetalhadoService {
  final BehaviorSubject<bool> _listController =
      BehaviorSubject<bool>.seeded(true);
  Sink<bool> get listIn => _listController.sink;
  Observable<List<DetalhadoVO>>? listaVO;
  Observable<List<DetalhadoDiasVO>>? listaDiasVO;

  DetalhadoDAO objDAO = DetalhadoDAO();

  DetalhadoService() {
    listaVO = _listController.stream.asyncMap((d) => objDAO.selectAll());
    listaDiasVO = _listController.stream.asyncMap((d) => objDAO.selectDias());
  }

  dispose() {
    _listController.close();
  }
}
