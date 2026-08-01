class AddressModel {
  final String name;
  final String city;
  final String state;
  final String phone;

  AddressModel({
    required this.name,
    required this.city,
    required this.state,
    required this.phone,
  });

  Map<String, dynamic> tojson() {
    return {
      'name': name,
      'city': city,
      'state': state,
      'phone': phone,
    };
  }

  factory AddressModel.fromjson(Map<String, dynamic> json) {
    return AddressModel(
      name: json['name'],
      city: json['city'],
      state: json['state'],
      phone: json['phone'],
    );
  }
}
