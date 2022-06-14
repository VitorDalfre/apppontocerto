import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:pontocerto/home/home.dart';
import 'package:pontocerto/login/UsuarioVO.dart';
import 'package:pontocerto/tools.dart';
import '../global.dart';
import 'detalhadoDAO.dart';
import 'detalhadoUIPage.dart';

class DetalhadoUI extends StatefulWidget {
  final UsuarioLogadoVO? usuarioVO;

  const DetalhadoUI({Key? key, this.usuarioVO}) : super(key: key);
  _AgendaFornecedorUI createState() => _AgendaFornecedorUI();
}

class _AgendaFornecedorUI extends State<DetalhadoUI>
    with SingleTickerProviderStateMixin {
  double heightTransparent = 0.0;
  double widthTransparent = 0.0;
  double heightFiltro = 0.0;
  double heightItem = 150.0;
  Future<MultiProvider>? _futureValue;

  DetalhadoDAO? agendaFornecedorDAO;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  // Future<MultiProvider> futureValue() async {
  //   return MultiProvider(
  //     providers: [
  //       ChangeNotifierProvider.value(
  //         value: gProviderNotifier,
  //       ),
  //       Consumer<ProviderNotifier>(
  //         builder: (context, builded, _) {
  //           return Column(
  //             children: <Widget>[
  //               Expanded(
  //                 child: DetalhadoController(),
  //               ),
  //             ],
  //           );
  //         },
  //       )
  //     ],
  //   );
  // }

  @override
  void initState() {
    super.initState();
    // DetalhadoDAO().selectDias();
    // _futureValue = futureValue();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.usuarioVO!.nome);
    return WillPopScope(
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
                leading: GestureDetector(
                  onTap: () {
                    Tools().goTo(
                        context,
                        HomeUI(
                          usuarioVO: widget.usuarioVO,
                        ));
                  },
                  child: Icon(Icons.arrow_back),
                ),
                backgroundColor: gcorPrincipal,
                centerTitle: true,
                title: Text(
                  "Ponto Detalhado",
                ),
                actions: <Widget>[
                  MaterialButton(
                    onPressed: () {},
                    child: Text(
                      "Filtros",
                      style: TextStyle(color: Colors.white60),
                    ),
                  ),
                ]),
            body: DetalhadoUIPage(),
            // MultiProvider(
            //   providers: [
            //     ChangeNotifierProvider.value(
            //       value: gProviderNotifier,
            //     ),
            //     Consumer<ProviderNotifier>(
            //       builder: (context, builded, _) {
            //         return FutureBuilder<MultiProvider>(
            //           future: _futureValue,
            //           builder: (context, snapshot) {
            //             if (snapshot.connectionState == ConnectionState.waiting)
            //               return Center(child: CircularProgressIndicator());
            //             else
            //               return snapshot.data;
            //           },
            //         );
            //       },
            //     )
            //   ],
            // ),
          ),
        ],
      ),
      onWillPop: () async {
        Tools().goTo(
            context,
            HomeUI(
              usuarioVO: widget.usuarioVO,
            ));
        return true;
      },
    );
  }
}
