import 'package:flutter/material.dart';

class ImagePickerServicoWidget extends StatefulWidget {
  final ValueChanged<String> onImageSelected; // Função de callback para retornar a imagem selecionada

  const ImagePickerServicoWidget({super.key, required this.onImageSelected});

  @override
  ImagePickerServicoWidgetState createState() => ImagePickerServicoWidgetState();
}

class ImagePickerServicoWidgetState extends State<ImagePickerServicoWidget> {
  String _selectedImage = 'assets/images/logo.png'; // Imagem padrão

  // Lista de imagens locais
  final List<String> _imageOptions = [
    'assets/images/avatar.png',
    'assets/images/logo.png',
    'assets/images/background_image_chair.jpg',
    'assets/images/avatar.png',
    'assets/images/logo.png',
    'assets/images/background_image_chair.jpg',
    'assets/images/avatar.png',
    'assets/images/logo.png',
    'assets/images/background_image_chair.jpg',
    'assets/images/avatar.png',
    'assets/images/logo.png',
    'assets/images/background_image_chair.jpg',
  ];

  // Método para mostrar o modal de seleção de imagem
  void _showImageOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: _imageOptions.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedImage = _imageOptions[index];
                    });
                    widget.onImageSelected(_selectedImage); // Chama a função de callback com a imagem selecionada
                    Navigator.pop(context);
                  },
                  child: Image.asset(_imageOptions[index], width: MediaQuery.sizeOf(context).width / 2 - 40)),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _showImageOptions(context),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(_selectedImage), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Clique na imagem para trocar',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
