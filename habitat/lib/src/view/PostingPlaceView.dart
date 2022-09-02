import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:habitat/src/utils/utils.dart';
import 'package:habitat/src/widgets/ImageButton.dart';

import '../widgets/ButtonElipse.dart';

class PostingPlaceView extends StatelessWidget {
  const PostingPlaceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Util.azulClaroFundo,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
                child: Text(
                  "Postar em:",
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ImageButton(
                "assets/university1.png",
                () => {Navigator.of(context).pushReplacementNamed("/postingList")},
                "Faculdade",
                cor: Util.azulEscuroBotao,
                corFonte: Util.fundoClaro,
              ),
            ),
          ),
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ImageButton(
                "assets/architecture-and-city1.png",
                () => {},
                "Cidade",
                cor: Util.azulEscuroBotao,
                corFonte: Util.fundoClaro,
              ),
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     ButtonElipse(
          //       "Proximo",
          //       () {
          //         Navigator.of(context).pushNamed("/postingPlace");
          //       },
          //       width: 100,
          //       fontSize: 18,
          //       backgroundColor: const Color.fromARGB(255, 5, 54, 116),
          //       fontColor: const Color.fromARGB(255, 220, 221, 203),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
