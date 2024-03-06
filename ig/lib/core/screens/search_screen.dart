import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Photo {
  final String imageUrl;

  Photo({required this.imageUrl});
}

class SearchFeedScreen extends StatefulWidget {
  @override
  _SearchFeedScreenState createState() => _SearchFeedScreenState();
}

class _SearchFeedScreenState extends State<SearchFeedScreen> {
  List<Photo> _photos = [];

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchPhotos('nature'); // Initial search query for example
  }

  void _fetchPhotos(String query) async {
    final String apiKey = 'HylHlpOFu8cn4BY3GVNjMFWqn2oQVggVEOt2f4fQMKjqgltuIxfYXqlu';
    final String baseUrl = 'https://api.pexels.com/v1/search?query=$query';

    final response = await http.get(Uri.parse(baseUrl), headers: {
      'Authorization': apiKey,
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final photos = data['photos'];

      List<Photo> fetchedPhotos = photos.map<Photo>((photo) {
        return Photo(imageUrl: photo['src']['medium']);
      }).toList();

      setState(() {
        _photos = fetchedPhotos;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _fetchPhotos(_searchController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: _photos.length,
              itemBuilder: (context, index) {
                return _buildPhotoItem(_photos[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoItem(Photo photo) {
    return GestureDetector(
      onTap: () {
        // Handle photo tap
      },
      child: Image.network(
        photo.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SearchFeedScreen(),
  ));
}
