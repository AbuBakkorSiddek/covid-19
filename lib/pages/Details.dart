import 'package:coid19tacker/pages/dashboard.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {


  String name;
  String image;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      tests;

  Details({
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.todayRecovered,
    required this.active,
    required this.critical,
    required this.totalRecovered,
    required this.tests,
});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.068),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.06,),
                      ReuseableRow(title: "Cases", value: widget.totalCases.toString()),
                      ReuseableRow(title: "Recovered", value: widget.totalRecovered.toString()),
                      ReuseableRow(title: "Deaths", value: widget.totalDeaths.toString()),
                      ReuseableRow(title: "Critical", value: widget.critical.toString()),
                      ReuseableRow(title: "To day Recovered", value: widget.totalRecovered.toString()),
                    ],
                  ),
                ),
              ),

              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )

            ],
          )

        ],
      ),
    );
  }
}
