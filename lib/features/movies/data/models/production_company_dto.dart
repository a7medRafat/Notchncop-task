class ProductionCompanyDto {
  final int id;
  final String name;
  final String? logoPath;

  const ProductionCompanyDto({
    required this.id,
    required this.name,
    required this.logoPath,
  });

  factory ProductionCompanyDto.fromJson(Map<String, dynamic> json) {
    return ProductionCompanyDto(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: (json['name'] as String?)?.trim().isNotEmpty == true
          ? (json['name'] as String).trim()
          : 'Unknown',
      logoPath: json['logo_path'] as String?,
    );
  }
}
