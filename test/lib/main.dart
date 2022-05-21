import 'package:flutter/material.dart';

import 'package:share_plus/share_plus.dart';

void main() {
  runApp(MaterialApp(
    home: const CalcDamage(),
    initialRoute: '/inicio',
    routes: {
      '/inicio': (context) => const CalcDamage(),
      '/resultado': (context) => TotalDamage()
    },
  ));
}

class Parametros {
  String function = '';
  int danoMagico = 0, danoVerdadeiro = 0, danoFisico = 0;
  int danoTotal = 0;
  String result = '';
  Parametros(this.function, this.danoMagico, this.danoVerdadeiro,
      this.danoFisico, this.danoTotal, this.result);
}

class CalcDamage extends StatefulWidget {
  const CalcDamage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return EstadoDamage();
  }
}

class EstadoDamage extends State<CalcDamage> {
  String function = '';
  int danoMagico = 0, danoVerdadeiro = 0, danoFisico = 0;
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cálculo de Dano'),
      ),
      body: Form(
        key: _form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(hintText: 'Função do Campeão'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por Favor digite a função';
                } else {
                  function = value;
                  return null;
                }
              },
            ),
            TextFormField(
              decoration:
                  const InputDecoration(hintText: 'Dano Mágico Causado'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por Favor o dano causado';
                } else {
                  danoMagico = int.parse(value);
                  return null;
                }
              },
            ),
            TextFormField(
              decoration:
                  const InputDecoration(hintText: 'Dano Verdadeiro Causado'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por Favor digite o dano causado';
                } else {
                  danoVerdadeiro = int.parse(value);
                  return null;
                }
              },
            ),
            TextFormField(
              decoration:
                  const InputDecoration(hintText: 'Dano Físico Causado'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por Favor digite a função';
                } else {
                  danoFisico = int.parse(value);
                  return null;
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_form.currentState!.validate()) {
            setState(() {
              int danoTotal = danoFisico + danoMagico + danoVerdadeiro;
              String result = '';
              if (danoTotal >= 1000 && danoTotal < 1500) {
                result = 'Burst no adc';
              } else if (danoTotal >= 1500 && danoTotal < 2000) {
                result = 'Burst no ADC e Burst no Mago';
              } else if (danoTotal >= 2000 && danoTotal < 2500) {
                result = 'Burst no ADC, Burst no Mago e Burst no Suporte';
              } else if (danoTotal >= 2500 && danoTotal < 3000) {
                result =
                    'Burst no ADC, Burst no Mago, Burst no Suporte e Burst no Jungle';
              } else if (danoTotal >= 3000) {
                result =
                    'Burst no ADC, Burst no Mago, Burst no Suporte, Burst no Jungle e Burst no Top';
              } else {
                result = 'Nenhum Burst aplicado';
              }

              Navigator.pushNamed(context, '/resultado',
                  arguments: Parametros(function, danoMagico, danoVerdadeiro,
                      danoFisico, danoTotal, result));
            });
          }
        },
        child: const Text('Calcular'),
      ),
    );
  }
}

class TotalDamage extends StatefulWidget {
  const TotalDamage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EstadoTotalDamage();
  }
}

class EstadoTotalDamage extends State<TotalDamage> {
  String resultado = '';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Parametros;
    resultado =
        '${args.function} causou um ${args.result} com um dano total de ${args.danoTotal}';
    final box = context.findRenderObject() as RenderBox?;
    return Scaffold(
      appBar: AppBar(title: const Text('Resultado')),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              resultado,
              style: const TextStyle(fontSize: 32),
            )
          ]),
    );
  }
}
