
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tip_calc/utility/colors.dart';

class tipCalculator extends StatefulWidget {
  @override
  _tipCalculatorState createState() => _tipCalculatorState();
}

class _tipCalculatorState extends State<tipCalculator> {
  double _billAmount = 0.0;
  int _tipPercentage = 0;
  int _personCounter = 1;
  Color _purple = HexColor("#6908D6");
  Color _deepPurple = HexColor("#6a1b9a");
  Color _lightPurple = HexColor("#e1bee7");

//  double _tip = 0.0; greska, ovo ne treba, ubacuje se kroz formulu
//  double _totalPerPerson = 0.0; isto kao iznad

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _deepPurple,
      body:
      Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: _deepPurple,
        child: ListView(
          //ovo radimo zbog rezolucije i razlicitih velicina ekrana
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(18.0),
          children: <Widget>[
            Container(
              height: 180,
              width: 300,
              decoration: BoxDecoration(
                  color: _lightPurple,
                  borderRadius: BorderRadius.circular(25.0)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Total Per Person",
                      style: TextStyle(fontSize: 18.0, color: _purple),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      //za razdaljinu izmedju dva teksta
                      child: Text(
                        "\$ ${calculateTotalPerPerson(_billAmount, _personCounter, _tipPercentage)}",
                        style: TextStyle(
                            fontSize: 30,
                            color: _purple,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: _lightPurple,
                  border: Border.all(
                      width: 1.0, color: Colors.grey, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(25.0)),
              child: Column(
                children: <Widget>[
                  TextField(
                    //za tastaturu
                    keyboardType:
                    TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: _purple),
                    decoration: InputDecoration(
                        prefixText: "Bill Amount",
                        prefixIcon: Icon(Icons.attach_money)),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (exception) {
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Split",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          InkWell(
                              onTap: () {
                                setState(() {
                                  if (_personCounter > 1) {
                                    _personCounter--;
                                  } else {}
                                });
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: _purple.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                                child: Icon(
                                  Icons.remove,
                                  color: _purple,
                                  size: 20.0,
                                ),
                              )),
                          Text(
                            "$_personCounter",
                            style: TextStyle(
                                color: _purple,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _personCounter++;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: _purple.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(7.0)),
                              child: Icon(
                                Icons.add,
                                size: 20.0,
                                color: _purple,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Tip",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "\$ ${(calculateTotalTip(_billAmount, _personCounter, _tipPercentage)).toStringAsFixed(2)}", //da bi ialo dve decimale
                          style: TextStyle(
                              color: _purple,
                              fontSize: 19.0,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "$_tipPercentage%",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: _purple),
                      ),
                      Slider(
                        value: _tipPercentage.toDouble(),
                        onChanged: (double newValue) {
                          setState(() {
                            _tipPercentage = newValue.round();
                          });
                        },
                        activeColor: _purple,
                        inactiveColor: Colors.grey.shade700,
                        min: 0,
                        max: 100,
                        divisions: 20,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  calculateTotalPerPerson(double billAmount, int splitBy, int tipPercentage) {
    var totalPerPerson =
        (calculateTotalTip(billAmount, splitBy, tipPercentage) + billAmount) /
            splitBy;

    return totalPerPerson.toStringAsFixed(2); //za dve decimale
  }

  calculateTotalTip(double billAmount, int splitBy, int tipPercentage) {
    double totalTip = 0.0;

    if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null) {
    } else {
      totalTip = (billAmount * tipPercentage) / 100;
    }

    return totalTip;
  }
}

class Baksis extends StatefulWidget {
  @override
  _BaksisState createState() => _BaksisState();
}

class _BaksisState extends State<Baksis> {
  double _billAmount = 0.0;
  int _peopleCounter = 0;
  int _tipPer = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        child: ListView(
          padding: EdgeInsets.all(18.0),
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              height: 160,
              width: 250,
              padding: EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(25.0)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Svako placa po",
                      style: TextStyle(
                          color: Colors.deepOrange.shade600,
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "${calculateTotalPerPerson(_billAmount, _peopleCounter, _tipPer)} RSD",
                        style: TextStyle(
                            color: Colors.deepOrange.shade600,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 20.0),
                //za odvajanje
                padding: EdgeInsets.all(18.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                        width: 1.0),
                    borderRadius: BorderRadius.circular(25.0)),
                child: Column(
                  children: <Widget>[
                    TextField(
                      keyboardType:
                      TextInputType.numberWithOptions(decimal: false),
                      decoration: InputDecoration(
                        prefixText: "Racun ",
                      ),
                      style: TextStyle(color: Colors.purple),
                      onChanged: (String value) {
                        try {
                          _billAmount = double.parse(value);
                        } catch (exception) {
                          _billAmount = 0.0;
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Broj osoba",
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.grey.shade700),
                        ),
                        Row(
                          children: <Widget>[
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    if (_peopleCounter > 1) {
                                      _peopleCounter--;
                                    } else {}
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  margin: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.purple.shade100),
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                )),
                            Text(
                              "$_peopleCounter",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _peopleCounter++;
                                });
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.purple.shade100),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.black,
                                  size: 18.0,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Baksis",
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.grey.shade700),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            "RSD ${(calculateTotalTip(_billAmount, _peopleCounter, _tipPer)).toStringAsFixed(0)}",
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "$_tipPer%",
                          style: TextStyle(
                              color: Colors.deepOrange, fontSize: 16.0),
                        ),
                        Slider(
                          value: (_tipPer.toDouble()),
                          onChanged: (double newValue) {
                            setState(() {
                              _tipPer = newValue.round();
                            });
                          },
                          min: 0,
                          max: 100,
                          divisions: 10,
                          activeColor: Colors.purple.shade200,
                        )
                      ],
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  calculateTotalPerPerson(double billAmount, int splitBy, int tipPer) {
    var totalPerPerson =
        (calculateTotalTip(billAmount, splitBy, tipPer) + billAmount) / splitBy;

    return totalPerPerson.toStringAsFixed(0);
  }

  calculateTotalTip(double billAmount, int splitBy, int tipPer) {
    double totalTip = 0.0;

    if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null) {
      //no go

    } else {
      totalTip = (billAmount * tipPer) / 100;
    }

    return totalTip;
  }
}

class tipCalc extends StatefulWidget {
  @override
  _tipCalcState createState() => _tipCalcState();
}

class _tipCalcState extends State<tipCalc> {
  double _billAmount = 0.0;
  int _peopleCounter = 0;
  int _tipPerc = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.white,
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
          child: ListView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(18.0),
              children: <Widget>[
                Container(
                  height: 150,
                  width: 300,
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(25.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Total Per Person",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text("\$ ${calculateTotalPerPerson(_billAmount, _tipPerc, _peopleCounter)}",
                            style: TextStyle(color: Colors.black, fontSize: 28.0)),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(16.0),
                  padding: EdgeInsets.all(18.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey, width: 1.0, style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(25.0)),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        keyboardType:
                        TextInputType.numberWithOptions(decimal: false),
                        decoration: InputDecoration(
                          prefixText: "\$ Bill Amount",
                        ),
                        style: TextStyle(color: Colors.deepOrange),
                        onChanged: (String value){
                          try{
                            _billAmount = double.parse(value);
                          }
                          catch(exception) {
                            _billAmount = 0.0;
                          }

                        },
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Split"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (_peopleCounter > 1) {
                                      _peopleCounter--;
                                    } else {}
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  margin: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: Colors.deepOrange,
                                      borderRadius: BorderRadius.circular(12.0)),
                                  child: Icon(Icons.remove),
                                ),
                              ),
                              Text(
                                "$_peopleCounter",
                                style: TextStyle(
                                    color: Colors.deepOrange, fontSize: 20.0),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _peopleCounter++;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  margin: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: Colors.deepOrange,
                                      borderRadius: BorderRadius.circular(12.0)),
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Tip",
                          ),
                          Text(
                            "${(calculateTotalTip(_billAmount, _tipPerc, _peopleCounter)).toStringAsFixed(2)} \$ ",
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        "$_tipPerc%",
                        style: TextStyle(color: Colors.deepOrange, fontSize: 20.0),
                      ),
                      Slider(
                        value: _tipPerc.toDouble(),
                        onChanged: (double newValue) {
                          setState(() {
                            _tipPerc = newValue.round();
                          });
                        },
                        min: 0,
                        max: 100,
                        divisions: 10,
                        activeColor: Colors.deepOrange,
                      )
                    ],
                  ),
                )
              ]),
        ));
  }

  calculateTotalTip(double billAmount, int tipPerc, int splitBy) {
    double totalTip = 0.0;
    if(billAmount < 0 || billAmount.toString().isEmpty || billAmount == null){

    }else {
      totalTip = (billAmount * tipPerc) / 100;
    }
    return totalTip;

  }
  calculateTotalPerPerson(double billAmount, int tipPerc, int splitBy) {
    var totalPerPerson = (calculateTotalTip(billAmount, tipPerc, splitBy) + billAmount) / splitBy;
    return totalPerPerson.toStringAsFixed(2);
  }
}
