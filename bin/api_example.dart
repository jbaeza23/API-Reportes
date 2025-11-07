import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

void main() async {
  final router = Router();

  final reports = [
    {
      'user': 'Juan Pérez',
      'location': 'chiringuito chatarra ',
      'image': '🌆',
      'description': 'accidente de trafico',
      'time': 'Hace 1 hora',
    },
    {
      'user': 'Victoria seiko',
      'location': 'Parque mangos',
      'image': '🌳',
      'description': 'mucho trafico',
      'time': 'Hace 10 horas',
    },
    {
      'user': 'Luis Manuel Perpuly Jordan',
      'location': 'calle malandros',
      'image': '🚧',
      'description': 'poste caido',
      'time': 'Hace 19 horas',
    },
    {
      'user': 'Armando Paredes',
      'location': 'calle argentina',
      'image': '🚦',
      'description': 'robo',
      'time': 'Hace 8 horas',
    },
  ];

  final users = [
    {"name": "Luis", "age": 35, "phone": "612271564"},
    {"name": "rafa", "age": 20, "phone": "6122776219"}
  ];

  // Endpoints
  router.get('/hello', (Request request) {
    return Response.ok('Hola Mundo');
  });

  router.get('/reports', (Request request) {
    return Response.ok(jsonEncode(reports),
        headers: {'Content-Type': 'application/json'});
  });

  router.get('/users', (Request request) {
    return Response.ok(jsonEncode(users),
        headers: {'Content-Type': 'application/json'});
  });

  final handler =
      const Pipeline().addMiddleware(logRequests()).addHandler(router);

  await io.serve(handler, 'localhost', 8080);
  print('Servidor corriendo en el puerto 8080');
}