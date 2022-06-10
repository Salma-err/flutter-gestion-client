class Chambre {
  int id;
  int numero;

  Chambre({required this.id, required this.numero});

  factory Chambre.fromJson(Map<String, dynamic> json) {
    return Chambre(
      id: json['id'],
      numero: json['numero'],
    );
  }

  static searchByNumero(List<Chambre> list, int num) {
    List<Chambre> chambres = [];
    for (var element in list) {
      if (num == element.numero) {
        chambres.add(element);
      }
    }
    return chambres;
  }
}
