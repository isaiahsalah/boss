String encriptadorPass(String s) {
  int j, iAux, iSum;
  String sParcial, sres = '';
  for (int i = 1; i <= s.length; i++) {
    iSum = 0;
    if (i.isOdd)
      iAux = s.codeUnitAt(i - 1) + i;
    else
      iAux = s.codeUnitAt(i - 1) - i;

    sParcial = iAux.toString();
    if (iAux < 100) sParcial = '0' + sParcial;
    for (j = 1; j <= sParcial.length; j++) iSum += int.parse(sParcial[j - 1]);
    iSum %= 10;

    switch (i % 4) {
      case 1:
        sParcial = iSum.toString() + sParcial;
        break;
      case 2:
        sParcial =
            '${sParcial.substring(0, 1)}${iSum.toString()}${sParcial.substring(1)}';
        break;
      case 3:
        sParcial =
            '${sParcial.substring(0, 2)}${iSum.toString()}${sParcial.substring(2)}';
        break;
      case 0:
        sParcial =
            '${sParcial.substring(0, 3)}${iSum.toString()}${sParcial.substring(3)}';
        break;
    }
    ;
    sres += sParcial;
  }
  return sres;
}
