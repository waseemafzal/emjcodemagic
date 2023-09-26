// class Country {
//   final String countryId;
//   final String country;

//   Country({required this.countryId, required this.country});

//   factory Country.fromJson(Map<String, dynamic> json) {
//     return Country(
//       countryId: json['country_id'],
//       country: json['country'],
//     );
//   }
// }
class CountryModel {
  final String countryId;
  final String countryName;

  CountryModel({required this.countryId, required this.countryName});
}
