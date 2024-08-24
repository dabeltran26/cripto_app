import 'package:cripto_app/config/colors.dart';
import 'package:cripto_app/utils/responsive.dart';
import 'package:cripto_app/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:cripto_app/resources/models/coin_model.dart';
import 'package:intl/intl.dart';

class CoinCard extends StatelessWidget {
  final CoinModel coin;

  const CoinCard({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'en_US');
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      decoration: BoxDecoration(
        color: ColorsApp.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        height: 50,
                        child: Image.network(
                          coin.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            coin.symbol.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 0.5.h),
                          SizedBox(
                            width: 40.w,
                            child: Text(
                              coin.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 14,
                                color: ColorsApp.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formatCurrency.format(coin.currentPrice),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      '${coin.priceChangePercentage24H}%',
                      style: const TextStyle(
                        fontSize: 14,
                        color: ColorsApp.success,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 0.5.h),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Agregado a favoritos'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  addFavorite,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: ColorsApp.primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
