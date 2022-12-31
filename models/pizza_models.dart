import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PizzaModel {
  PizzaModel({this.name, this.price, this.image, this.description, this.id});
  factory PizzaModel.fromJson(Map<String, dynamic> json) =>
      _$PizzaModelFromJson(json);
  final String? name;
  final int? price;
  final String? id;
  final String? image;
  final String? description;
  Map<String, dynamic> toJson() => _$PizzaModelToJson(this);
}

PizzaModel _$PizzaModelFromJson(Map<String, dynamic> json) {
  return PizzaModel(
    name: json['name'] as String?,
    price: json['price'] as int?,
    image: json['image'] as String?,
    description: json['description'] as String?,
    id: json['id'] as String?,
  );
}

Map<String, dynamic> _$PizzaModelToJson(PizzaModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'image': instance.image,
      'description': instance.description,
      'id': instance.id
    };
