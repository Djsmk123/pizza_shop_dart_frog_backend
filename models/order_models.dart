// ignore_for_file: lines_longer_than_80_chars

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class OrderModel {
  OrderModel(
    this.userId,
    this.pizzaId,
    this.address,
    this.phoneNumber,
    this.status,
    this.id,
  );

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      $OrderModelFromJson(json);
  Map<String, dynamic> toJson() => $OrderModelToJson(this);
  final String? userId;
  final String? pizzaId;
  final String? address;
  final String? phoneNumber;
  final String? status;
  final int id;
}

OrderModel $OrderModelFromJson(Map<String, dynamic> json) {
  return OrderModel(
    json['user_id'] as String?,
    json['pizza_id'] as String?,
    json['address'] as String?,
    json['phone_number'] as String?,
    json['status'] as String?,
    json['id'] as int,
  );
}

Map<String, dynamic> $OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'pizza_id': instance.pizzaId,
      'address': instance.address,
      'phone_number': instance.phoneNumber,
      'status': instance.status,
      'id': instance.id,
    };
