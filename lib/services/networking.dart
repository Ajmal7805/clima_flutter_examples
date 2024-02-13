import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Networkinghelper {
  Networkinghelper(this.uri);
  final String uri;
  Future getdata() async {
    http.Response response = await http.get(Uri.parse(uri));
    log('response ${response.statusCode}');
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      log(response.statusCode.toString());
    }
  }
}
