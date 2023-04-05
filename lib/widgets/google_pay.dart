import 'package:contoso_ecom/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class GooglePay extends StatelessWidget {
  const GooglePay({
    Key? key,
    required this.total,
    required this.products,
  }) : super(key: key);

  final String total;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    var _paymentItems = products
        .map(
          (product) => PaymentItem(
              label: product.name,
              amount: product.price.toString(),
              type: PaymentItemType.item,
              status: PaymentItemStatus.final_price),
        )
        .toList();

    _paymentItems.add(
      PaymentItem(
          label: 'Total',
          amount: total,
          type: PaymentItemType.item,
          status: PaymentItemStatus.final_price),
    );

    void onGooglePayResult(paymentResult) {
      debugPrint(paymentResult.toString());
    }

    Future<PaymentConfiguration> _googlePayConfigFuture =
        PaymentConfiguration.fromAsset('payment_profile_google_pay.json');

    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: FutureBuilder(
          future: _googlePayConfigFuture,
          builder: (context, snapshot) => snapshot.hasData
              ? GooglePayButton(
                  paymentConfiguration: snapshot.data!,
                  onPaymentResult: onGooglePayResult,
                  paymentItems: _paymentItems,
                  type: GooglePayButtonType.pay,
                  margin: const EdgeInsets.only(top: 10),
                )
              : const SizedBox.shrink()),
    );
  }
}
