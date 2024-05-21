import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import 'data.dart';
import 'detailspage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String apiUrl = 'https://restcountries.com/v3.1/all';
  List<Country>? countries;
    List<Country>? filteredCountries = [];
  
  List<String> regions = [];
  String? selectedRegion;


  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        countries = responseData.map((data) => Country.fromJson(data)).toList();
                filteredCountries = countries;

      });
    } else {
      throw Exception('Failed to load countries');
    }
  }

    void filterCountries(String query) {
    setState(() {
      filteredCountries = countries!.where((country) {
        return country.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Countries'),
      ),
      body: Column(
            children: [
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search by country name',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                filterCountries(value);
              },
            ),
          ),          Expanded(
            child: filteredCountries!.isNotEmpty
                ? ListView.builder(
                    itemCount: filteredCountries!.length,
                    itemBuilder: (context, index) {
                      final country = filteredCountries![index];
                      return ListTile(
                      leading:  SizedBox(
                      width: 35,
                      height: 35,
                      child: Image.network(
                       country.flagUrl,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                      ),
                    ),
                    title: Text(country.name),
               
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CountryDetailsPage(country: country),
                            ),
                          );
                        },
                      );
                    },
                  )
                
          : Shimmer.fromColors(
              baseColor: Color.fromARGB(255, 74, 70, 70),
              highlightColor: Color.fromARGB(255, 60, 56, 56),
              child: ListView.builder(
                itemCount: 5, // Set a placeholder number of items
                itemBuilder: (context, index) {
                  return ListTile(
                     title: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(36),
                        ),),
                        subtitle: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(36),
                        ),),
                  );
                }

              ),
          
          )
          ),
        ],
      ),
    );
  }
}
