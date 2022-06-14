import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pontocerto/login/UsuarioVO.dart';

import '../global.dart';

class DetalhadoUIPage extends StatefulWidget {
  final UsuarioLogadoVO? usuarioVO;

  const DetalhadoUIPage({Key? key, this.usuarioVO}) : super(key: key);
  @override
  _DetalhadoUIPageState createState() => _DetalhadoUIPageState();
}

class _DetalhadoUIPageState extends State<DetalhadoUIPage>
    with TickerProviderStateMixin {
  Animation? animOpacity;
  Animation? animSizeContainer;

  Color? canvasColor;
  Color colorSelected = Color(0xFFF7A417);
  Color itemColor = Color(0xFF474747);

  //Controlllers
  AnimationController? _animationController;
  CalendarFormat calendarController = CalendarFormat.month;

  //Tamanhos
  double heightTransparent = 0.0;
  double widthTransparent = 0.0;
  double heightFiltro = 0.0;
  double heightItem = 200.0;
  double circular = 8.0;
  double widthItem = 120.0;
  double kiconSize = 16.0;
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  ValueNotifier<List<dynamic>>? _selectedEvents;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;

  @override
  void initState() {
    super.initState();
    // calendarController = CalendarFormat();
    _selectedDay = _focusedDay;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    // _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    _animationController!.forward();
  }

  @override
  void dispose() {
    _selectedEvents?.dispose();
    super.dispose();
  }

  Map<DateTime, List<dynamic>>? agendaEvento;

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {}

  var _border = BoxDecoration(
    color: Color(0xFF474747),
    border: Border.all(width: 0.8),
    borderRadius: BorderRadius.circular(8),
  );

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _focusedDay = focusedDay;
        _selectedDay = selectedDay;
        // _selectedEvents!.value = _getEventsForDay(selectedDay);
      });
    }
  }

  // List<dynamic> _getEventsForDay(DateTime? day) {
  //   // return kEvents[day] ?? [];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              child: Container(
                color: canvasColor,
                child: TableCalendar(
                  firstDay: DateTime.utc(2000, 1, 1),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                  calendarFormat: calendarController,
                  locale: 'pt_BR',
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                  ),
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      bool outsideDay = day.month != calendarController.index;
                      bool weekend = (day.weekday == 7 || day.weekday == 6);

                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: gcinzaEscuro)),
                        child: Align(
                          alignment: Alignment(0, 0),
                          child: Text(
                            '${day.day}',
                            style: TextStyle(
                              color: weekend
                                  ? Colors.orange
                                      .withOpacity(outsideDay ? 0.5 : 1)
                                  : Colors.white
                                      .withOpacity(outsideDay ? 0.5 : 1),
                            ),
                          ),
                        ),
                      );
                    },
                    todayBuilder: (context, day, focusedDay) {
                      return Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.35),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: TextStyle().copyWith(fontSize: 16.0),
                          ),
                        ),
                      );
                    },
                    selectedBuilder: (context, day, focusedDay) {
                      return Container(
                        decoration: BoxDecoration(
                            color: colorSelected,
                            borderRadius:
                                BorderRadius.circular(gcircularRadius)),
                        width: 100,
                        height: 100,
                        child: Align(
                          alignment: Alignment(0, 0),
                          child: Text(
                            '${day.day}',
                          ),
                        ),
                      );
                    },
                  ),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    }
                  },
                  onFormatChanged: (format) {
                    if (calendarController != format) {
                      setState(() {
                        calendarController = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  // eventLoader: (day) {
                  //   return _getEventsForDay(day);
                  // }
                ),
                // calendarController: calendarController,
                // events: agendaEvento,
                // initialCalendarFormat: CalendarFormat.month,
                // formatAnimation: FormatAnimation.slide,
                // startingDayOfWeek: StartingDayOfWeek.sunday,
                // availableGestures: AvailableGestures.all,
                // calendarStyle: CalendarStyle(
                //   outsideDaysVisible: true,
                //   outsideWeekendStyle:
                //       TextStyle().copyWith(color: Colors.orange[300]),
                //   weekendStyle: TextStyle().copyWith(color: Colors.orange),
                // ),
                // daysOfWeekStyle: DaysOfWeekStyle(
                //   weekdayStyle: TextStyle().copyWith(color: Colors.white),
                //   weekendStyle: TextStyle().copyWith(color: Colors.orange),
                // ),
                // headerStyle: HeaderStyle(
                //   titleTextBuilder: (date, locale) =>
                //       toBeginningOfSentenceCase(
                //           DateFormat.MMMM(locale).format(date)),
                //   titleTextStyle: TextStyle(
                //     fontSize: 20,
                //   ),
                //   centerHeaderTitle: true,
                //   formatButtonVisible: false,
                //   leftChevronIcon: Icon(
                //     Icons.chevron_left,
                //     color: Colors.white,
                //   ),
                //   rightChevronIcon: Icon(
                //     Icons.chevron_right,
                //     color: Colors.white,
                //   ),
                // ),
                // builders: CalendarBuilders(
                //   dayBuilder: (context, date, _) {
                //     bool outsideDay =
                //         date.month != calendarController.focusedDay.month;
                //     bool weekend = (date.weekday == 7 || date.weekday == 6);

                //     return Container(
                //       decoration: BoxDecoration(
                //           border: Border.all(color: gcinzaEscuro)),
                //       child: Align(
                //         alignment: Alignment(0, 0),
                //         child: Text(
                //           '${date.day}',
                //           style: TextStyle(
                //             color: weekend
                //                 ? Colors.orange
                //                     .withOpacity(outsideDay ? 0.5 : 1)
                //                 : Colors.white
                //                     .withOpacity(outsideDay ? 0.5 : 1),
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                //   selectedDayBuilder: (context, date, _) {
                // return Container(
                //   decoration: BoxDecoration(
                //       color: colorSelected,
                //       borderRadius:
                //           BorderRadius.circular(gcircularRadius)),
                //   width: 100,
                //   height: 100,
                //   child: Align(
                //     alignment: Alignment(0, 0),
                //     child: Text(
                //       '${date.day}',
                //     ),
                //   ),
                // );
                //   },
                //   todayDayBuilder: (context, date, _) {
                //     return Container(
                //       width: 80,
                //       height: 80,
                //       decoration: BoxDecoration(
                //         color: Colors.orange.withOpacity(0.35),
                //         borderRadius: BorderRadius.all(Radius.circular(20)),
                //       ),
                //       child: Center(
                //         child: Text(
                //           '${date.day}',
                //           style: TextStyle().copyWith(fontSize: 16.0),
                //         ),
                //       ),
                //     );
                //   },
                //   markersBuilder: (context, date, events, holidays) {
                //     final children = <Widget>[];
                //     if (events.isNotEmpty) {
                //       children.add(
                //         Align(
                //           alignment: Alignment(1, 1),
                //           child: AnimatedContainer(
                //             duration: const Duration(milliseconds: 200),
                //             decoration: BoxDecoration(
                //               shape: BoxShape.rectangle,
                //               color: events.length % 2 == 0
                //                   ? gcardGreen
                //                   : gcardRed,
                //             ),
                //             width: 16.0,
                //             height: 16.0,
                //             child: Center(
                //               child: Text(
                //                 '${events.length}',
                //                 style: TextStyle().copyWith(
                //                   color: Colors.white,
                //                   fontSize: 12.0,
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ),
                //       );
                //     }
                //     return children;
                //   },
                // ),
                // onVisibleDaysChanged: _onVisibleDaysChanged,
              ),
            ),
            // padding: EdgeInsets.all(5),
            // color: canvasColor),
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, i) => Container(
                    height: heightItem / 2,
                    decoration: _border,
                    margin:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: gcardRed,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(circular),
                                  bottomLeft: Radius.circular(circular)),
                            ),
                            width: widthItem,
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.access_alarm,
                                    size: 30,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 4.0, bottom: 8),
                                  child: Text(
                                    "Ultimo Ponto",
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 4.0, bottom: 8),
                                  child: Text(
                                    "08:00:00",
                                  ),
                                ),
                              ],
                            )),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: canvasColor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(circular),
                                  bottomRight: Radius.circular(circular)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 31.0),
                                      child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: 'Nome do funcionário: \n',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.people,
                                          size: kiconSize,
                                        ),
                                        Flexible(
                                            child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 4),
                                                child: Text("Mateus")))
                                      ],
                                    ),
                                  ]),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
