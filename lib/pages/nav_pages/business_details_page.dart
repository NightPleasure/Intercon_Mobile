import 'package:flutter/material.dart';
import 'bar_item_page.dart';

class BusinessDetailsPage extends StatelessWidget {
  final Business business;

  BusinessDetailsPage({required this.business});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalii Afacere'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Lista de fotografii cu afacerea
            Container(
              height: 200, // Ajustați înălțimea containerului în funcție de nevoi
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // Definiți direcția de defilare
                itemCount: business.galleryPhotos?.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(8),
                    width: 200, // Ajustați lățimea imaginii în funcție de nevoi
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(business.galleryPhotos![index].path),
                        fit: BoxFit.cover, // Asigurați-vă că imaginea acoperă complet containerul
                      ),
                    ),
                  );
                },
              ),
            ),

            // Denumirea afacerii
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                business.title!.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),

            // Descrierea completă
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                business.fullDescription ?? '',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),

            // Adresa afacerii
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Adresă: ${business.address.street}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),

            // Recenziile la afacere
            // Afișați aici lista de recenzii
          ],
        ),
      ),
    );
  }
}
