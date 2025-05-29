import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Investment.dart';

final String BASE_URL =
    "http://burakezer.com.tr/InvestmentTrackerRestApi/public/investment";

Future<List<Investment>> getMyInvestments(String userID) async {
  final response = await http.get(Uri.parse("$BASE_URL/'$userID'"));
  List<dynamic> jsonData = jsonDecode(response.body);
  return jsonData.map((data) => Investment.fromJson(data)).toList();
}

Future<void> addInvestment(Investment investment, String userID) async {
  http.post(Uri.parse('$BASE_URL/add'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'userID': userID,
        'currencyType': investment.currencyType,
        'amount': investment.amount,
        'totalInvestmentTl': investment.totalInvestmentTl,
        'valueCurrency': investment.valueCurrency,
      }));
}

Future<Investment> deleteInvestment(String userID, int id) async {
  final http.Response response = await http.delete(
    Uri.parse("$BASE_URL/'$userID'/$id"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return Investment.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to delete album.');
  }
}
