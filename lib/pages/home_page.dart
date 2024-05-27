import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_class_travel_app/cubit/app_cubit_states.dart';
import 'package:master_class_travel_app/cubit/app_cubits.dart';
import 'package:master_class_travel_app/misc/colors.dart';
import 'package:master_class_travel_app/widgets/app_large_text.dart';
import 'package:master_class_travel_app/widgets/app_text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Business>> fetchBusinesses() async {
  final response = await http.get(Uri.parse('http://localhost:5000/api/businesses'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> items = data['items'];

    return items.map((item) => Business.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load businesses');
  }
}

class Business {
  final int id;
  final int ownerId;
  final String title;
  final double rating;
  final String address; // Modificare: adresa este acum un șir de caractere

  Business({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.rating,
    required this.address,

  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'],
      ownerId: json['ownerId'],
      title: json['title'],
      rating: json['rating'].toDouble(),
      address: json['address']['street'], // Modificare: accesează direct strada din adresa
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
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
    );
  }
}

class BusinessGalleryPhotoDto {
  final int id;
  final String path;

  BusinessGalleryPhotoDto({
    required this.id,
    required this.path,
  });

  factory BusinessGalleryPhotoDto.fromJson(Map<String, dynamic> json) {
    return BusinessGalleryPhotoDto(
      id: json['id'],
      path: json['path'],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<Business>? businesses;

  var images = {
    'market.png': "Market",
    'patiserie.png': "Patiserie",
    'gym.png': "GYM",
    'local.png': "Local",
  };

  @override
  void initState() {
    super.initState();
    fetchBusinesses().then((businessesData) {
      setState(() {
        businesses = businessesData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);

    return Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: BlocBuilder<AppCubits, CubitStates>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 65,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppLargeText(text: 'Descoperă'),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Image.asset(
                            'img/logo_intercon.png',
                            height: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black54,
                      controller: tabController,
                      isScrollable: true,
                      indicator: CircleTabIndicator(radius: 1, color: AppColors.mainColor),
                      tabs: [
                        Tab(text: "Afaceri"),
                        Tab(
                          text: "Harta",
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    clipBehavior: Clip.none,
                    height: 370,
                    width: double.maxFinite,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        businesses != null ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: businesses?.length ?? 0,
                          itemBuilder: (context, index) {
                            final business = businesses![index];
                            return GestureDetector(
                              onTap: () {
                                // Logica pentru atingere aici
                              },
                              child: Container(
                                clipBehavior: Clip.none,
                                margin: EdgeInsets.only(right: 15, top: 10),
                                width: 200,
                                height: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomLeft,
                                    colors: [Colors.purpleAccent.withOpacity(0.4), Colors.deepPurpleAccent.withOpacity(0.6)],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 3,
                                      offset: Offset(5, 0), // changes position of shadow
                                    ),
                                    BoxShadow(
                                      color: Colors.white.withOpacity(1),
                                      spreadRadius: 2,
                                      blurRadius: 3,
                                      offset: Offset(-8, 0), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      bottom: 10,
                                      left: 0,
                                      right: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(4),
                                              width: 200,
                                              child: Text(
                                                business.title.toUpperCase(),
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 4.0,
                                                ),
                                                textAlign: TextAlign.center,
                                                softWrap: true,
                                              ),
                                            ),
                                            SizedBox(height: 75),
                                            Container(
                                              padding: EdgeInsets.all(4),
                                              child: Text(
                                                business.address,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            buildRatingStars(business.rating),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ) : CircularProgressIndicator(),
                        Text("Tab 2 content"),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppLargeText(text: "Explorează mai mult", size: 22),
                        AppText(
                          text: "Mai mult",
                          color: AppColors.textColor1,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                      width: double.maxFinite,
                      height: 120,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      image: DecorationImage(
                                        image: AssetImage('img/'+images.keys.elementAt(index)),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: AppText(text: images.values.elementAt(index), color: AppColors.textColor2),
                                  )
                                ],
                              ),
                            );
                          })),
                ],
              );
            },
          ),
        ));
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  final double radius;
  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  final double radius;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint paint = Paint();
    paint.color = color;
    paint.isAntiAlias = true;
    final Offset circleOffset = Offset(configuration.size!.width / 2 - radius / 2, configuration.size!.height - radius);

    canvas.drawCircle(circleOffset + offset, radius, paint);
  }
}

Row buildRatingStars(double rating) {
  List<Widget> stars = [];
  int numFullStars = rating.floor();
  for (int i = 0; i < numFullStars; i++) {
    stars.add(
      ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.purple.withOpacity(0.7), Colors.pink],
          ).createShader(bounds);
        },
        child: Icon(
          Icons.star,
          color: Colors.white, // ShaderMask aplică shader-ul peste această culoare
        ),
      ),
    );
  }

  if (rating - numFullStars >= 0.5) {
    stars.add(
      ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.purple, Colors.pink],
          ).createShader(bounds);
        },
        child: Icon(
          Icons.star_half,
          color: Colors.white,
        ),
      ),
    );
  }

  for (int i = numFullStars + (rating - numFullStars >= 0.5 ? 1 : 0); i < 5; i++) {
    stars.add(
      ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.purple.withOpacity(0.7), Colors.pink.withOpacity(0.7)],
          ).createShader(bounds);
        },
        child: Icon(
          Icons.star_border,
          color: Colors.white,
        ),
      ),
    );
  }

  // Modificarea aici: Asigură că stelele sunt centrate orizontal în Row.
  return Row(
    mainAxisSize: MainAxisSize.min, // Asigură că Row ocupă doar spațiul necesar pentru copii săi
    mainAxisAlignment: MainAxisAlignment.center, // Centrează elementele pe orizontală
    children: stars,
  );
}