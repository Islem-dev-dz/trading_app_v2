class TitreBoursier {
  final String libelle;
  final String code;
  final double prix;
  final String variation;
  final String categorie;
  final String type; // 'primaire' ou 'secondaire'

  TitreBoursier({
    required this.libelle,
    required this.code,
    required this.prix,
    required this.variation,
    required this.categorie,
    required this.type,
  });
}