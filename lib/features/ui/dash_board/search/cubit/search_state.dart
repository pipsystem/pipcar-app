// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_cubit.dart';

enum SearchStatus { initial, searching, loading, loaded, renderingMarker }

enum LoadMarkerStatus { loading, loaded }

class SearchState extends Equatable {
  final SearchStatus status;
  final LoadMarkerStatus statusMarker;
  final List<AgencySearchEntity> agencies;
  final List<AgencySearchInforEntity> agencySearchInforList;
  final List<DistrictEntity> districts;
  final DistrictEntity? selectedDistrict;
  final DistrictEntity? selectedDistrictConfig;
  final List<ProvinceEntity> provinces;
  final ProvinceEntity? selectedProvince;
  final ProvinceEntity? selectedProvinceConfig;
  final CarTypeEntity carTypeEntity;
  final Map<MarkerId, Marker> markers;
  const SearchState({
    required this.status,
    required this.statusMarker,
    required this.agencies,
    required this.agencySearchInforList,
    required this.districts,
    this.selectedDistrict,
    this.selectedDistrictConfig,
    required this.provinces,
    this.selectedProvince,
    this.selectedProvinceConfig,
    required this.carTypeEntity,
    required this.markers,
  });

  factory SearchState.initial() => SearchState(
      status: SearchStatus.initial,
      statusMarker: LoadMarkerStatus.loaded,
      agencies: const [],
      agencySearchInforList: const [],
      districts: const [],
      selectedDistrict: null,
      selectedDistrictConfig: null,
      provinces: const [],
      selectedProvince: null,
      selectedProvinceConfig: null,
      markers: const <MarkerId, Marker>{},
      carTypeEntity: AppConstant.listCarType[0]);

  @override
  List<Object> get props => [
        status,
        statusMarker,
        selectedDistrict ?? "",
        selectedDistrictConfig ?? "",
        agencies,
        agencySearchInforList,
        provinces,
        selectedProvince ?? "",
        selectedProvinceConfig ?? "",
        carTypeEntity,
        markers,
      ];

  SearchState copyWith({
    SearchStatus? status,
    LoadMarkerStatus? statusMarker,
    List<AgencySearchEntity>? agencies,
    List<AgencySearchInforEntity>? agencySearchInforList,
    List<DistrictEntity>? districts,
    DistrictEntity? selectedDistrict,
    DistrictEntity? selectedDistrictConfig,
    List<ProvinceEntity>? provinces,
    ProvinceEntity? selectedProvince,
    ProvinceEntity? selectedProvinceConfig,
    CarTypeEntity? carTypeEntity,
    Map<MarkerId, Marker>? markers,
  }) {
    return SearchState(
      status: status ?? this.status,
      statusMarker: statusMarker ?? this.statusMarker,
      agencies: agencies ?? this.agencies,
      agencySearchInforList: agencySearchInforList ?? this.agencySearchInforList,
      districts: districts ?? this.districts,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
      selectedDistrictConfig:
          selectedDistrictConfig ?? this.selectedDistrictConfig,
      provinces: provinces ?? this.provinces,
      selectedProvince: selectedProvince ?? this.selectedProvince,
      selectedProvinceConfig:
          selectedProvinceConfig ?? this.selectedProvinceConfig,
      carTypeEntity: carTypeEntity ?? this.carTypeEntity,
      markers: markers ?? this.markers,
    );
  }
}
