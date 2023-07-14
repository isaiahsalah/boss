// ignore_for_file: file_names

import 'package:boss/models/BoxesModel.dart';
import 'package:boss/widgets/charts/ResumeWidget.dart';
import 'package:flutter/material.dart';

class ResumeBoxesChart extends StatelessWidget {
  const ResumeBoxesChart({super.key});

  @override
  Widget build(BuildContext context) {
    List<Branch> listBranch = <Branch>[
      Branch(
        title: "Suc 1",
        description: "description",
        boxes: <Box>[
          Box(
            branch: "Suc 1",
            title: "Caja 1",
            description: "Caja de atención a adultos mayores",
            value: 422,
          ),
          Box(
            branch: "Suc 1",
            title: "Caja 2",
            description: "Caja de atención común",
            value: 1530,
          ),
          Box(
            branch: "Suc 1",
            title: "Caja 3",
            description: "Caja de atención común",
            value: 953,
          ),
        ],
      ),
      Branch(
        title: "Suc 2",
        description: "Suc 2",
        boxes: <Box>[
          Box(
            branch: "Suc 2",
            title: "Caja 1",
            description: "Caja de atención preferencial",
            value: 1506,
          ),
          Box(
            branch: "Suc 2",
            title: "Caja 2",
            description: "Caja de atención común",
            value: 2596,
          ),
          Box(
            branch: "Suc 2",
            title: "Caja 3",
            description: "Caja de atención común",
            value: 2018,
          ),
          Box(
            branch: "Suc 2",
            title: "Caja 4",
            description: "Caja de atención común",
            value: 1845,
          ),
        ],
      ),
      Branch(
        title: "Suc 3",
        description: "Suc 3",
        boxes: <Box>[
          Box(
            branch: "Suc 3",
            title: "Caja 1",
            description: "Caja de atención común",
            value: 4508,
          )
        ],
      ),
    ];

    List<Box> totalBoxes = [];

    for (Branch branch in listBranch) {
      totalBoxes.addAll(branch.boxes);
    }

    listBranch.add(
        Branch(title: "Total", description: "description", boxes: totalBoxes));

    return ResumeWidget(
      title: "Resumen de cajas",
      description: "Información sobre el cierre de cajas",
      boxesData: BoxesModel(
        company: "company",
        description: "description",
        branches: listBranch,
      ),
    );
  }
}
