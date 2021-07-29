import 'package:buffet_app/screens/catalog_screen/catalog_model.dart';
import 'package:buffet_app/screens/pay_screen/bloc/pay_bloc.dart';
import 'package:buffet_app/screens/pay_screen/bloc/pay_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Pay extends StatefulWidget {
  double sum;
  Pay({
    Key? key,
    required this.sum,
    this.card,
    this.index,
  }) : super(key: key);
  List<BuffetModels>? card;
  int? index;

  @override
  _PayState createState() => _PayState();
}

class _PayState extends State<Pay> {
  final bloc = PayBloc(PayRepository());
  //final _sumController = TextEditingController();
  TextEditingController _pinController = new TextEditingController();
  TextEditingController _sumController = new TextEditingController();
  String _pin = '';
  int _payController = 0;
  bool checkPincode = false;
  bool validator = false;
  bool enabled = false;
  List selectedProduct = [];
  int counter = 1;
  double sum = 0;
  double change = 0;
  double debt = 0;

  @override
  void initState() {
    super.initState();
    sum = widget.sum;
    widget.card!.map((e) => sum += e.price!);
  }

  void calculator() {
    setState(() {
      double pay = double.parse(_sumController.text);
      if (pay > sum) {
        change = pay - sum;
        debt = 0;
      } else if (pay < sum) {
        debt = sum - pay;
        change = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: MediaQuery.of(context).size.height * 0.7,
          width: 300,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Детали оплаты',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.close)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(width: 30),
                  Text(
                    'Наименование',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
                  ),
                  SizedBox(width: 35),
                  Text(
                    'Кол-во',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
                  ),
                  SizedBox(width: 45),
                  Text(
                    'Цена',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
                  ),
                ],
              ),
              Container(
                height: 250,
                width: 300,
                child: ListView.builder(
                  itemCount: widget.card!.length,
                  itemBuilder: (context, i) => Column(
                    children: [
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                widget.card![i].image!),
                                            fit: BoxFit.fill))),
                                SizedBox(width: 5),
                                Container(
                                    width: 100,
                                    child: Text(widget.card![i].name!)),
                                IconButton(
                                  onPressed: () {
                                    if (widget.card![i].quantity != 0) {
                                      setState(() {
                                        widget.card![i].quantity -= 1;
                                        sum -= widget.card![i].price!;
                                      });
                                    } else if (widget.card![i].quantity != 0) {
                                      setState(() {});
                                    }
                                  },
                                  icon: Icon(Icons.remove),
                                ),
                                //SizedBox(width: 3),
                                Text(widget.card![i].quantity.toString()),
                                //SizedBox(width: ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        widget.card![i].quantity += 1;
                                        sum += widget.card![i].price!;
                                        print(sum);
                                      });
                                    },
                                    icon: Icon(Icons.add)),
                                SizedBox(width: 5),
                                Text('${widget.card![i].price!}c')
                              ],
                            ),
                            Container(
                              child: Divider(
                                color: Colors.grey,
                                height: 0.1,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Divider(
                  color: Colors.grey,
                  height: 0.1,
                  thickness: 1,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //SizedBox(width: 10),
                  Text('Итого', style: TextStyle(fontWeight: FontWeight.bold)),
                  // SizedBox(width: 200),
                  Text(sum.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
              SizedBox(height: 10),
              BlocListener<PayBloc, PayState>(
                bloc: bloc,
                listener: (context, state) {
                  if (state is PayLoaded) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text("Платеж успешно завершен")
                          ],
                        ),
                                            duration: Duration(seconds: 5),
                      backgroundColor: Colors.greenAccent,
                      shape: StadiumBorder(),
                      elevation: 0,
                    
                      ),
                    );
                  } else if (state is PayError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text("Пользователь не найден"),
                        ],
                      ),
                      duration: Duration(seconds: 5),
                      backgroundColor: Colors.redAccent[400],
                      shape: StadiumBorder(),
                      elevation: 0,
                    ));
                  }
                },
                child: BlocBuilder<PayBloc, PayState>(
                    bloc: bloc,
                    builder: (context, state) {
                      if (state is PayInitial) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Оплата',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Пин-код'),
                                Form(
                                  child: Container(
                                    height: 30,
                                    width: 135,
                                    child: TextFormField(
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(6)
                                      ],
                                      onFieldSubmitted: (_pinController) {
                                        if (_pinController.length == 6) {
                                          _pin = _pinController;
                                          setState(() {
                                            checkPincode = true;
                                          });
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      controller: _pinController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Введите пин-код',
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 0.5),
                                          //borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Сумма оплаты'),
                                Container(
                                  height: 30,
                                  width: 135,
                                  child: TextField(
                                    onSubmitted: (_sumController) {
                                      if (_sumController.length != 0) {
                                        setState(() {
                                          validator = true;
                                          if (validator &&
                                              checkPincode == true) {
                                            enabled = !enabled;
                                            calculator();
                                            _payController =
                                                int.parse(_sumController);
                                          }
                                        });
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    controller: _sumController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Введите сумму',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0.5),
                                        // borderRadius: BorderRadius.circular(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Долг'),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5)),
                                  width: 135,
                                  height: 30,
                                  child: Text(debt.toString()),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Сдача'),
                                    Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      width: 135,
                                      height: 30,
                                      child: Text(change.toString()),
                                    ),
                                  ],
                                ),
                                Column(children: [
                                  SizedBox(height: 15),
                                  SizedBox(
                                    height: 30,
                                    width: 135,
                                    child: TextButton(
                                        style: ButtonStyle(
                                          backgroundColor: enabled
                                              ? MaterialStateProperty.all<
                                                  Color>(Colors.black)
                                              : MaterialStateProperty.all<
                                                  Color>(Colors.grey),
                                        ),
                                        child: Text(
                                          'Оплатить',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          if (!enabled) {
                                            return null;
                                          } else {
                                            bloc.add(PostPayEvent(_pin,
                                                _payController, widget.card));
                                          }
                                        }),
                                  ),
                                ]),
                              ],
                            ),
                          ],
                        );
                      } 
                      else if (state is PayError) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Оплата',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Пин-код'),
                                Form(
                                  child: Container(
                                    height: 30,
                                    width: 135,
                                    child: TextFormField(
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(6)
                                      ],
                                      onFieldSubmitted: (_pinController) {
                                        if (_pinController.length == 6) {
                                          _pin = _pinController;
                                          setState(() {
                                            checkPincode = true;
                                          });
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      controller: _pinController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Введите пин-код',
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 0.5),
                                          //borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Сумма оплаты'),
                                Container(
                                  height: 30,
                                  width: 135,
                                  child: TextField(
                                    onSubmitted: (_sumController) {
                                      if (_sumController.length != 0) {
                                        setState(() {
                                          validator = true;
                                          if (validator &&
                                              checkPincode == true) {
                                            enabled = !enabled;
                                            calculator();
                                            _payController =
                                                int.parse(_sumController);
                                          }
                                        });
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    controller: _sumController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Введите сумму',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0.5),
                                        // borderRadius: BorderRadius.circular(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Долг'),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5)),
                                  width: 135,
                                  height: 30,
                                  child: Text(debt.toString()),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Сдача'),
                                    Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      width: 135,
                                      height: 30,
                                      child: Text(change.toString()),
                                    ),
                                  ],
                                ),
                                Column(children: [
                                  SizedBox(height: 15),
                                  SizedBox(
                                    height: 30,
                                    width: 135,
                                    child: TextButton(
                                        style: ButtonStyle(
                                          backgroundColor: enabled
                                              ? MaterialStateProperty.all<
                                                  Color>(Colors.black)
                                              : MaterialStateProperty.all<
                                                  Color>(Colors.grey),
                                        ),
                                        child: Text(
                                          'Оплатить',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          if (!enabled) {
                                            return null;
                                          } else {
                                            bloc.add(PostPayEvent(_pin,
                                                _payController, widget.card));
                                          }
                                        }),
                                  ),
                                ]),
                              ],
                            ),
                          ],
                        );
                      }
                      return Text('1234');
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

