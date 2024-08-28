class CoinModel {
  String? id;
  String? symbol;
  String? name;
  String? image;
  double? currentPrice;
  int? marketCap;
  int? marketCapRank;
  int? fullyDilutedValuation;
  int? totalVolume;
  double? high24H;
  double? low24H;
  double? priceChange24H;
  double? priceChangePercentage24H;
  double? marketCapChange24H;
  double? marketCapChangePercentage24H;
  double? circulatingSupply;
  double? totalSupply;
  double? maxSupply;
  double? ath;
  double? athChangePercentage;
  DateTime? athDate;
  double? atl;
  double? atlChangePercentage;
  DateTime? atlDate;
  DateTime? lastUpdated;

  CoinModel({
    this.id,
    this.symbol,
    this.name,
    this.image,
    this.currentPrice,
    this.marketCap,
    this.marketCapRank,
    this.fullyDilutedValuation,
    this.totalVolume,
    this.high24H,
    this.low24H,
    this.priceChange24H,
    this.priceChangePercentage24H,
    this.marketCapChange24H,
    this.marketCapChangePercentage24H,
    this.circulatingSupply,
    this.totalSupply,
    this.maxSupply,
    this.ath,
    this.athChangePercentage,
    this.athDate,
    this.atl,
    this.atlChangePercentage,
    this.atlDate,
    this.lastUpdated,
  });

  factory CoinModel.fromMap(Map<String, dynamic> json) => CoinModel(
    id: json["id"] ?? '',
    symbol: json["symbol"] ?? '',
    name: json["name"] ?? '',
    image: json["image"] ?? '',
    currentPrice: json["current_price"]?.toDouble() ?? 0.0,
    marketCap: json["market_cap"] ?? 0,
    marketCapRank: json["market_cap_rank"] ?? 0,
    fullyDilutedValuation: json["fully_diluted_valuation"] ?? 0,
    totalVolume: json["total_volume"] ?? 0,
    high24H: json["high_24h"]?.toDouble() ?? 0.0,
    low24H: json["low_24h"]?.toDouble() ?? 0.0,
    priceChange24H: json["price_change_24h"]?.toDouble() ?? 0.0,
    priceChangePercentage24H: json["price_change_percentage_24h"]?.toDouble() ?? 0.0,
    marketCapChange24H: json["market_cap_change_24h"]?.toDouble() ?? 0.0,
    marketCapChangePercentage24H: json["market_cap_change_percentage_24h"]?.toDouble() ?? 0.0,
    circulatingSupply: json["circulating_supply"]?.toDouble() ?? 0.0,
    totalSupply: json["total_supply"]?.toDouble() ?? 0.0,
    maxSupply: json["max_supply"]?.toDouble() ?? 0.0,
    ath: json["ath"]?.toDouble() ?? 0.0,
    athChangePercentage: json["ath_change_percentage"]?.toDouble() ?? 0.0,
    athDate: json["ath_date"] != null ? DateTime.parse(json["ath_date"]) : DateTime.now(),
    atl: json["atl"]?.toDouble() ?? 0.0,
    atlChangePercentage: json["atl_change_percentage"]?.toDouble() ?? 0.0,
    atlDate: json["atl_date"] != null ? DateTime.parse(json["atl_date"]) : DateTime.now(),
    lastUpdated: json["last_updated"] != null ? DateTime.parse(json["last_updated"]) : DateTime.now(),
  );

  Map<String, dynamic> toMap() => {
    "id": id ?? '',
    "symbol": symbol ?? '',
    "name": name ?? '',
    "image": image ?? '',
    "current_price": currentPrice ?? 0.0,
    "market_cap": marketCap ?? 0,
    "market_cap_rank": marketCapRank ?? 0,
    "fully_diluted_valuation": fullyDilutedValuation ?? 0,
    "total_volume": totalVolume ?? 0,
    "high_24h": high24H ?? 0.0,
    "low_24h": low24H ?? 0.0,
    "price_change_24h": priceChange24H ?? 0.0,
    "price_change_percentage_24h": priceChangePercentage24H ?? 0.0,
    "market_cap_change_24h": marketCapChange24H ?? 0.0,
    "market_cap_change_percentage_24h": marketCapChangePercentage24H ?? 0.0,
    "circulating_supply": circulatingSupply ?? 0.0,
    "total_supply": totalSupply ?? 0.0,
    "max_supply": maxSupply ?? 0.0,
    "ath": ath ?? 0.0,
    "ath_change_percentage": athChangePercentage ?? 0.0,
    "ath_date": athDate?.toIso8601String() ?? DateTime.now().toIso8601String(),
    "atl": atl ?? 0.0,
    "atl_change_percentage": atlChangePercentage ?? 0.0,
    "atl_date": atlDate?.toIso8601String() ?? DateTime.now().toIso8601String(),
    "last_updated": lastUpdated?.toIso8601String() ?? DateTime.now().toIso8601String(),
  };
}

