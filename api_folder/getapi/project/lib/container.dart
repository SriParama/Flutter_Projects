import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class bidContainerWidget extends StatefulWidget {
  int index;
  final Function(int) removeContainer;
  final Function calculateHighestTotal;

  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController totalController = TextEditingController();

  bidContainerWidget({
    required this.index,
    required this.removeContainer,
    required this.calculateHighestTotal,
  });

  @override
  State<bidContainerWidget> createState() => _bidContainerWidgetState();
  void updateIndex(int newIndex) {
    index = newIndex;
  }

  void clearControllers() {
    quantityController.clear();
    priceController.clear();
    totalController.clear();
  }
}

class _bidContainerWidgetState extends State<bidContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.27,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey, width: 1.0)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Bid (${widget.index + 1}/3)',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          widget.removeContainer(widget.index);
                        },
                        icon: Icon(Icons.cancel))
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Quantity'),
                        SizedBox(
                          height: 8.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.20,
                          height: 50.0,
                          child: TextFormField(
                            key: Key('quantity_${widget.index}'),
                            // autofocus: true,
                            controller: widget.quantityController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]'))
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '*Required';
                              }
                              return null;
                            },

                            onChanged: (value) {
                              calculateTotal(value);
                            },

                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.green.shade900)),
                                counterText: '',
                                hintText: 'Quantity',
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                hintStyle: TextStyle(fontSize: 13.0),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text('Lot: $lot'),
                        SizedBox(
                          height: 8.0,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: checkbox,
                              onChanged: checkBoxFun,
                            ),
                            Text(
                              'total:${widget.totalController.text}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price'),
                        SizedBox(
                          height: 8.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.20,
                          height: 50.0,
                          child: TextFormField(
                            key: Key('price_${widget.index}'),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]'))
                            ],

                            controller: widget.priceController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '*Required';
                              } else if (maxprice < int.parse(value) ||
                                  minprice > int.parse(value)) {
                                return 'Amount Incorrect';
                              }
                              return null;
                            },

                            onChanged: (value) {
                              calculateTotal(value);
                            },

                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.green.shade900)),
                                counterText: '',
                                hintText: 'Price',
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                hintStyle: TextStyle(fontSize: 13.0),
                                border: OutlineInputBorder()),
                            // onChanged: _validateInput,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text('Price: \u20B9 - \u20B9'),
                        SizedBox(
                          height: 8.0,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }

  int lot = 100;
  int minprice = 12;
  int maxprice = 13;
  bool checkbox = false;
  void checkBoxFun(value) {
    checkbox = !checkbox;
    if (checkbox == true) {
      setState(() {
        widget.priceController.text = maxprice.toString();
      });
    } else {
      setState(() {
        widget.priceController.text = '';
      });
    }
    calculateTotal(widget.priceController.text);

    print(checkbox);
  }

  void calculateTotal(String value) {
    setState(() {
      if (widget.quantityController.text.isNotEmpty &&
          widget.priceController.text.isNotEmpty) {
        double quantity =
            double.tryParse(widget.quantityController.text) ?? 0.0;
        double price = double.tryParse(widget.priceController.text) ?? 0.0;
        double total = quantity * price * lot;
        widget.totalController.text = total.toStringAsFixed(2);
        widget.calculateHighestTotal();
      } else {
        widget.totalController.text = '0.00';
      }
    });
  }

  void resetCheckbox() {
    setState(() {
      checkbox = false; // Reset the checkbox to false
    });
  }
}
