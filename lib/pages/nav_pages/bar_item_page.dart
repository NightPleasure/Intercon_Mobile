import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'business_details_page.dart';

class Business {
  final int id;
  final int ownerId;
  final String? title;
  final String? shortDescription;
  final String? fullDescription;
  final double rating;
  final String logoPath;
  final List<BusinessGalleryPhoto>? galleryPhotos;
  final Address address;
  final int reviewsCount;
  final int category;

  Business({
    required this.id,
    required this.ownerId,
    this.title,
    this.shortDescription,
    this.fullDescription,
    required this.rating,
    required this.logoPath,
    this.galleryPhotos,
    required this.address,
    required this.reviewsCount,
    required this.category,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'],
      ownerId: json['ownerId'],
      title: json['title'],
      shortDescription: json['shortDescription'],
      fullDescription: json['fullDescription'],
      rating: json['rating'],
      logoPath: json['logoPath'],
      galleryPhotos: (json['galleryPhotos'] as List<dynamic>?)
          ?.map((photo) => BusinessGalleryPhoto.fromJson(photo))
          .toList(),
      address: Address.fromJson(json['address']),
      reviewsCount: json['reviewsCount'],
      category: json['category'],
    );
  }
}

class BusinessGalleryPhoto {
  final int id;
  final String path;

  BusinessGalleryPhoto({
    required this.id,
    required this.path,
  });

  factory BusinessGalleryPhoto.fromJson(Map<String, dynamic> json) {
    return BusinessGalleryPhoto(
      id: json['id'],
      path: json['path'],
    );
  }
}

class Address {
  final String street;
  final String latitude;
  final String longitude;

  Address({
    required this.street,
    required this.latitude,
    required this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class BusinessListPage extends StatefulWidget {
  const BusinessListPage({super.key});

  @override
  _BusinessListPageState createState() => _BusinessListPageState();
}

class _BusinessListPageState extends State<BusinessListPage> {
  late Future<List<Business>> _businesses;
  late int _currentPage = 1;
  late bool _isLoading = false;
  List<Business> _loadedBusinesses = [];

  @override
  void initState() {
    super.initState();
    _businesses = fetchBusinesses(_currentPage);
  }

  Future<List<Business>> fetchBusinesses(int page) async {
    final response = await http.get(Uri.parse('http://localhost:5000/api/businesses?page=$page'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];

      print("Data received: $data");

      return items.map((item) => Business.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load businesses');
    }
  }

  void _loadMoreBusinesses() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    _currentPage++;
    final businesses = await fetchBusinesses(_currentPage);

    setState(() {
      _loadedBusinesses.addAll(businesses);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('RECENZII'),
            Image.asset(
              'img/logo_intercon.png',
              height: 40,
              width: 40,
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove the shadow
      ),
      body: FutureBuilder<List<Business>>(
        future: _businesses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            _loadedBusinesses = snapshot.data!;
            print("Businesses: $_loadedBusinesses");
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!_isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                  _loadMoreBusinesses();
                }
                return true;
              },
              child: ListView.builder(
                itemCount: _loadedBusinesses.length + 1,
                itemBuilder: (context, index) {
                  if (index < _loadedBusinesses.length) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BusinessDetailsPage(business: _loadedBusinesses[index]),
                          ),
                        );
                      },
                      child: Container(
                        height: 200, // Adjust card height
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15), // Ajustează valoarea pentru a schimba raza de rotunjire
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            dense: true,
                            leading: Container(
                              width: 64, // Ajustează dimensiunea containerului în funcție de nevoile tale
                              height: 64,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle, // Definește forma containerului ca un cerc
                                image: DecorationImage(
                                  fit: BoxFit.cover, // Asigură acoperirea completă a containerului cu imaginea
                                  image: NetworkImage(_loadedBusinesses[index].logoPath), // Folosește NetworkImage pentru a încărca imaginea din URL
                                ),
                              ),
                            ),
                            title: Text(
                              _loadedBusinesses[index].title!.toUpperCase(),
                              textAlign: TextAlign.center, // Adăugat TextAlign.center
                              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 23),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 100), // Schimbat în top: 0
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start, // Ajustat la început
                                crossAxisAlignment: CrossAxisAlignment.end, // Ajustat în jos
                                children: [
                                  Icon(Icons.location_on),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      _loadedBusinesses[index].address.street,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BusinessListPage(),
  ));
}
