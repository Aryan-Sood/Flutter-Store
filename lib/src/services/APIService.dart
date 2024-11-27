import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService {
  static const String BASE_API_URL = 'https://api.escuelajs.co/api/v1/products';


  static void fetchData() async{

    final response = await http.get(Uri.parse(BASE_API_URL));

    print(response.body);
    // return response;
  }

}