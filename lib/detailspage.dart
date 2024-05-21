
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'data.dart';

class CountryDetailsPage extends StatelessWidget {
  final Country country;

  CountryDetailsPage({required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(country.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

          SizedBox(height: 11,),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: country.flagUrl,
                  placeholder: (context, url) => Image(
                  image: AssetImage("assets/placeholder.jpg"),
                            fit: BoxFit.cover,
                            height: 250,
                            width: 400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),
            Text(country.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            
            SizedBox(height: 5,),
            
            Text('Capital: ${country.capital}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.end,),
            Text('Region: ${country.region}'),
            Text('Subregion: ${country.subregion}'),
            // Add more information as needed
          ],
        ),
      ),
    );
  }
}
