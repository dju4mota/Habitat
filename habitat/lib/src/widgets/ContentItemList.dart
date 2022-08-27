import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:habitat/src/models/Content.dart';

class ContentItemList extends StatelessWidget {
  Content content;
  Function openContent;
  Function deleteContent;
  ContentItemList(this.content, this.openContent, this.deleteContent);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 220, 221, 203),
          border: Border.all(
            width: 2,
            color: Color.fromARGB(255, 5, 54, 116),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 5, 5, 5),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: Text(content.title,
                            style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 5, 54, 116)))),
                  ),
                  IconButton(
                      onPressed: () {
                        openContent(content);
                      },
                      icon: Icon(Icons.arrow_forward))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 5, 5, 20.0),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.62,
                        child: Text(
                          content.description,
                          style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 5, 54, 116)),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            deleteContent(content);
                          },
                          icon: Icon(Icons.delete))
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
