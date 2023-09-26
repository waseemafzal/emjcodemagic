import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/controller/invoice_payment_controller.dart';
import 'package:emjay_global/view/components/card_type.dart';
import 'package:emjay_global/view/components/card_utilis.dart';
import 'package:emjay_global/view/components/input_formatters.dart';
import 'package:emjay_global/view/widgets/my_custom_button.dart';
import 'package:emjay_global/view/widgets/my_custom_text_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class InvoicePaymentScreen extends StatefulWidget {
  final String invoiceId;
  final String amount;
  const InvoicePaymentScreen(
      {super.key, required this.invoiceId, required this.amount});

  @override
  State<InvoicePaymentScreen> createState() => _InvoicePaymentScreenState();
}

class _InvoicePaymentScreenState extends State<InvoicePaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController cardController = TextEditingController();
  TextEditingController expMonthController = TextEditingController();
  TextEditingController expYearController = TextEditingController();
  TextEditingController cvcNoController = TextEditingController();
  TextEditingController invoiceIdController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  InvoicePaymentController invoicePaymentController =
      Get.put(InvoicePaymentController());

  CardType cardType = CardType.Invalid;

  void getCardTypeFromNumber() {
    if (cardController.text.length <= 6) {
      String cardNum = CardUtils.getCleanedNumber(cardController.text);
      CardType type = CardUtils.getCardTypeFrmNumber(cardNum);
      if (type != cardType) {
        setState(() {
          cardType = type;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    cardController.addListener(() {
      getCardTypeFromNumber();
    });
    super.initState();
    invoiceIdController.text = widget.invoiceId;
    amountController.text = widget.amount;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.invoiceId);
    print(widget.amount);
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice Payment"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter card number";
                    } else {
                      return null;
                    }
                  },
                  controller: cardController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                    CardNumberInputFormatter(),
                  ],
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: "Card Number",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: CardUtils.getCardIcon(cardType),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SvgPicture.asset(
                          "lib/view/assets/images/icons/card.svg"),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: TextFormField(
                  controller: cvcNoController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter cvv";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: "CVV",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SvgPicture.asset(
                          "lib/view/assets/images/icons/Cvv.svg"),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: TextFormField(
                  controller: expMonthController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter expiry month";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: "MM",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SvgPicture.asset(
                          "lib/view/assets/images/icons/calender.svg"),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: TextFormField(
                  controller: expYearController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter expiry Year";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: "YY",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SvgPicture.asset(
                          "lib/view/assets/images/icons/calender.svg"),
                    ),
                  ),
                ),
              ),
              MyCustomTextBox(
                validate: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Invoice Number";
                  } else {
                    return null;
                  }
                },
                readOnly: true,
                myController: invoiceIdController,
                myHint: "Invoice ID",
              ),
              MyCustomTextBox(
                validate: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Amount";
                  } else {
                    return null;
                  }
                },
                readOnly: true,
                myController: amountController,
                myHint: "Amount",
              ),
              Obx(() {
                return invoicePaymentController.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : MyCustomButton(
                        title: "PAY NOW",
                        onClick: () {
                          if (_formKey.currentState!.validate()) {
                            invoicePaymentController.invoicePayment(
                              cardNo: cardController.text.trim(),
                              expMonth: expMonthController.text.trim(),
                              expYear: expYearController.text.trim(),
                              cvcNo: cvcNoController.text.trim(),
                              invoiceId: invoiceIdController.text.trim(),
                              amount: amountController.text.trim(),
                            );
                          } else {
                            organoSnackBar(message: "Some Fields are Empty");
                          }
                        },
                      );
              })
            ],
          ),
        ),
      ),
    );
  }
}
