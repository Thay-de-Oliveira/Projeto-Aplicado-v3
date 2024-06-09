import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagensController {
  final ImagePicker _picker = ImagePicker();
  List<XFile> imageFiles = [];  // Correto: Usando XFile, não XFunction
  VoidCallback onImageAdded;  // Usando VoidCallback que é apropriado para callbacks sem parâmetros

  ImagensController({required this.onImageAdded});

  Future<void> takePicture() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      imageFiles.add(photo);
      onImageAdded();  // Notifica o listener que uma imagem foi adicionada
    }
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFiles.add(image);
      onImageAdded();  // Notifica o listener que uma imagem foi adicionada
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < imageFiles.length) {
      imageFiles.removeAt(index);
      onImageAdded();  // Notifica o listener que uma imagem foi removida
    }
  }
}