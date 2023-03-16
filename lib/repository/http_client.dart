import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:voithy/model/register_request_body.dart';

class HttpClient {
  static const String _baseURL =
      "http://ec2-44-202-121-98.compute-1.amazonaws.com:5000";
  static final Map<String, String> _headers = {
    "Content-Type": "application/json",
    "Accept": "*/*",
    "Accept-Encoding": "gzip, deflate, br",
    "Connection": "keep-alive"
  };

  static Future<Response?> get(
      {required String endpoint,
      Map<String, String>? headers,
      Map<String, dynamic>? params}) async {
    headers?.addAll(_headers);
    String requestUrl = _baseURL + endpoint;
    Uri requestUri = (params == null
        ? Uri.parse(requestUrl)
        : Uri.parse(requestUrl).replace(queryParameters: params));
    var response = await http.get(requestUri, headers: headers);
    if (response.statusCode == 200) {
      return response;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return response;
    }
  }

  static Future<Response?> post(
      {required String endpoint,
      Map<String, String>? headers,
      Map<String, dynamic>? params,
      required Map<String, dynamic> body}) async {
    headers?.addAll(_headers);
    String requestUrl = _baseURL + endpoint;
    Uri requestUri = (params == null
        ? Uri.parse(requestUrl)
        : Uri.parse(requestUrl).replace(queryParameters: params));
    var response = await http.post(requestUri, headers: headers, body: body);
    if (response.statusCode == 201) {
      return response;
    } else if (response.statusCode == 200) {
      return response;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print('Request failed with status: ${response.body}.');
      return response;
    }
  }

  static Future<Response?> put(
      {required String endpoint,
      Map<String, String>? headers,
      Map<String, dynamic>? params,
      required Map<String, dynamic> body}) async {
    headers?.addAll(_headers);
    String requestUrl = _baseURL + endpoint;
    Uri requestUri = (params == null
        ? Uri.parse(requestUrl)
        : Uri.parse(requestUrl).replace(queryParameters: params));
    var response = await http.put(requestUri, headers: headers, body: body);
    if (response.statusCode == 201) {
      return response;
    } else if (response.statusCode == 200) {
      return response;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print('Request failed with status: ${response.body}.');
      return response;
    }
  }
}
