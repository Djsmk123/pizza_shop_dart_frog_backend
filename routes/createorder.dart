// ignore_for_file: avoid_dynamic_calls, noop_primitive_operations

import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../models/order_models.dart';
import '../services/database_services.dart';

Future<Response> onRequest(RequestContext context) async {
  return DatabaseService.startConnection(context, createOrder(context));
}

Future<Response> createOrder(RequestContext context) async {
  //check if the request is a POST request
  if (context.request.method == HttpMethod.post) {
    //check if headers is application/json
    final contentType = context.request.headers['content-type'];
    if (contentType == 'application/json; charset=utf-8') {
      //check if body is present
      final body = await context.request.json();

      if (body != null &&
          body['pizza_id'] != null &&
          body['user_id'] != null &&
          body['address'] != null &&
          body['phone_number'] != null) {
        //check valid pizza id

        final pizzas = await DatabaseService.pizzasCollections
            .findOne(where.eq('id', body['pizza_id']));
        final isValidPizzaId = pizzas != null && pizzas.isNotEmpty;
        if (isValidPizzaId) {
          final orders = OrderModel.fromJson({
            'id': DateTime.now().millisecondsSinceEpoch.toInt(),
            'pizza_id': body['pizza_id'],
            'user_id': body['user_id'],
            'status': 'pending',
            'address': body['address'],
            'phone_number': body['phone_number'],
          });
          await DatabaseService.ordersCollections.insert(orders.toJson());
          return Response.json(
            statusCode: 201,
            body: {
              'message':
                  'Order created successfully with order id: ${orders.id}'
            },
          );
        } else {
          return Response.json(
            statusCode: 404,
            body: {'message': 'Invalid spizza id'},
          );
        }
      } else {
        return Response.json(
          statusCode: 404,
          body: {'message': 'All fields are required'},
        );
      }
    }

    return Response.json(
      statusCode: 404,
      body: {'message': 'Content-Type must be application/json'},
    );
  }
  return Response.json(
    statusCode: 404,
    body: {'message': 'Method not allowed'},
  );
}
