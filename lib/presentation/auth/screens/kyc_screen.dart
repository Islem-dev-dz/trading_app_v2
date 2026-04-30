import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({super.key});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  // Contrôleurs pour les champs texte
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _communeController = TextEditingController();
  final TextEditingController _wilayaController = TextEditingController();

  // Fichiers images
  File? _idCardImage;
  File? _residenceImage;
  File? _selfieImage;

  // Fonction pour choisir une image (Caméra ou Galerie)
  Future<void> _pickImage(ImageSource source, String type) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 50, // Optimisation pour l'envoi serveur
    );

    if (pickedFile != null) {
      setState(() {
        if (type == 'id') _idCardImage = File(pickedFile.path);
        if (type == 'residence') _residenceImage = File(pickedFile.path);
        if (type == 'selfie') _selfieImage = File(pickedFile.path);
      });
    }
  }

  // Affiche les options Caméra / Galerie
  void _showPickerOptions(BuildContext context, String type) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Prendre une photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera, type);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choisir depuis la galerie'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery, type);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, primaryColor.withValues(alpha: 0.1)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Icon(Icons.security_rounded, size: 60, color: primaryColor),
                  const SizedBox(height: 10),
                  Text(
                    'Vérification KYC',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 25),

                  // --- SECTION 1 : INFORMATIONS PERSONNELLES ---
                  _buildSectionTitle("Informations personnelles"),
                  const SizedBox(height: 15),
                  _buildTextField(_nomController, "Nom", Icons.person),
                  _buildTextField(
                      _prenomController, "Prénom", Icons.person_outline),
                  _buildTextField(
                      _phoneController, "N° de téléphone", Icons.phone,
                      keyboardType: TextInputType.phone),
                  _buildTextField(_adresseController, "Adresse complète",
                      Icons.location_on),
                  Row(
                    children: [
                      Expanded(
                          child: _buildTextField(
                              _communeController, "Commune", Icons.map)),
                      const SizedBox(width: 10),
                      Expanded(
                          child: _buildTextField(_wilayaController, "Wilaya",
                              Icons.location_city)),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // --- SECTION 2 : DOCUMENTS ---
                  _buildSectionTitle("Documents justificatifs"),
                  const SizedBox(height: 15),

                  _buildStepTile(
                    icon: Icons.badge_outlined,
                    title: "Pièce d'identité",
                    subtitle: "Carte nationale ou passeport",
                    isDone: _idCardImage != null,
                    onTap: () => _showPickerOptions(context, 'id'),
                  ),
                  const SizedBox(height: 12),
                  _buildStepTile(
                    icon: Icons.home_work_outlined,
                    title: "Certificat de résidence",
                    subtitle: "Justificatif de moins de 3 mois",
                    isDone: _residenceImage != null,
                    onTap: () => _showPickerOptions(context, 'residence'),
                  ),
                  const SizedBox(height: 12),
                  _buildStepTile(
                    icon: Icons.face_retouching_natural_outlined,
                    title: "Selfie (Photo de visage)",
                    subtitle: "Assurez-vous que votre visage est clair",
                    isDone: _selfieImage != null,
                    onTap: () => _showPickerOptions(context, 'selfie'),
                  ),

                  const SizedBox(height: 40),

                  // BOUTON FINAL
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitKyc,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      child: const Text('Envoyer mon dossier',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- WIDGETS DE CONSTRUCTION ---

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title,
          style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black87)),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, size: 20),
          labelText: label,
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.5),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? "Champ requis" : null,
      ),
    );
  }

  Widget _buildStepTile(
      {required IconData icon,
      required String title,
      required String subtitle,
      required bool isDone,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDone
              ? Colors.green.withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: isDone ? Colors.green : Colors.black12),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: isDone ? Colors.green : Colors.grey.shade200,
              child: Icon(isDone ? Icons.check : icon,
                  color: isDone ? Colors.white : Colors.black87),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(subtitle,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black54)),
                ],
              ),
            ),
            if (!isDone)
              const Icon(Icons.add_a_photo, color: Colors.blue, size: 20),
          ],
        ),
      ),
    );
  }

  void _submitKyc() {
    if (_formKey.currentState!.validate()) {
      if (_idCardImage == null ||
          _residenceImage == null ||
          _selfieImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Veuillez joindre tous les documents photo")),
        );
        return;
      }
      // Ici, tu appelles ton API pour envoyer les données
      context.push('/kyc-pending');
    }
  }
}
