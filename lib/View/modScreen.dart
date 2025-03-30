import 'package:convo/Controller/offlineSave.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:convo/Model/businessCard_model.dart';
import 'package:convo/View/Widget/BusinessCard.dart';

class modScreen extends StatefulWidget {
  const modScreen({super.key, required this.businessCardData});

  final BusinessCardModel businessCardData;

  @override
  _modScreenState createState() => _modScreenState();
}

class _modScreenState extends State<modScreen> {
  late TextEditingController _nameController;
  late TextEditingController _positionController;
  late List<TextEditingController> _infoControllers;
  late List<IconData> _icons;
  late int _selectedImage;
  int _listLength = 1;

  final List<IconData> _availableIcons = [
    FontAwesomeIcons.phone,
    FontAwesomeIcons.github,
    FontAwesomeIcons.linkedin,
    FontAwesomeIcons.globe,
    FontAwesomeIcons.locationDot,
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.businessCardData.name);
    _positionController = TextEditingController(
      text: widget.businessCardData.position,
    );
    _selectedImage =
        int.tryParse(
          widget.businessCardData.imagePath.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        1;
    _listLength = widget.businessCardData.contactInfo.length;
    _infoControllers =
        widget.businessCardData.contactInfo
            .map((info) => TextEditingController(text: info.info))
            .toList();
    _icons =
        widget.businessCardData.contactInfo.map((info) => info.icon).toList();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _positionController.dispose();
    for (var controller in _infoControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _saveAndReturn() {
    final updatedBusinessCard = BusinessCardModel(
      name: _nameController.text,
      position: _positionController.text,
      imagePath: "assets/$_selectedImage.jpg",
      contactInfo: List.generate(
        _listLength,
        (index) => BusinessInfo(
          info: _infoControllers[index].text,
          icon: _icons[index],
        ),
      ),
    );
    OfflineStorage().saveJson("My", updatedBusinessCard.toJson());
    Navigator.pop(context, updatedBusinessCard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Business Card"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveAndReturn,
        child: const Icon(Icons.done),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
            children: [
              const SizedBox(height: 20),
              businessCard(
                name:
                    _nameController.text.isEmpty
                        ? "Name"
                        : _nameController.text,
                position:
                    _positionController.text.isEmpty
                        ? "Position"
                        : _positionController.text,
                icons: _icons,
                info: _infoControllers.map((c) => c.text).toList(),
                image: "assets/$_selectedImage.jpg",
              ),
              const SizedBox(height: 20),
              Column(
                spacing: 20,
                children: [
                  _WidgetTextField(_nameController, "Enter Your Name"),
                  _WidgetTextField(_positionController, "Enter Your Position"),
                  SegmentedButton(
                    segments: List.generate(5, (index) {
                      int value = index + 1;
                      return ButtonSegment<int>(
                        value: value,
                        label: Text(value.toString()),
                      );
                    }),
                    selected: {_selectedImage},
                    onSelectionChanged: (Set<int> newSelection) {
                      setState(() => _selectedImage = newSelection.first);
                    },
                  ),
                  SizedBox(
                    height: _listLength * 80,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _listLength,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              DropdownButton<IconData>(
                                value: _icons[index],
                                items:
                                    _availableIcons
                                        .map(
                                          (icon) => DropdownMenuItem(
                                            value: icon,
                                            child: Icon(icon),
                                          ),
                                        )
                                        .toList(),
                                onChanged:
                                    (newIcon) => setState(
                                      () => _icons[index] = newIcon!,
                                    ),
                              ),
                              Expanded(
                                child: _WidgetTextField(
                                  _infoControllers[index],
                                  "Enter Data",
                                ),
                              ),
                              if (_listLength < 4 && index == _listLength - 1)
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _listLength++;
                                      _infoControllers.add(
                                        TextEditingController(),
                                      );
                                      _icons.add(_availableIcons.first);
                                    });
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                              if (_listLength > 1)
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _listLength--;
                                      _infoControllers.removeAt(index);
                                      _icons.removeAt(index);
                                    });
                                  },
                                  icon: const Icon(Icons.remove),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _WidgetTextField(TextEditingController controller, String label) {
    return AutoSizeTextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
      ),
      onChanged: (value) => setState(() {}),
    );
  }
}
