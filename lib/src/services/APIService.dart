import 'dart:convert';
import 'package:http/http.dart' as http;

class APIService {
  static const String BASE_API_URL = 'https://api.escuelajs.co/api/v1/products';


  static Future<List<dynamic>> fetchData() async{

    try{
      final response = await http.get(Uri.parse(BASE_API_URL));
      if (response.statusCode==200){
        final data = json.decode(response.body);
        if (data is List){
          return data;
        }
        else{
          throw Exception('Did not get a list');
        }
      }
      else{
        throw Exception('Failed to get data: ${response.statusCode}');
      }
    }
    catch(error){
      throw Exception('Error fetching data: ${error.toString()}');
    }
  }

}