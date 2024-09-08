import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.6866040, size.height * 0.3697140);
    path_0.cubicTo(
        size.width * 0.7028507,
        size.height * 0.3656292,
        size.width * 0.7207741,
        size.height * 0.3504181,
        size.width * 0.7345602,
        size.height * 0.3731755);
    path_0.cubicTo(
        size.width * 0.7483507,
        size.height * 0.3959428,
        size.width * 0.7486404,
        size.height * 0.4470513,
        size.width * 0.7562481,
        size.height * 0.4846805);
    path_0.cubicTo(
        size.width * 0.7644354,
        size.height * 0.5252012,
        size.width * 0.7853269,
        size.height * 0.5584714,
        size.width * 0.7809881,
        size.height * 0.6028462);
    path_0.cubicTo(
        size.width * 0.7765156,
        size.height * 0.6486055,
        size.width * 0.7499257,
        size.height * 0.6481085,
        size.width * 0.7370208,
        size.height * 0.6812761);
    path_0.cubicTo(
        size.width * 0.7256426,
        size.height * 0.7105168,
        size.width * 0.7252058,
        size.height * 0.7644122,
        size.width * 0.7108990,
        size.height * 0.7829822);
    path_0.cubicTo(
        size.width * 0.6962793,
        size.height * 0.8019566,
        size.width * 0.6774733,
        size.height * 0.7968284,
        size.width * 0.6629346,
        size.height * 0.7774359);
    path_0.cubicTo(
        size.width * 0.6491456,
        size.height * 0.7590454,
        size.width * 0.6451137,
        size.height * 0.7144379,
        size.width * 0.6356159,
        size.height * 0.6825661);
    path_0.cubicTo(
        size.width * 0.6267712,
        size.height * 0.6528876,
        size.width * 0.6132155,
        size.height * 0.6325030,
        size.width * 0.6090290,
        size.height * 0.5965523);
    path_0.cubicTo(
        size.width * 0.6045490,
        size.height * 0.5580809,
        size.width * 0.6054480,
        size.height * 0.5151834,
        size.width * 0.6118663,
        size.height * 0.4786193);
    path_0.cubicTo(
        size.width * 0.6182831,
        size.height * 0.4420631,
        size.width * 0.6307831,
        size.height * 0.4155148,
        size.width * 0.6442526,
        size.height * 0.3958876);
    path_0.cubicTo(
        size.width * 0.6571761,
        size.height * 0.3770552,
        size.width * 0.6718633,
        size.height * 0.3734221,
        size.width * 0.6866040,
        size.height * 0.3697140);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xffFFCF01).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.2902756, size.height * 0.2197732);
    path_1.cubicTo(
        size.width * 0.3064532,
        size.height * 0.2157061,
        size.width * 0.3243009,
        size.height * 0.2005641,
        size.width * 0.3380282,
        size.height * 0.2232189);
    path_1.cubicTo(
        size.width * 0.3517615,
        size.height * 0.2458836,
        size.width * 0.3520475,
        size.height * 0.2967594,
        size.width * 0.3596218,
        size.height * 0.3342170);
    path_1.cubicTo(
        size.width * 0.3677786,
        size.height * 0.3745523,
        size.width * 0.3885810,
        size.height * 0.4076726,
        size.width * 0.3842600,
        size.height * 0.4518462);
    path_1.cubicTo(
        size.width * 0.3798039,
        size.height * 0.4973964,
        size.width * 0.3533291,
        size.height * 0.4969014,
        size.width * 0.3404785,
        size.height * 0.5299191);
    path_1.cubicTo(
        size.width * 0.3291486,
        size.height * 0.5590276,
        size.width * 0.3287132,
        size.height * 0.6126765,
        size.width * 0.3144673,
        size.height * 0.6311617);
    path_1.cubicTo(
        size.width * 0.2999094,
        size.height * 0.6500513,
        size.width * 0.2811835,
        size.height * 0.6449467,
        size.width * 0.2667058,
        size.height * 0.6256410);
    path_1.cubicTo(
        size.width * 0.2529762,
        size.height * 0.6073333,
        size.width * 0.2489614,
        size.height * 0.5629310,
        size.width * 0.2395030,
        size.height * 0.5312032);
    path_1.cubicTo(
        size.width * 0.2306961,
        size.height * 0.5016607,
        size.width * 0.2171984,
        size.height * 0.4813669,
        size.width * 0.2130297,
        size.height * 0.4455799);
    path_1.cubicTo(
        size.width * 0.2085684,
        size.height * 0.4072840,
        size.width * 0.2094629,
        size.height * 0.3645799,
        size.width * 0.2158536,
        size.height * 0.3281834);
    path_1.cubicTo(
        size.width * 0.2222437,
        size.height * 0.2917929,
        size.width * 0.2346909,
        size.height * 0.2653649,
        size.width * 0.2481033,
        size.height * 0.2458264);
    path_1.cubicTo(
        size.width * 0.2609718,
        size.height * 0.2270809,
        size.width * 0.2755973,
        size.height * 0.2234635,
        size.width * 0.2902756,
        size.height * 0.2197732);
    path_1.close();

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = const Color(0xffFFCF01).withOpacity(1.0);
    canvas.drawPath(path_1, paint1Fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.6206211, size.height * 0.2492032);
    path_2.cubicTo(
        size.width * 0.6408418,
        size.height * 0.2417219,
        size.width * 0.6651798,
        size.height * 0.2209428,
        size.width * 0.6804881,
        size.height * 0.2584004);
    path_2.cubicTo(
        size.width * 0.6961776,
        size.height * 0.2967909,
        size.width * 0.6867251,
        size.height * 0.3700671,
        size.width * 0.6927474,
        size.height * 0.4256864);
    path_2.cubicTo(
        size.width * 0.6976657,
        size.height * 0.4711144,
        size.width * 0.7125565,
        size.height * 0.5064497,
        size.width * 0.7124814,
        size.height * 0.5538876);
    path_2.cubicTo(
        size.width * 0.7124019,
        size.height * 0.6039014,
        size.width * 0.7042251,
        size.height * 0.6522742,
        size.width * 0.6923284,
        size.height * 0.6898126);
    path_2.cubicTo(
        size.width * 0.6804814,
        size.height * 0.7271913,
        size.width * 0.6633180,
        size.height * 0.7448028,
        size.width * 0.6465022,
        size.height * 0.7620690);
    path_2.cubicTo(
        size.width * 0.6285617,
        size.height * 0.7804892,
        size.width * 0.6103834,
        size.height * 0.8004970,
        size.width * 0.5914272,
        size.height * 0.7934103);
    path_2.cubicTo(
        size.width * 0.5707786,
        size.height * 0.7856884,
        size.width * 0.5513202,
        size.height * 0.7601538,
        size.width * 0.5360520,
        size.height * 0.7207712);
    path_2.cubicTo(
        size.width * 0.5197244,
        size.height * 0.6786529,
        size.width * 0.5069621,
        size.height * 0.6250414,
        size.width * 0.5026189,
        size.height * 0.5643294);
    path_2.cubicTo(
        size.width * 0.4981523,
        size.height * 0.5018856,
        size.width * 0.4983522,
        size.height * 0.4308304,
        size.width * 0.5115951,
        size.height * 0.3788738);
    path_2.cubicTo(
        size.width * 0.5244220,
        size.height * 0.3285503,
        size.width * 0.5497905,
        size.height * 0.3234813,
        size.width * 0.5701947,
        size.height * 0.2992130);
    path_2.cubicTo(
        size.width * 0.5869413,
        size.height * 0.2792959,
        size.width * 0.6025639,
        size.height * 0.2558856,
        size.width * 0.6206211,
        size.height * 0.2492032);
    path_2.close();

    Paint paint2Fill = Paint()..style = PaintingStyle.fill;
    paint2Fill.color = const Color(0xff9EA2B0).withOpacity(1.0);
    canvas.drawPath(path_2, paint2Fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.1802979, size.height * 0.2149941);
    path_3.cubicTo(
        size.width * 0.2028648,
        size.height * 0.2156607,
        size.width * 0.2073915,
        size.height * 0.3070789,
        size.width * 0.2260550,
        size.height * 0.3401460);
    path_3.cubicTo(
        size.width * 0.2439383,
        size.height * 0.3718323,
        size.width * 0.2718477,
        size.height * 0.3565089,
        size.width * 0.2851954,
        size.height * 0.4008501);
    path_3.cubicTo(
        size.width * 0.2988640,
        size.height * 0.4462544,
        size.width * 0.3005550,
        size.height * 0.5128560,
        size.width * 0.2948276,
        size.height * 0.5686016);
    path_3.cubicTo(
        size.width * 0.2893217,
        size.height * 0.6221953,
        size.width * 0.2698692,
        size.height * 0.6546588,
        size.width * 0.2550319,
        size.height * 0.6944458);
    path_3.cubicTo(
        size.width * 0.2411055,
        size.height * 0.7317890,
        size.width * 0.2304621,
        size.height * 0.7891460,
        size.width * 0.2105862,
        size.height * 0.7944990);
    path_3.cubicTo(
        size.width * 0.1904643,
        size.height * 0.7999191,
        size.width * 0.1762868,
        size.height * 0.7448580,
        size.width * 0.1583499,
        size.height * 0.7204872);
    path_3.cubicTo(
        size.width * 0.1445609,
        size.height * 0.7017515,
        size.width * 0.1300126,
        size.height * 0.6913590,
        size.width * 0.1173544,
        size.height * 0.6678245);
    path_3.cubicTo(
        size.width * 0.1013031,
        size.height * 0.6379803,
        size.width * 0.07865825,
        size.height * 0.6156134,
        size.width * 0.07483210,
        size.height * 0.5652071);
    path_3.cubicTo(
        size.width * 0.07102838,
        size.height * 0.5151006,
        size.width * 0.08827192,
        size.height * 0.4715503,
        size.width * 0.09924220,
        size.height * 0.4292229);
    path_3.cubicTo(
        size.width * 0.1086486,
        size.height * 0.3929310,
        size.width * 0.1220706,
        size.height * 0.3686114,
        size.width * 0.1338707,
        size.height * 0.3374241);
    path_3.cubicTo(
        size.width * 0.1496478,
        size.height * 0.2957239,
        size.width * 0.1578276,
        size.height * 0.2143314,
        size.width * 0.1802979,
        size.height * 0.2149941);
    path_3.close();

    Paint paint3Fill = Paint()..style = PaintingStyle.fill;
    paint3Fill.color = const Color(0xff414786).withOpacity(1.0);
    canvas.drawPath(path_3, paint3Fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.7971397, size.height * 0.1893533);
    path_4.cubicTo(
        size.width * 0.8218053,
        size.height * 0.1900491,
        size.width * 0.8267533,
        size.height * 0.2855108,
        size.width * 0.8471545,
        size.height * 0.3200394);
    path_4.cubicTo(
        size.width * 0.8667013,
        size.height * 0.3531262,
        size.width * 0.8972065,
        size.height * 0.3371262,
        size.width * 0.9117979,
        size.height * 0.3834260);
    path_4.cubicTo(
        size.width * 0.9267385,
        size.height * 0.4308383,
        size.width * 0.9285884,
        size.height * 0.5003866,
        size.width * 0.9223254,
        size.height * 0.5585976);
    path_4.cubicTo(
        size.width * 0.9163076,
        size.height * 0.6145602,
        size.width * 0.8950446,
        size.height * 0.6484596,
        size.width * 0.8788262,
        size.height * 0.6900059);
    path_4.cubicTo(
        size.width * 0.8636033,
        size.height * 0.7290000,
        size.width * 0.8519762,
        size.height * 0.7888915,
        size.width * 0.8302452,
        size.height * 0.7944832);
    path_4.cubicTo(
        size.width * 0.8082541,
        size.height * 0.8001420,
        size.width * 0.7927563,
        size.height * 0.7426469,
        size.width * 0.7731501,
        size.height * 0.7171972);
    path_4.cubicTo(
        size.width * 0.7580832,
        size.height * 0.6976351,
        size.width * 0.7421798,
        size.height * 0.6867830,
        size.width * 0.7283432,
        size.height * 0.6622071);
    path_4.cubicTo(
        size.width * 0.7107994,
        size.height * 0.6310434,
        size.width * 0.6860475,
        size.height * 0.6076864,
        size.width * 0.6818655,
        size.height * 0.5550513);
    path_4.cubicTo(
        size.width * 0.6777080,
        size.height * 0.5027298,
        size.width * 0.6965557,
        size.height * 0.4572525,
        size.width * 0.7085468,
        size.height * 0.4130552);
    path_4.cubicTo(
        size.width * 0.7188284,
        size.height * 0.3751578,
        size.width * 0.7334993,
        size.height * 0.3497613,
        size.width * 0.7463967,
        size.height * 0.3171972);
    path_4.cubicTo(
        size.width * 0.7636404,
        size.height * 0.2736529,
        size.width * 0.7725854,
        size.height * 0.1886606,
        size.width * 0.7971397,
        size.height * 0.1893533);
    path_4.close();

    Paint paint4Fill = Paint()..style = PaintingStyle.fill;
    paint4Fill.color = const Color(0xff414786).withOpacity(1.0);
    canvas.drawPath(path_4, paint4Fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.4421389, size.height * 0.2199961);
    path_5.cubicTo(
        size.width * 0.4692526,
        size.height * 0.2303353,
        size.width * 0.4682325,
        size.height * 0.3221183,
        size.width * 0.4910074,
        size.height * 0.3544201);
    path_5.cubicTo(
        size.width * 0.5127117,
        size.height * 0.3852051,
        size.width * 0.5552860,
        size.height * 0.3450513,
        size.width * 0.5656865,
        size.height * 0.3952288);
    path_5.cubicTo(
        size.width * 0.5761939,
        size.height * 0.4459211,
        size.width * 0.5407051,
        size.height * 0.4888915,
        size.width * 0.5291887,
        size.height * 0.5386272);
    path_5.cubicTo(
        size.width * 0.5217831,
        size.height * 0.5706095,
        size.width * 0.5200676,
        size.height * 0.6062801,
        size.width * 0.5101330,
        size.height * 0.6351460);
    path_5.cubicTo(
        size.width * 0.4994406,
        size.height * 0.6662130,
        size.width * 0.4858091,
        size.height * 0.6907357,
        size.width * 0.4700632,
        size.height * 0.7104103);
    path_5.cubicTo(
        size.width * 0.4500513,
        size.height * 0.7354142,
        size.width * 0.4297184,
        size.height * 0.7708777,
        size.width * 0.4065736,
        size.height * 0.7645404);
    path_5.cubicTo(
        size.width * 0.3830022,
        size.height * 0.7580868,
        size.width * 0.3634368,
        size.height * 0.7192347,
        size.width * 0.3505416,
        size.height * 0.6776884);
    path_5.cubicTo(
        size.width * 0.3384346,
        size.height * 0.6386824,
        size.width * 0.3357533,
        size.height * 0.5899112,
        size.width * 0.3380357,
        size.height * 0.5437258);
    path_5.cubicTo(
        size.width * 0.3400141,
        size.height * 0.5036923,
        size.width * 0.3555862,
        size.height * 0.4745187,
        size.width * 0.3624421,
        size.height * 0.4368856);
    path_5.cubicTo(
        size.width * 0.3699814,
        size.height * 0.3955030,
        size.width * 0.3672987,
        size.height * 0.3473373,
        size.width * 0.3802184,
        size.height * 0.3121775);
    path_5.cubicTo(
        size.width * 0.3959510,
        size.height * 0.2693649,
        size.width * 0.4166568,
        size.height * 0.2102801,
        size.width * 0.4421389,
        size.height * 0.2199961);
    path_5.close();

    Paint paint5Fill = Paint()..style = PaintingStyle.fill;
    paint5Fill.color = const Color(0xffEAEBEE).withOpacity(1.0);
    canvas.drawPath(path_5, paint5Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
