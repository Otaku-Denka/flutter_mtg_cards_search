class ScryfallSearchModel {
  String object;
  int totalCards;
  String keyword;
  bool hasMore;
  String nextPage;
  List<ScryfallSearchData> data;

  ScryfallSearchModel(
      {this.object,
      this.totalCards,
      this.keyword,
      this.hasMore,
      this.nextPage,
      this.data});

  ScryfallSearchModel.fromJson(Map<String, dynamic> json) {
    object = json['object'];
    totalCards = json['total_cards'];
    keyword = json['keyword'];
    hasMore = json['has_more'];
    nextPage = json['next_page'];
    if (json['data'] != null) {
      data = new List<ScryfallSearchData>();
      json['data'].forEach((v) {
        data.add(new ScryfallSearchData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['object'] = this.object;
    data['total_cards'] = this.totalCards;
    data['keyword'] = this.keyword;
    data['has_more'] = this.hasMore;
    data['next_page'] = this.nextPage;
    if (this.data != null) {
      data['ScryfallSearchData'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ScryfallSearchData {
  String name;
  String printedName;
  String uri;
  String scryfallUri;
  String lang;
  ImageUris imageUris;
  List<CardFaces> cardFaces;
  Prices prices;

  ScryfallSearchData(
      {this.name,
      this.uri,
      this.scryfallUri,
      this.lang,
      this.imageUris,
      this.cardFaces,
      this.printedName,
      this.prices});

  ScryfallSearchData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uri = json['uri'];
    scryfallUri = json['scryfall_uri'];
    printedName = json['printed_name'];
    lang = json['lang'];
    imageUris = json['image_uris'] != null
        ? new ImageUris.fromJson(json['image_uris'])
        : null;
    if (json['card_faces'] != null) {
      cardFaces = new List<CardFaces>();
      json['card_faces'].forEach((v) {
        cardFaces.add(new CardFaces.fromJson(v));
      });
    }
    prices =
        json['prices'] != null ? new Prices.fromJson(json['prices']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['uri'] = this.uri;
    data['scryfall_uri'] = this.scryfallUri;
    data['lang'] = this.lang;
    if (this.imageUris != null) {
      data['image_uris'] = this.imageUris.toJson();
    }
    if (this.cardFaces != null) {
      data['card_faces'] = this.cardFaces.map((v) => v.toJson()).toList();
    }
    if (this.prices != null) {
      data['prices'] = this.prices.toJson();
    }
    return data;
  }
}

class ImageUris {
  String small;
  String normal;
  String large;
  String png;
  String artCrop;
  String borderCrop;

  ImageUris(
      {this.small,
      this.normal,
      this.large,
      this.png,
      this.artCrop,
      this.borderCrop});

  ImageUris.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    normal = json['normal'];
    large = json['large'];
    png = json['png'];
    artCrop = json['art_crop'];
    borderCrop = json['border_crop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['small'] = this.small;
    data['normal'] = this.normal;
    data['large'] = this.large;
    data['png'] = this.png;
    data['art_crop'] = this.artCrop;
    data['border_crop'] = this.borderCrop;
    return data;
  }
}

class CardFaces {
  String name;
  String oracleText;
  ImageUris imageUris;

  CardFaces({this.name, this.oracleText, this.imageUris});

  CardFaces.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    oracleText = json['oracle_text'];
    imageUris = json['image_uris'] != null
        ? new ImageUris.fromJson(json['image_uris'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['oracle_text'] = this.oracleText;
    if (this.imageUris != null) {
      data['image_uris'] = this.imageUris.toJson();
    }
    return data;
  }
}

class Prices {
  String usd;
  String usdFoil;
  String eur;
  String tix;

  Prices({this.usd, this.usdFoil, this.eur, this.tix});

  Prices.fromJson(Map<String, dynamic> json) {
    usd = json['usd'];
    usdFoil = json['usd_foil'];
    eur = json['eur'];
    tix = json['tix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usd'] = this.usd;
    data['usd_foil'] = this.usdFoil;
    data['eur'] = this.eur;
    data['tix'] = this.tix;
    return data;
  }
}
