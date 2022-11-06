class Notification {
  final int? id;
  final int idMedicine;
  final String time;

  Notification({this.id, required this.idMedicine, required this.time});

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
        id: json['id'] as int,
        idMedicine: json['id_Medicine'] as int,
        time: json['time'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_medicine': idMedicine,
      'time': time,
    };
  }

  String toString() {
    return 'Notification(id : $id, id_medicine: $idMedicine, time: $time)';
  }
}
