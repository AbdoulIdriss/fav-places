import 'dart:io';
import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';

import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPlaceScreen extends ConsumerStatefulWidget {
  const NewPlaceScreen({
    super.key
  });

  @override
  ConsumerState<NewPlaceScreen> createState() => _NewPlaceState();
}

class _NewPlaceState extends ConsumerState<NewPlaceScreen> {

  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  void _savePlace(){

    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty || _selectedImage == null || _selectedLocation == null ) {
      return;
    }

    ref.read(userPlacesProvider.notifier).addPlace(enteredTitle , _selectedImage! , _selectedLocation!);

    Navigator.of(context).pop(); 
     
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  // var _enteredTitle = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              maxLength: 20,
              decoration: InputDecoration(
                labelText: 'Title'
              ),
              controller: _titleController ,
            ),
            const SizedBox(height: 10),
            //image input
            ImageInput(onPickImage: (image) 
              {
                _selectedImage = image;
              } ,
            ),
            const SizedBox(height: 10),

            //location
            LocationInput(
              onSelectLocation: (location) {
                _selectedLocation = location;
              } ,
            ),

            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _savePlace
              , 
              icon: Icon(Icons.add),
              label: Text('Add Place')
            )
          ],
        ),
      ),
    );
  }
}