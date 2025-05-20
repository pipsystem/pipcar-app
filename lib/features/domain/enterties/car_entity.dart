// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'agency/agency_search_entity.dart';

class CarEntity extends CarDetailsBase {
  final String agencyId;
  CarEntity({
    required this.agencyId,
    required super.id,
    required super.carName,
    required super.carPlates,
    required super.carLat,
    required super.carLong,
    required super.timeUpdate,
    required super.carTypeName,
  });
}
