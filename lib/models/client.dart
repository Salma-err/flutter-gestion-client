class Client {
  int id;
  String code;
  String nom;
  String prenom;
  String tel;
  String mail;
  bool verified;

  Client(
      {required this.id,
      required this.code,
      required this.nom,
      required this.prenom,
      required this.tel,
      required this.mail,
      required this.verified});

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      code: json['code'],
      nom: json['nom'],
      prenom: json['prenom'],
      tel: json['tel'],
      mail: json['mail'],
      verified: json['verified'],
    );
  }

  @override
  String toString() {
    return 'Client{id: $id, code: $code, nom: $nom, prenom: $prenom, tel: $tel, mail: $mail, verified: $verified }';
  }

  static getActiveClients(List<Client> list) {
    List<Client> clients = [];
    for (var element in list) {
      if (element.verified.toString() == 'true') {
        clients.add(element);
      }
    }
    return clients;
  }

  static getInactiveClients(List<Client> list) {
    List<Client> clients = [];
    for (var element in list) {
      if (element.verified.toString() != 'true') {
        clients.add(element);
      }
    }
    return clients;
  }

  static searchByName(List<Client> list, String? nomComplet) {
    List<Client> clients = [];
    for (var element in list) {
      String nomC = element.nom + ' ' + element.prenom;
      if (nomComplet != null) {
        if (nomC.toLowerCase().contains(nomComplet.toLowerCase())) {
          clients.add(element);
        }
      }
    }
    return clients;
  }
}
