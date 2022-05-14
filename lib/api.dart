import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

class Api {
  String baseUrl = "http://tailorjoin.com/api/";

  Future loginRegister(Map data, String endPoint) async {
    String url = baseUrl + endPoint;
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(data));

    return response;
  }
}
