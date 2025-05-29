import 'package:xml/xml.dart';
import 'package:xml/xpath.dart';
import '../constants/CustomFunctions.dart';
import '../models/Currency.dart';
import 'package:http/http.dart' as http;

Future<List<Currency>> AltinkaynakSoapApi(
    int listLength, String listType) async {
  final response = await http.post(
      Uri.parse("http://data.altinkaynak.com/DataService.asmx"),
      body: CustomFunctions().altinkaynakRequestXml(listType),
      headers: {'Content-Type': 'text/xml'});

  var responseBody =
      XmlDocument.parse(XmlDocument.parse(response.body).innerText);
  var currencyList = <Currency>[];
  int i = 1;

  while (i <= listLength) {
    Currency currency = Currency(
        responseBody.xpath('//Kurlar/Kur[$i]/Kod/text()').single.toString(),
        responseBody
            .xpath('//Kurlar/Kur[$i]/Aciklama/text()')
            .single
            .toString(),
        double.parse(responseBody
            .xpath('//Kurlar/Kur[$i]/Alis/text()')
            .single
            .toString()),
        double.parse(responseBody
            .xpath('//Kurlar/Kur[$i]/Satis/text()')
            .single
            .toString()),
        responseBody
            .xpath('//Kurlar/Kur[$i]/GuncellenmeZamani/text()')
            .single
            .toString());
    currencyList.add(currency);
    i++;
  }
  return currencyList;
}
