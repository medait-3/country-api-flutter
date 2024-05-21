class Country {
  final String name;
  final String capital;
  final String region;
  final String subregion;
    final String flagUrl;

  // Add more properties as needed

  Country({
    required this.name,
    required this.capital,
    required this.region,
    required this.subregion,
    required this.flagUrl,

    // Add more properties as needed
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'],
      capital: json['capital'].toString(),
      region: json['region'],
      subregion: json['subregion'].toString(),
      flagUrl: json['flags']['png'].toString(),

      // Add more properties as needed
    );
  }
}
