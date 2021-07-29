import 'package:buffet_app/screens/debt_screen/bloc/debt_bloc.dart';
import 'package:buffet_app/screens/debt_screen/bloc/debt_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Debt extends StatefulWidget {
  Debt({Key? key}) : super(key: key);

  // final GetDebtModel? model;
  @override
  _DebtState createState() => _DebtState();
}

class _DebtState extends State<Debt> {
  TextEditingController _pinController = new TextEditingController();
  TextEditingController _sumController = new TextEditingController();
  bool checkPincode = false;
  bool validator = false;
  bool enabled = false;
  double change = 0;
  double debt = 0;
  double sum = 0;
  dynamic index;

  final bloc = DebtBloc(GetDebtRepository());

  @override
  void initState() {
    super.initState();
    //bloc.add(GetDebtEvent());
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
        child: BlocBuilder<DebtBloc, DebtState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is GetDebtLoaded) {
                return Container(
                    height: 590,
                    width: 315,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    // padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Долги',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(Icons.close)),
                          ],
                        ),
                        Text("Введите пин-код для подробной информации",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w100)),
                        SizedBox(height: 10),
                        Text("Пин-код"),
                        SizedBox(height: 5),
                        //Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Container(
                          height: 30,
                          width: 135,
                          child: TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(6)
                            ],
                            onFieldSubmitted: (_pinController) {
                              if (_pinController.length == 6) {
                                setState(() {
                                  checkPincode = true;
                                  //bloc.add(GetDebtEvent(_pinController));
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
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 0.5),
                                //borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Наименование',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w100),
                            ),
                            SizedBox(width: 55),
                            Text(
                              'Дата',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w100),
                            ),
                            SizedBox(width: 70),
                            Text(
                              'Долг',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w100),
                            ),
                          ],
                        ),
                        Container(
                          height: 250,
                          width: 300,
                          child: ListView.builder(
                            itemCount: 1,
                            itemBuilder: (context, i) => Column(
                              children: [
                                Container(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: [
                                      SizedBox(width: 5),
                                      Container(width: 100, child: Text('Самсы с сыром')),
                                      SizedBox(width: 40),
                                      Container(width: 80, child: Text(state.model.addDate.toString())),
                                      SizedBox(width: 30),
                                      Text(state.model.debtSum.toString()),
                                    ],
                                  ),
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
                            Text('Итого',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            // SizedBox(width: 200),
                            Text(sum.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),

                        SizedBox(height: 10),
                        Text('Оплата',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                                        //borderRadius: BorderRadius.circular(10),
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
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5)),
                                    width: 135,
                                    height: 30,
                                    child: Text(change.toString()),
                                  ),
                                ]),
                            Column(
                              children: [
                                SizedBox(height: 15),
                                InkWell(
                                  onTap: () {


                                  },
                                  child: SizedBox(
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
                                            //bloc.add();
                                          }
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ));
              } else if (state is GetDebtError) {}
              return Text('Error');
            }),
      ),
    );
  }
}
