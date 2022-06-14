// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:intl/intl.dart';
// import '../global.dart';
// import '../provider.dart';
// import 'detalhadoService.dart';
// import 'detalhadoVO.dart';

// class DetalhadoController extends StatefulWidget {
//   @override
//   _DetalhadoControllerState createState() => _DetalhadoControllerState();
// }

// class _DetalhadoControllerState extends State<DetalhadoController>
//     with TickerProviderStateMixin {
//   DetalhadoService _service;
//   Animation animOpacity;
//   Animation animSizeContainer;

//   Color canvasColor;
//   Color colorSelected = Color(0xFFF7A417);
//   Color itemColor = Color(0xFF474747);

//   //Controlllers
//   AnimationController _animationController;
//   CalendarController calendarController;

//   //Tamanhos
//   double heightTransparent = 0.0;
//   double widthTransparent = 0.0;
//   double heightFiltro = 0.0;
//   double heightItem = 200.0;
//   double circular = 8.0;
//   double widthItem = 120.0;
//   double kiconSize = 16.0;

//   @override
//   void initState() {
//     super.initState();
//     calendarController = CalendarController();
//     _service = DetalhadoService();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 400),
//     );

//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _service.dispose();
//     _animationController.dispose();
//     gProviderNotifier.eventoAF.selectedEvents.clear();
//     super.dispose();
//   }

//   void onDaySelected(List<dynamic> events) {
//     gProviderNotifier.eventoAF.selectedEvents = events;
//     gProviderNotifier.eventoAF.notificar();
//   }

//   void _onVisibleDaysChanged(
//       DateTime first, DateTime last, CalendarFormat format) {}

//   @override
//   Widget build(BuildContext context) {
//     canvasColor = Theme.of(context).canvasColor;

//     var _border = BoxDecoration(
//       color: itemColor,
//       border: Border.all(width: 0.8),
//       borderRadius: BorderRadius.circular(circular),
//     );

//     var _streamBuilder = StreamBuilder(
//       stream: _service.listaDiasVO,
//       builder: (context, AsyncSnapshot<List<DetalhadoDiasVO>> snapshot) {
//         if (snapshot.hasError) {
//           return Center(child: Text('Houve um erro'));
//         }
//         if (!snapshot.hasData)
//           return Center(
//             child: CircularProgressIndicator(),
//           );

//         gProviderNotifier.eventoAF.carregar(snapshot.data);

//         if (gProviderNotifier.eventoAF.agendaEvento.isEmpty) {
//           return Column(
//             children: <Widget>[
//               Container(
//                 child: Expanded(
//                   child: Center(child: Text("Não há dados a serem exibidos")),
//                 ),
//               ),
//             ],
//           );
//         }

//         return MultiProvider(
//             providers: [ChangeNotifierProvider.value(value: gProviderNotifier)],
//             child: Consumer<ProviderNotifier>(builder: (context, builded, _) {
//               return Stack(
//                 children: <Widget>[
//                   Column(
//                     mainAxisSize: MainAxisSize.max,
//                     children: <Widget>[
//                       Container(
//                           child: Container(
//                             color: canvasColor,
//                             child: TableCalendar(
//                               locale: 'pt_BR',
//                               calendarController: calendarController,
//                               events: builded.eventoAF.agendaEvento,
//                               initialCalendarFormat: CalendarFormat.month,
//                               formatAnimation: FormatAnimation.slide,
//                               startingDayOfWeek: StartingDayOfWeek.sunday,
//                               availableGestures: AvailableGestures.all,
//                               calendarStyle: CalendarStyle(
//                                 outsideDaysVisible: true,
//                                 outsideWeekendStyle: TextStyle()
//                                     .copyWith(color: Colors.orange[300]),
//                                 weekendStyle: TextStyle().copyWith(
//                                     color: Colors.orange), //blue[800]),
//                               ),
//                               daysOfWeekStyle: DaysOfWeekStyle(
//                                 weekdayStyle:
//                                     TextStyle().copyWith(color: Colors.white),
//                                 weekendStyle: TextStyle().copyWith(
//                                     color: Colors.orange), //blue[600]),
//                               ),
//                               headerStyle: HeaderStyle(
//                                 titleTextBuilder: (date, locale) =>
//                                     toBeginningOfSentenceCase(
//                                         DateFormat.MMMM(locale).format(date)),
//                                 titleTextStyle: TextStyle(
//                                   fontSize: 20,
//                                 ),
//                                 centerHeaderTitle: true,
//                                 formatButtonVisible: false,
//                                 leftChevronIcon: Icon(
//                                   Icons.chevron_left,
//                                   color: Colors.white,
//                                 ),
//                                 rightChevronIcon: Icon(
//                                   Icons.chevron_right,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               builders: CalendarBuilders(
//                                 dayBuilder: (context, date, _) {
//                                   bool outsideDay = date.month !=
//                                       calendarController.focusedDay.month;
//                                   bool weekend =
//                                       (date.weekday == 7 || date.weekday == 6);

//                                   return Container(
//                                     decoration: BoxDecoration(
//                                         border:
//                                             Border.all(color: gcinzaEscuro)),
//                                     child: Align(
//                                       alignment: Alignment(0, 0),
//                                       child: Text(
//                                         '${date.day}',
//                                         style: TextStyle(
//                                           color: weekend
//                                               ? Colors.orange.withOpacity(
//                                                   outsideDay ? 0.5 : 1)
//                                               : Colors.white.withOpacity(
//                                                   outsideDay ? 0.5 : 1),
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 selectedDayBuilder: (context, date, _) {
//                                   return FadeTransition(
//                                     opacity: Tween(begin: 0.0, end: 1.0)
//                                         .animate(_animationController),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           color: colorSelected,
//                                           borderRadius: BorderRadius.circular(
//                                               gcircularRadius)),
//                                       width: 100,
//                                       height: 100,
//                                       child: Align(
//                                         alignment: Alignment(0, 0),
//                                         child: Text(
//                                           '${date.day}',
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 todayDayBuilder: (context, date, _) {
//                                   return Container(
//                                     width: 80,
//                                     height: 80,
//                                     decoration: BoxDecoration(
//                                       color: Colors.orange.withOpacity(0.35),
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(20)),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         '${date.day}',
//                                         style: TextStyle()
//                                             .copyWith(fontSize: 16.0),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 markersBuilder:
//                                     (context, date, events, holidays) {
//                                   final children = <Widget>[];
//                                   if (events.isNotEmpty) {
//                                     children.add(
//                                       Align(
//                                         alignment: Alignment(1, 1),
//                                         child: AnimatedContainer(
//                                           duration:
//                                               const Duration(milliseconds: 200),
//                                           decoration: BoxDecoration(
//                                             shape: BoxShape.rectangle,
//                                             color: events.length % 2 == 0
//                                                 ? gcardGreen
//                                                 : gcardRed,
//                                           ),
//                                           width: 16.0,
//                                           height: 16.0,
//                                           child: Center(
//                                             child: Text(
//                                               '${events.length}',
//                                               style: TextStyle().copyWith(
//                                                 color: Colors.white,
//                                                 fontSize: 12.0,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   }
//                                   return children;
//                                 },
//                               ),
//                               onVisibleDaysChanged: _onVisibleDaysChanged,
//                             ),
//                           ),
//                           padding: EdgeInsets.all(5),
//                           color: canvasColor),
//                       Container(
//                           child: SizedBox(height: 8.0), color: canvasColor),
//                       Container(
//                           child: SizedBox(height: 8.0), color: canvasColor),
//                       Expanded(
//                           child: ListView.builder(
//                         itemCount: builded.eventoAF.selectedEvents.length,
//                         itemBuilder: (context, i) => Container(
//                             height: heightItem,
//                             decoration: _border,
//                             margin: EdgeInsets.symmetric(
//                                 horizontal: 8.0, vertical: 8.0),
//                             child: Row(
//                               children: <Widget>[
//                                 Flexible(
//                                   flex: 1,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: builded.eventoAF.selectedEvents
//                                                       .length %
//                                                   2 ==
//                                               0
//                                           ? gcardGreen
//                                           : gcardRed,
//                                       borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(circular),
//                                           bottomLeft:
//                                               Radius.circular(circular)),
//                                     ),
//                                     width: widthItem,
//                                     child: Center(
//                                         child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: <Widget>[
//                                         Icon(
//                                           Icons.access_alarm,
//                                           size: 30,
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.only(
//                                               top: 26.0, bottom: 8),
//                                           child: Text(
//                                             builded.eventoAF
//                                                 .getList(i)
//                                                 .dataHora
//                                                 .substring(11, 16),
//                                             style: TextStyle(
//                                                 fontSize: 30,
//                                                 fontWeight: FontWeight.w900),
//                                           ),
//                                         ),
//                                         Text(
//                                           builded.eventoAF.selectedEvents
//                                                           .length /
//                                                       2 ==
//                                                   0
//                                               ? "Atendido"
//                                               : "Não\nAtendido",
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       ],
//                                     )),
//                                   ),
//                                 ),
//                                 Flexible(
//                                   flex: 2,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: canvasColor,
//                                       borderRadius: BorderRadius.only(
//                                           topRight: Radius.circular(circular),
//                                           bottomRight:
//                                               Radius.circular(circular)),
//                                     ),
//                                     child: Padding(
//                                       padding: EdgeInsets.all(10),
//                                       child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceAround,
//                                           children: <Widget>[
//                                             Padding(
//                                               padding:
//                                                   EdgeInsets.only(left: 31.0),
//                                               child: RichText(
//                                                 text: TextSpan(children: [
//                                                   TextSpan(
//                                                       text: 'Matricula: ',
//                                                       style: TextStyle(
//                                                           fontWeight:
//                                                               FontWeight.bold)),
//                                                   TextSpan(
//                                                       text: builded.eventoAF
//                                                           .getList(i)
//                                                           .matricula
//                                                           .toString())
//                                                 ]),
//                                               ),
//                                             ),
//                                             Row(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: <Widget>[
//                                                 Icon(
//                                                   Icons.people,
//                                                   size: kiconSize,
//                                                 ),
//                                                 Flexible(
//                                                     child: Padding(
//                                                         padding:
//                                                             EdgeInsets.only(
//                                                                 left: 15),
//                                                         child: AutoSizeText(
//                                                           builded.eventoAF
//                                                               .getList(i)
//                                                               .operador,
//                                                           maxLines: 2,
//                                                           style: TextStyle(
//                                                               fontSize: 18),
//                                                         )))
//                                               ],
//                                             ),
//                                             Divider(
//                                               color: gcinzaClaro,
//                                             ),
//                                             Row(
//                                               children: <Widget>[
//                                                 Icon(
//                                                   Icons.perm_data_setting,
//                                                   size: kiconSize,
//                                                 ),
//                                                 Flexible(
//                                                     child: Padding(
//                                                         padding:
//                                                             EdgeInsets.only(
//                                                                 left: 12),
//                                                         child:
//                                                             AutoSizeText('-')))
//                                               ],
//                                             ),
//                                             Row(
//                                               children: <Widget>[
//                                                 Icon(
//                                                   Icons.photo_filter,
//                                                   size: kiconSize,
//                                                   color: Colors.white,
//                                                 ),
//                                                 Flexible(
//                                                     child: Padding(
//                                                         padding:
//                                                             EdgeInsets.only(
//                                                                 left: 12),
//                                                         child: Text(" - ")))
//                                               ],
//                                             ),
//                                           ]),
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             )),
//                       )),
//                     ],
//                   ),
//                 ],
//               );
//             }));
//       },
//     );
//     return _streamBuilder;
//   }
// }
