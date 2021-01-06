import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:gm_driver_lite/core/cubit/cubits.dart';

class ChooseEquipmentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF24242A),
      appBar: AppBar(
        title: const Text(
          'LOAD ROUTE',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ChooseEquipmentCubit, ChooseEquipmentState>(
        builder: (context, snapshot) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 48, right: 18, left: 18),
              child: Row(
                children: <Widget>[
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Equipment',
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(MaterialCommunityIcons.truck),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    AntDesign.qrcode,
                    color: Colors.white,
                    size: 26,
                  ),
                ],
              ),
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          MaterialCommunityIcons.map_search,
        ),
        backgroundColor: const Color(0xFFB0D25A),
      ),
    );
  }
}
