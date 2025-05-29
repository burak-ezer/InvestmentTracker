class Investment {
  int? id;
  String currencyType;
  double amount;
  double totalInvestmentTl;
  double valueCurrency;
  String? buyDate;

  Investment(
      {required this.currencyType,
      required this.amount,
      required this.totalInvestmentTl,
      required this.valueCurrency,
      this.buyDate,
      this.id});

  factory Investment.fromJson(Map<String, dynamic> json) {
    return Investment(
        id: json['id'],
        currencyType: json['currencyType'],
        amount: double.parse(json['amount'].toString()),
        totalInvestmentTl: double.parse(json['totalInvestmentTl'].toString()),
        valueCurrency: double.parse(json['valueCurrency'].toString()),
        buyDate: json['buyDate']);
  }
}
