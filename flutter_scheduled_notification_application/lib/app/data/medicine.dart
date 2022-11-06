class Medicine {
  final int? id;
  final String name;
  final int frequency;

  Medicine(
      {this.id,
      required this.name,
      required this.frequency,});

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'] as int,
      name: json['name'] as String,
      frequency: json['frequency'] as int
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'frequency': frequency
    };
  }

  String toString() {
    return 'Medicine(id : $id, name: $name, frequency: $frequency)';
  }
}
