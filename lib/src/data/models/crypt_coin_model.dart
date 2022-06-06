class CryptCoinModel {
  String? message;
  String? walletId;
  String? userBalance;
  List<Data>? data;

  CryptCoinModel({
    this.message,
    this.walletId,
    this.userBalance,
    this.data,
  });

  CryptCoinModel.fromJson(dynamic json) {
    message = json['message'];
    walletId = json['wallet_id'];
    userBalance = json['user_balance'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  String? currencyName;
  String? cotation;
  String? symbol;
  String? imageUrl;
  Details? details;

  Data({
    this.currencyName,
    this.cotation,
    this.symbol,
    this.imageUrl,
    this.details,
  });

  Data.fromJson(Map<String, dynamic> json) {
    currencyName = json['currency_name'];
    cotation = json['cotation'];
    symbol = json['symbol'];
    imageUrl = json['image_url'];
    details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currency_name'] = currencyName;
    data['cotation'] = cotation;
    data['symbol'] = symbol;
    data['image_url'] = imageUrl;
    if (details != null) {
      data['details'] = details!.toJson();
    }
    return data;
  }
}

class Details {
  String? about;
  double? fee;

  Details({this.about, this.fee});

  Details.fromJson(Map<String, dynamic> json) {
    about = json['about'];
    fee = json['fee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['about'] = about;
    data['fee'] = fee;
    return data;
  }
}
