// ignore_for_file: lines_longer_than_80_chars

import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../models/pizza_models.dart';
import '../services/database_services.dart';

Future<Response> onRequest(RequestContext context) async {
  return DatabaseService.startConnection(context, getPizzas(context));
}

Future<Response> getPizzas(RequestContext context) async {
  //check if the request is a GET request
  if (context.request.method == HttpMethod.get) {
    //check if query parameter is present
    final params = context.request.uri.queryParameters;

    if (params.containsKey('id')) {
      //return the pizza with the id
      final id = params['id'];

      final doc =
          await DatabaseService.pizzasCollections.findOne(where.eq('id', id));
      if (doc != null && doc.isNotEmpty) {
        final pizza = PizzaModel.fromJson(doc);
        return Response.json(
          body: {'data': pizza},
        );
      } else {
        return Response.json(
          statusCode: 404,
          body: {'message': 'Pizza not found'},
        );
      }
    } else {
      final docs = await DatabaseService.pizzasCollections.find().toList();
      final pizzas = docs.map(PizzaModel.fromJson).toList();
      return Response.json(
        body: {'data': pizzas},
      );
    }
  }

  return Response.json(
    statusCode: 404,
    body: {'message': 'Method not allowed'},
  );
}
