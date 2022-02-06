import 'dart:convert';
import 'package:coid19tacker/Model/WorldStatesModel.dart';
import 'package:coid19tacker/Services/Utililtes/app_url.dart';
import 'package:coid19tacker/pages/countries_list.dart';
import 'package:http/http.dart' as http;

class StatesServices{

  Future<WorldStatesModel> fcethWorldRecords ()async{

    final response=await http.get(Uri.parse(App_url.worldStatesApi));

    if(response.statusCode==200){

      var data=jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);

    }else{
      throw Exception("Error");
    }

  }



  Future<List<dynamic>> CountriesList ()async{

    var data;

    final response=await http.get(Uri.parse(App_url.countriesList));

    if(response.statusCode==200){

      data=jsonDecode(response.body);
       WorldStatesModel.fromJson(data);

     return data;


    }else{
      throw Exception("Error");
    }

  }


}