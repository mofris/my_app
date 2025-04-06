class ContactModel {
  int? id;
  String? name;
  String? number;

  ContactModel({
    this.id,
    this.name,
    this.number,
  });

  // Convert JSON ke Model
  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'],
      name: json['name'],
      number: json['number'],
    );
  }

  // Convert Model ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'number': number,
    };
  }
}
