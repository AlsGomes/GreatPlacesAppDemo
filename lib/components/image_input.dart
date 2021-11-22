import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageInput extends StatefulWidget {
  final Function(File) onSelectImage;

  const ImageInput({
    Key? key,
    required this.onSelectImage,
  }) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage = null;

  _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    XFile imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    ) as XFile;

    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await getApplicationDocumentsDirectory();
    String fileName = basename(_storedImage!.path);
    final savedImage = await _storedImage!.copy('${appDir.path}/$fileName');
    widget.onSelectImage(_storedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          height: 100,
          width: 180,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : const Text("Nenhuma Imagem"),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: FlatButton.icon(
            onPressed: _takePicture,
            icon: Icon(
              Icons.camera,
              color: Theme.of(context).primaryColor,
            ),
            label: const Text("Tirar Foto"),
          ),
        ),
      ],
    );
  }
}
