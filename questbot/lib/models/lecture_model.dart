class Lecture {
  final String id;
  final String titlu;
  final String continut;
  final List<String>? raspunsuri;
  final int? raspunsCorect;

  Lecture({
    required this.id,
    required this.titlu,
    required this.continut,
    this.raspunsuri,
    this.raspunsCorect,
  });

  factory Lecture.fromJson(String id, Map<String, dynamic> json) {
    return Lecture(
      id: id,
      titlu: json['titlu'] ?? 'Titlu necunoscut',
      continut: json['continut'] ?? '',
      raspunsuri: json['raspunsuri'] != null
          ? List<String>.from(json['raspunsuri'])
          : null,
      raspunsCorect: json['corect'] is int ? json['corect'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titlu': titlu,
      'continut': continut,
      'raspunsuri': raspunsuri,
      'corect': raspunsCorect,
    };
  }
}
