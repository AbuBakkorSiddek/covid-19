import 'package:coid19tacker/Services/states_services.dart';
import 'package:coid19tacker/pages/Details.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  _CountriesListState createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _editingController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with Country Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  )),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: statesServices.CountriesList(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (!snapshot.hasData) {
                  return Shimmer.fromColors(
                    highlightColor: Colors.grey.shade700,
                    baseColor: Colors.grey.shade700,
                    child: ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                                title: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          );
                        }),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name =
                            snapshot.data![index]['country'].toString();

                        if (_editingController.text.isEmpty) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Details(
                                                image: snapshot.data![index]
                                                    ['countryInfo']['flag'],
                                                name: snapshot.data![index]
                                                    ['country'],
                                                totalCases: snapshot
                                                    .data![index]['totalCases'],
                                                totalRecovered:
                                                    snapshot.data![index]
                                                        ['totalRecovered'],
                                                totalDeaths:
                                                    snapshot.data![index]
                                                        ['totalDeaths'],
                                                active: snapshot.data![index]
                                                    [' active'],
                                                critical: snapshot.data![index]
                                                    ['critical'],
                                                todayRecovered:
                                                    snapshot.data![index]
                                                        [' todayRecovered'],
                                                tests: snapshot.data![index]
                                                    ['tests'],
                                              )));
                                },
                                child: ListTile(
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag']),
                                  ),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                ),
                              )
                            ],
                          );
                        } else if (name
                            .toLowerCase()
                            .contains(_editingController.text.toLowerCase())) {
                          return Column(
                            children: [
                              InkWell(

                                onTap:(){

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Details(
                                            image: snapshot.data![index]
                                            ['countryInfo']['flag'],
                                            name: snapshot.data![index]
                                            ['country'],
                                            totalCases: snapshot
                                                .data![index]['totalCases'],
                                            totalRecovered:
                                            snapshot.data![index]
                                            ['totalRecovered'],
                                            totalDeaths:
                                            snapshot.data![index]
                                            ['totalDeaths'],
                                            active: snapshot.data![index]
                                            [' active'],
                                            critical: snapshot.data![index]
                                            ['critical'],
                                            todayRecovered:
                                            snapshot.data![index]
                                            [' todayRecovered'],
                                            tests: snapshot.data![index]
                                            ['tests'],
                                          )));


                          },

                                child: ListTile(
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag']),
                                  ),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(
                                      snapshot.data![index]['cases'].toString()),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      });
                }
              },
            ),
          )
        ]),
      ),
    );
  }
}
