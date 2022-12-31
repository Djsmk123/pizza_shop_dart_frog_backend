// ignore_for_file: lines_longer_than_80_chars

import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../models/order_models.dart';
import '../services/database_services.dart';

Future<Response> onRequest(RequestContext context) async {
  return DatabaseService.startConnection(context, getOrders(context));
}

Future<Response> getOrders(RequestContext context) async {
  //check if the request is a GET request
  if (context.request.method == HttpMethod.get) {
    //check if user_id is present
    final params = context.request.uri.queryParameters;
    if (params.containsKey('user_id')) {
      final userId = params['user_id'];
      final doc = await DatabaseService.ordersCollections
          .find(where.eq('user_id', userId))
          .toList();
      final userOrders = doc.map(OrderModel.fromJson).toList();
      if (userOrders.isNotEmpty) {
        return Response.json(body: {'data': userOrders.toList()});
      }
    }
    return Response.json(body: {'message': 'User id not found'});
  }
  return Response.json(
    statusCode: 404,
    body: {'message': 'Method not allowed'},
  );
}
