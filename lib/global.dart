import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:pontocerto/provider.dart';

Color gcorPrincipal = Colors.orange;
Color gcinzaEscuro = Color(0xFF444444);
Color gcardGreen = Color(0xFF0FB747);
Color gcardRed = Color(0xFFD04C39);
Color gcinzaClaro = Color(0xFFDCDCDC);

ProviderNotifier? gProviderNotifier;

AppBar gappBar = AppBar(
  backgroundColor: gcorPrincipal,
  title: Text('Ponto'),
  centerTitle: true,
);

Database? dbMaster;

double gcircularRadius = 8.0;
double gpadding = 8.0;

String gmatricula = '';

String linkServidor = 'http://192.168.2.101:9000';
