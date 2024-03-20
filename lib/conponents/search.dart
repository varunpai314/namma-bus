import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      width: 0.8 * MediaQuery.of(context).size.width,
      height: 50.0,
      alignment: Alignment.topLeft,
      decoration: const BoxDecoration(
        color: Color(0xffFFF7E8),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
            spreadRadius: 0.0,
            offset: Offset(2.0, 2.0),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xffFF8700),
          ),
          hintText: 'Search',
          border: InputBorder.none,
          hintStyle: const TextStyle(color: Color(0xffFF8700)),
          suffixIcon: Container(
            margin: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color(0xffFFEAD2),
            ),
            child: const Icon(
              Icons.filter_alt_rounded,
              color: Color(0xffFF8700),
            ),
          ),
        ),
      ),
    );
  }
}
