class Reservation {
  int id;
  int client;
  String nom;
  String prenom;
  int chambre;
  DateTime date_debut;
  DateTime date_fin;

  Reservation(
      {required this.id,
      required this.client,
      required this.nom,
      required this.prenom,
      required this.chambre,
      required this.date_debut,
      required this.date_fin});

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      client: json['client'],
      nom: json['nom'],
      prenom: json['prenom'],
      chambre: json['chambre'],
      date_debut: DateTime.parse(json['date_debut']),
      date_fin: DateTime.parse(json['date_fin']),
    );
  }

  @override
  String toString() {
    return 'Reservation{id: $id, client: $client, nom: $nom, prenom: $prenom, chambre: $chambre, date_debut: $date_debut, date_fin: $date_fin }';
  }

  static searchByName(List<Reservation> list, String? nomComplet) {
    List<Reservation> reservations = [];
    for (var element in list) {
      String nomC = element.nom + ' ' + element.prenom;
      if (nomComplet != null) {
        if (nomC.toLowerCase().contains(nomComplet.toLowerCase())) {
          reservations.add(element);
        }
      }
    }
    return reservations;
  }
}
