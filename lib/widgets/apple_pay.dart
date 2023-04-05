import 'package:contoso_ecom/models/models.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class ApplePay extends StatelessWidget {
  const ApplePay({
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
        label: "Total",
        amount: total,
        type: PaymentItemType.total,
        status: PaymentItemStatus.final_price,
      ),
    );

    void onApplePayResult(paymentResult) {
      debugPrint(paymentResult.toString());
    }

    final Future<PaymentConfiguration> _applePayConfigFuture =
        PaymentConfiguration.fromAsset('payment_profile_apple_pay.json');

    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: FutureBuilder(
          future: _applePayConfigFuture,
          builder: (context, snapshot) => snapshot.hasData
              ? ApplePayButton(
                  paymentConfiguration: snapshot.data!,
                  onPaymentResult: onApplePayResult,
                  paymentItems: _paymentItems,
                  style: ApplePayButtonStyle.white,
                  type: ApplePayButtonType.inStore,
                  margin: const EdgeInsets.only(top: 10),
                  loadingIndicator: const CircularProgressIndicator(),
                )
              : const SizedBox.shrink()),
    );
  }
}
