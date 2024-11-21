import 'dart:developer';

import 'package:intl/intl.dart';

import '../features/data/models/responses/splash_response.dart';

class AppValidator {
  static const passwordSpecialChars = '#\$%@*+,-.&';
  final emojiRegexp =
      '   /\uD83C\uDFF4\uDB40\uDC67\uDB40\uDC62(?:\uDB40\uDC77\uDB40\uDC6C\uDB40\uDC73|\uDB40\uDC73\uDB40\uDC63\uDB40\uDC74|\uDB40\uDC65\uDB40\uDC6E\uDB40\uDC67)\uDB40\uDC7F|\uD83D\uDC69\u200D\uD83D\uDC69\u200D(?:\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67]))|\uD83D\uDC68(?:\uD83C\uDFFF\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB-\uDFFE])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFE\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB-\uDFFD\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFD\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB\uDFFC\uDFFE\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFC\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB\uDFFD-\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFB\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFC-\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\u200D(?:\u2764\uFE0F\u200D(?:\uD83D\uDC8B\u200D)?\uD83D\uDC68|(?:\uD83D[\uDC68\uDC69])\u200D(?:\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67]))|\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67])|(?:\uD83D[\uDC68\uDC69])\u200D(?:\uD83D[\uDC66\uDC67])|[\u2695\u2696\u2708]\uFE0F|\uD83D[\uDC66\uDC67]|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|(?:\uD83C\uDFFF\u200D[\u2695\u2696\u2708]|\uD83C\uDFFE\u200D[\u2695\u2696\u2708]|\uD83C\uDFFD\u200D[\u2695\u2696\u2708]|\uD83C\uDFFC\u200D[\u2695\u2696\u2708]|\uD83C\uDFFB\u200D[\u2695\u2696\u2708])\uFE0F|\uD83C\uDFFF|\uD83C\uDFFE|\uD83C\uDFFD|\uD83C\uDFFC|\uD83C\uDFFB)?|\uD83E\uDDD1(?:(?:\uD83C[\uDFFB-\uDFFF])\u200D(?:\uD83E\uDD1D\u200D\uD83E\uDDD1(?:\uD83C[\uDFFB-\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF84\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\u200D(?:\uD83E\uDD1D\u200D\uD83E\uDDD1|\uD83C[\uDF3E\uDF73\uDF7C\uDF84\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD]))|\uD83D\uDC69(?:\u200D(?:\u2764\uFE0F\u200D(?:\uD83D\uDC8B\u200D(?:\uD83D[\uDC68\uDC69])|\uD83D[\uDC68\uDC69])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFF\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFE\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFD\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFC\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFB\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD]))|\uD83D\uDC69\uD83C\uDFFF\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB-\uDFFE])|\uD83D\uDC69\uD83C\uDFFE\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB-\uDFFD\uDFFF])|\uD83D\uDC69\uD83C\uDFFD\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB\uDFFC\uDFFE\uDFFF])|\uD83D\uDC69\uD83C\uDFFC\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB\uDFFD-\uDFFF])|\uD83D\uDC69\uD83C\uDFFB\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFC-\uDFFF])|\uD83D\uDC69\u200D\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC69\u200D\uD83D\uDC69\u200D(?:\uD83D[\uDC66\uDC67])|(?:\uD83D\uDC41\uFE0F\u200D\uD83D\uDDE8|\uD83D\uDC69(?:\uD83C\uDFFF\u200D[\u2695\u2696\u2708]|\uD83C\uDFFE\u200D[\u2695\u2696\u2708]|\uD83C\uDFFD\u200D[\u2695\u2696\u2708]|\uD83C\uDFFC\u200D[\u2695\u2696\u2708]|\uD83C\uDFFB\u200D[\u2695\u2696\u2708]|\u200D[\u2695\u2696\u2708])|\uD83C\uDFF3\uFE0F\u200D\u26A7|\uD83E\uDDD1(?:(?:\uD83C[\uDFFB-\uDFFF])\u200D[\u2695\u2696\u2708]|\u200D[\u2695\u2696\u2708])|\uD83D\uDC3B\u200D\u2744|(?:(?:\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD])(?:\uD83C[\uDFFB-\uDFFF])|\uD83D\uDC6F|\uD83E[\uDD3C\uDDDE\uDDDF])\u200D[\u2640\u2642]|(?:\u26F9|\uD83C[\uDFCB\uDFCC]|\uD83D\uDD75)(?:\uFE0F|\uD83C[\uDFFB-\uDFFF])\u200D[\u2640\u2642]|\uD83C\uDFF4\u200D\u2620|(?:\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD])\u200D[\u2640\u2642]|[\xA9\xAE\u203C\u2049\u2122\u2139\u2194-\u2199\u21A9\u21AA\u2328\u23CF\u23ED-\u23EF\u23F1\u23F2\u23F8-\u23FA\u24C2\u25AA\u25AB\u25B6\u25C0\u25FB\u25FC\u2600-\u2604\u260E\u2611\u2618\u2620\u2622\u2623\u2626\u262A\u262E\u262F\u2638-\u263A\u2640\u2642\u265F\u2660\u2663\u2665\u2666\u2668\u267B\u267E\u2692\u2694-\u2697\u2699\u269B\u269C\u26A0\u26A7\u26B0\u26B1\u26C8\u26CF\u26D1\u26D3\u26E9\u26F0\u26F1\u26F4\u26F7\u26F8\u2702\u2708\u2709\u270F\u2712\u2714\u2716\u271D\u2721\u2733\u2734\u2744\u2747\u2763\u2764\u27A1\u2934\u2935\u2B05-\u2B07\u3030\u303D\u3297\u3299]|\uD83C[\uDD70\uDD71\uDD7E\uDD7F\uDE02\uDE37\uDF21\uDF24-\uDF2C\uDF36\uDF7D\uDF96\uDF97\uDF99-\uDF9B\uDF9E\uDF9F\uDFCD\uDFCE\uDFD4-\uDFDF\uDFF5\uDFF7]|\uD83D[\uDC3F\uDCFD\uDD49\uDD4A\uDD6F\uDD70\uDD73\uDD76-\uDD79\uDD87\uDD8A-\uDD8D\uDDA5\uDDA8\uDDB1\uDDB2\uDDBC\uDDC2-\uDDC4\uDDD1-\uDDD3\uDDDC-\uDDDE\uDDE1\uDDE3\uDDE8\uDDEF\uDDF3\uDDFA\uDECB\uDECD-\uDECF\uDEE0-\uDEE5\uDEE9\uDEF0\uDEF3])\uFE0F|\uD83D\uDC69\u200D\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67])|\uD83C\uDFF3\uFE0F\u200D\uD83C\uDF08|\uD83D\uDC69\u200D\uD83D\uDC67|\uD83D\uDC69\u200D\uD83D\uDC66|\uD83D\uDC15\u200D\uD83E\uDDBA|\uD83D\uDC69(?:\uD83C\uDFFF|\uD83C\uDFFE|\uD83C\uDFFD|\uD83C\uDFFC|\uD83C\uDFFB)?|\uD83C\uDDFD\uD83C\uDDF0|\uD83C\uDDF6\uD83C\uDDE6|\uD83C\uDDF4\uD83C\uDDF2|\uD83D\uDC08\u200D\u2B1B|\uD83D\uDC41\uFE0F|\uD83C\uDFF3\uFE0F|\uD83E\uDDD1(?:\uD83C[\uDFFB-\uDFFF])?|\uD83C\uDDFF(?:\uD83C[\uDDE6\uDDF2\uDDFC])|\uD83C\uDDFE(?:\uD83C[\uDDEA\uDDF9])|\uD83C\uDDFC(?:\uD83C[\uDDEB\uDDF8])|\uD83C\uDDFB(?:\uD83C[\uDDE6\uDDE8\uDDEA\uDDEC\uDDEE\uDDF3\uDDFA])|\uD83C\uDDFA(?:\uD83C[\uDDE6\uDDEC\uDDF2\uDDF3\uDDF8\uDDFE\uDDFF])|\uD83C\uDDF9(?:\uD83C[\uDDE6\uDDE8\uDDE9\uDDEB-\uDDED\uDDEF-\uDDF4\uDDF7\uDDF9\uDDFB\uDDFC\uDDFF])|\uD83C\uDDF8(?:\uD83C[\uDDE6-\uDDEA\uDDEC-\uDDF4\uDDF7-\uDDF9\uDDFB\uDDFD-\uDDFF])|\uD83C\uDDF7(?:\uD83C[\uDDEA\uDDF4\uDDF8\uDDFA\uDDFC])|\uD83C\uDDF5(?:\uD83C[\uDDE6\uDDEA-\uDDED\uDDF0-\uDDF3\uDDF7-\uDDF9\uDDFC\uDDFE])|\uD83C\uDDF3(?:\uD83C[\uDDE6\uDDE8\uDDEA-\uDDEC\uDDEE\uDDF1\uDDF4\uDDF5\uDDF7\uDDFA\uDDFF])|\uD83C\uDDF2(?:\uD83C[\uDDE6\uDDE8-\uDDED\uDDF0-\uDDFF])|\uD83C\uDDF1(?:\uD83C[\uDDE6-\uDDE8\uDDEE\uDDF0\uDDF7-\uDDFB\uDDFE])|\uD83C\uDDF0(?:\uD83C[\uDDEA\uDDEC-\uDDEE\uDDF2\uDDF3\uDDF5\uDDF7\uDDFC\uDDFE\uDDFF])|\uD83C\uDDEF(?:\uD83C[\uDDEA\uDDF2\uDDF4\uDDF5])|\uD83C\uDDEE(?:\uD83C[\uDDE8-\uDDEA\uDDF1-\uDDF4\uDDF6-\uDDF9])|\uD83C\uDDED(?:\uD83C[\uDDF0\uDDF2\uDDF3\uDDF7\uDDF9\uDDFA])|\uD83C\uDDEC(?:\uD83C[\uDDE6\uDDE7\uDDE9-\uDDEE\uDDF1-\uDDF3\uDDF5-\uDDFA\uDDFC\uDDFE])|\uD83C\uDDEB(?:\uD83C[\uDDEE-\uDDF0\uDDF2\uDDF4\uDDF7])|\uD83C\uDDEA(?:\uD83C[\uDDE6\uDDE8\uDDEA\uDDEC\uDDED\uDDF7-\uDDFA])|\uD83C\uDDE9(?:\uD83C[\uDDEA\uDDEC\uDDEF\uDDF0\uDDF2\uDDF4\uDDFF])|\uD83C\uDDE8(?:\uD83C[\uDDE6\uDDE8\uDDE9\uDDEB-\uDDEE\uDDF0-\uDDF5\uDDF7\uDDFA-\uDDFF])|\uD83C\uDDE7(?:\uD83C[\uDDE6\uDDE7\uDDE9-\uDDEF\uDDF1-\uDDF4\uDDF6-\uDDF9\uDDFB\uDDFC\uDDFE\uDDFF])|\uD83C\uDDE6(?:\uD83C[\uDDE8-\uDDEC\uDDEE\uDDF1\uDDF2\uDDF4\uDDF6-\uDDFA\uDDFC\uDDFD\uDDFF])|[#\*0-9]\uFE0F\u20E3|(?:\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD])(?:\uD83C[\uDFFB-\uDFFF])|(?:\u26F9|\uD83C[\uDFCB\uDFCC]|\uD83D\uDD75)(?:\uFE0F|\uD83C[\uDFFB-\uDFFF])|\uD83C\uDFF4|(?:[\u270A\u270B]|\uD83C[\uDF85\uDFC2\uDFC7]|\uD83D[\uDC42\uDC43\uDC46-\uDC50\uDC66\uDC67\uDC6B-\uDC6D\uDC72\uDC74-\uDC76\uDC78\uDC7C\uDC83\uDC85\uDCAA\uDD7A\uDD95\uDD96\uDE4C\uDE4F\uDEC0\uDECC]|\uD83E[\uDD0C\uDD0F\uDD18-\uDD1C\uDD1E\uDD1F\uDD30-\uDD34\uDD36\uDD77\uDDB5\uDDB6\uDDBB\uDDD2-\uDDD5])(?:\uD83C[\uDFFB-\uDFFF])|(?:[\u261D\u270C\u270D]|\uD83D[\uDD74\uDD90])(?:\uFE0F|\uD83C[\uDFFB-\uDFFF])|[\u270A\u270B]|\uD83C[\uDF85\uDFC2\uDFC7]|\uD83D[\uDC08\uDC15\uDC3B\uDC42\uDC43\uDC46-\uDC50\uDC66\uDC67\uDC6B-\uDC6D\uDC72\uDC74-\uDC76\uDC78\uDC7C\uDC83\uDC85\uDCAA\uDD7A\uDD95\uDD96\uDE4C\uDE4F\uDEC0\uDECC]|\uD83E[\uDD0C\uDD0F\uDD18-\uDD1C\uDD1E\uDD1F\uDD30-\uDD34\uDD36\uDD77\uDDB5\uDDB6\uDDBB\uDDD2-\uDDD5]|\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD]|\uD83D\uDC6F|\uD83E[\uDD3C\uDDDE\uDDDF]|[\u231A\u231B\u23E9-\u23EC\u23F0\u23F3\u25FD\u25FE\u2614\u2615\u2648-\u2653\u267F\u2693\u26A1\u26AA\u26AB\u26BD\u26BE\u26C4\u26C5\u26CE\u26D4\u26EA\u26F2\u26F3\u26F5\u26FA\u26FD\u2705\u2728\u274C\u274E\u2753-\u2755\u2757\u2795-\u2797\u27B0\u27BF\u2B1B\u2B1C\u2B50\u2B55]|\uD83C[\uDC04\uDCCF\uDD8E\uDD91-\uDD9A\uDE01\uDE1A\uDE2F\uDE32-\uDE36\uDE38-\uDE3A\uDE50\uDE51\uDF00-\uDF20\uDF2D-\uDF35\uDF37-\uDF7C\uDF7E-\uDF84\uDF86-\uDF93\uDFA0-\uDFC1\uDFC5\uDFC6\uDFC8\uDFC9\uDFCF-\uDFD3\uDFE0-\uDFF0\uDFF8-\uDFFF]|\uD83D[\uDC00-\uDC07\uDC09-\uDC14\uDC16-\uDC3A\uDC3C-\uDC3E\uDC40\uDC44\uDC45\uDC51-\uDC65\uDC6A\uDC79-\uDC7B\uDC7D-\uDC80\uDC84\uDC88-\uDCA9\uDCAB-\uDCFC\uDCFF-\uDD3D\uDD4B-\uDD4E\uDD50-\uDD67\uDDA4\uDDFB-\uDE44\uDE48-\uDE4A\uDE80-\uDEA2\uDEA4-\uDEB3\uDEB7-\uDEBF\uDEC1-\uDEC5\uDED0-\uDED2\uDED5-\uDED7\uDEEB\uDEEC\uDEF4-\uDEFC\uDFE0-\uDFEB]|\uD83E[\uDD0D\uDD0E\uDD10-\uDD17\uDD1D\uDD20-\uDD25\uDD27-\uDD2F\uDD3A\uDD3F-\uDD45\uDD47-\uDD76\uDD78\uDD7A-\uDDB4\uDDB7\uDDBA\uDDBC-\uDDCB\uDDD0\uDDE0-\uDDFF\uDE70-\uDE74\uDE78-\uDE7A\uDE80-\uDE86\uDE90-\uDEA8\uDEB0-\uDEB6\uDEC0-\uDEC2\uDED0-\uDED6]|(?:[\u231A\u231B\u23E9-\u23EC\u23F0\u23F3\u25FD\u25FE\u2614\u2615\u2648-\u2653\u267F\u2693\u26A1\u26AA\u26AB\u26BD\u26BE\u26C4\u26C5\u26CE\u26D4\u26EA\u26F2\u26F3\u26F5\u26FA\u26FD\u2705\u270A\u270B\u2728\u274C\u274E\u2753-\u2755\u2757\u2795-\u2797\u27B0\u27BF\u2B1B\u2B1C\u2B50\u2B55]|\uD83C[\uDC04\uDCCF\uDD8E\uDD91-\uDD9A\uDDE6-\uDDFF\uDE01\uDE1A\uDE2F\uDE32-\uDE36\uDE38-\uDE3A\uDE50\uDE51\uDF00-\uDF20\uDF2D-\uDF35\uDF37-\uDF7C\uDF7E-\uDF93\uDFA0-\uDFCA\uDFCF-\uDFD3\uDFE0-\uDFF0\uDFF4\uDFF8-\uDFFF]|\uD83D[\uDC00-\uDC3E\uDC40\uDC42-\uDCFC\uDCFF-\uDD3D\uDD4B-\uDD4E\uDD50-\uDD67\uDD7A\uDD95\uDD96\uDDA4\uDDFB-\uDE4F\uDE80-\uDEC5\uDECC\uDED0-\uDED2\uDED5-\uDED7\uDEEB\uDEEC\uDEF4-\uDEFC\uDFE0-\uDFEB]|\uD83E[\uDD0C-\uDD3A\uDD3C-\uDD45\uDD47-\uDD78\uDD7A-\uDDCB\uDDCD-\uDDFF\uDE70-\uDE74\uDE78-\uDE7A\uDE80-\uDE86\uDE90-\uDEA8\uDEB0-\uDEB6\uDEC0-\uDEC2\uDED0-\uDED6])|(?:[#\*0-9\xA9\xAE\u203C\u2049\u2122\u2139\u2194-\u2199\u21A9\u21AA\u231A\u231B\u2328\u23CF\u23E9-\u23F3\u23F8-\u23FA\u24C2\u25AA\u25AB\u25B6\u25C0\u25FB-\u25FE\u2600-\u2604\u260E\u2611\u2614\u2615\u2618\u261D\u2620\u2622\u2623\u2626\u262A\u262E\u262F\u2638-\u263A\u2640\u2642\u2648-\u2653\u265F\u2660\u2663\u2665\u2666\u2668\u267B\u267E\u267F\u2692-\u2697\u2699\u269B\u269C\u26A0\u26A1\u26A7\u26AA\u26AB\u26B0\u26B1\u26BD\u26BE\u26C4\u26C5\u26C8\u26CE\u26CF\u26D1\u26D3\u26D4\u26E9\u26EA\u26F0-\u26F5\u26F7-\u26FA\u26FD\u2702\u2705\u2708-\u270D\u270F\u2712\u2714\u2716\u271D\u2721\u2728\u2733\u2734\u2744\u2747\u274C\u274E\u2753-\u2755\u2757\u2763\u2764\u2795-\u2797\u27A1\u27B0\u27BF\u2934\u2935\u2B05-\u2B07\u2B1B\u2B1C\u2B50\u2B55\u3030\u303D\u3297\u3299]|\uD83C[\uDC04\uDCCF\uDD70\uDD71\uDD7E\uDD7F\uDD8E\uDD91-\uDD9A\uDDE6-\uDDFF\uDE01\uDE02\uDE1A\uDE2F\uDE32-\uDE3A\uDE50\uDE51\uDF00-\uDF21\uDF24-\uDF93\uDF96\uDF97\uDF99-\uDF9B\uDF9E-\uDFF0\uDFF3-\uDFF5\uDFF7-\uDFFF]|\uD83D[\uDC00-\uDCFD\uDCFF-\uDD3D\uDD49-\uDD4E\uDD50-\uDD67\uDD6F\uDD70\uDD73-\uDD7A\uDD87\uDD8A-\uDD8D\uDD90\uDD95\uDD96\uDDA4\uDDA5\uDDA8\uDDB1\uDDB2\uDDBC\uDDC2-\uDDC4\uDDD1-\uDDD3\uDDDC-\uDDDE\uDDE1\uDDE3\uDDE8\uDDEF\uDDF3\uDDFA-\uDE4F\uDE80-\uDEC5\uDECB-\uDED2\uDED5-\uDED7\uDEE0-\uDEE5\uDEE9\uDEEB\uDEEC\uDEF0\uDEF3-\uDEFC\uDFE0-\uDFEB]|\uD83E[\uDD0C-\uDD3A\uDD3C-\uDD45\uDD47-\uDD78\uDD7A-\uDDCB\uDDCD-\uDDFF\uDE70-\uDE74\uDE78-\uDE7A\uDE80-\uDE86\uDE90-\uDEA8\uDEB0-\uDEB6\uDEC0-\uDEC2\uDED0-\uDED6])\uFE0F|(?:[\u261D\u26F9\u270A-\u270D]|\uD83C[\uDF85\uDFC2-\uDFC4\uDFC7\uDFCA-\uDFCC]|\uD83D[\uDC42\uDC43\uDC46-\uDC50\uDC66-\uDC78\uDC7C\uDC81-\uDC83\uDC85-\uDC87\uDC8F\uDC91\uDCAA\uDD74\uDD75\uDD7A\uDD90\uDD95\uDD96\uDE45-\uDE47\uDE4B-\uDE4F\uDEA3\uDEB4-\uDEB6\uDEC0\uDECC]|\uD83E[\uDD0C\uDD0F\uDD18-\uDD1F\uDD26\uDD30-\uDD39\uDD3C-\uDD3E\uDD77\uDDB5\uDDB6\uDDB8\uDDB9\uDDBB\uDDCD-\uDDCF\uDDD1-\uDDDD])/';

  /// Validate NIC
  bool advancedNicValidation(String? nic) {
    String nic_part1, nic_part2;
    int length = nic!.length;
    bool retVal = false;
    try {
      if (length == 10) {
        try {
          nic_part1 = nic.substring(length - 1, length);
          nic_part2 = nic.substring(0, length - 1);

          double.parse(nic_part2);
          if (nic_part1 == "v" ||
              nic_part1 == "V" ||
              nic_part1 == "x" ||
              nic_part1 == "X") {
            retVal = validateDayOfTheYear(nic);
          }
        } on FormatException {
          retVal = false;
        }
      } else if (length == 12) {
        try {
          double.parse(nic);
          retVal = validateDayOfTheYear(nic);
        } on FormatException {
          retVal = false;
        }
      }
    } on Exception {
      retVal = false;
    }

    return retVal;
  }

  static bool validateDayOfTheYear(String nic) {
    bool ret = false;
    int sex = 0;
    if (nic.length == 10) {
      sex = int.parse(nic.substring(2, 5));
    } else if (nic.length == 12) {
      sex = int.parse(nic.substring(4, 7));
    }

    if ((sex > 0 && sex <= 366) || sex > 500 && sex <= 866) {
      ret = true;
    } else {
      ret = false;
    }
    return ret;
  }

  /// NIC with DOB Validator
  bool nicDobValidate(String nic, String dateOfBirth) {
    bool isValid = false;
    try {
      final DateResponse dateResponse = getDateResponse(nic);
      final DateTime dob = DateFormat('dd/MM/yyyy').parse(dateOfBirth);

      if (dateResponse.year == dob.year &&
          dateResponse.month == dob.month &&
          dateResponse.day == dob.day) {
        isValid = true;
      }
    } on Exception catch (e) {
      log(e.toString());
    } catch (e) {
      log(e.toString());
    }
    return isValid;
  }

  // Check if NIC is new format
  bool isNewFormat(String nic) {
    if (nic.length == 12) {
      return true;
    } else {
      return false;
    }
  }

  // Get day count
  int getDayCount(String nic) {
    int d;
    if (isNewFormat(nic)) {
      d = int.parse(nic.substring(4, 7));
    } else {
      d = int.parse(nic.substring(2, 5));
    }
    if (d > 500) {
      return d - 500;
    } else {
      return d;
    }
  }

  // Get year
  int getYear(String nic) {
    if (isNewFormat(nic)) {
      return int.parse(nic.substring(0, 4));
    }
    return 1900 + int.parse(nic.substring(0, 2));
  }

  // Get Date Response
  DateResponse getDateResponse(String nic) {
    final DateResponse dateResponse = DateResponse();
    int month = 0;
    int day = 0;
    int dayCount = getDayCount(nic);
    final List<int> monthDaysList = [
      31,
      29,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31
    ];
    for (int i = 0; i < monthDaysList.length; i++) {
      if (dayCount < monthDaysList[i]) {
        month = i + 1;
        day = dayCount;
        break;
      } else {
        dayCount = dayCount - monthDaysList[i];
      }
    }

    dateResponse.year = getYear(nic);
    dateResponse.month = month;
    dateResponse.day = day;
    return dateResponse;
  }

  /// Email Validator
  bool validateEmail(String email) {
    // List<String> specialCharacters = ['!', '@', '#', '\$', '%', '^', '&', '*', '(', ')', ',', '.', '?', '"', ':', '{', '}', '|', '<', '>'];
    List<String> specialCharacters = [
      '!',
      '@',
      '#',
      '\$',
      '%',
      '^',
      '&',
      '*',
      '(',
      ')',
      ',',
      '.',
      '?',
      '"',
      ':',
      '{',
      '}',
      '|',
      '<',
      '>',
      '_',
      '~',
      '`',
      '-',
      '+',
      '=',
      '[',
      ']',
      '\\',
      ';',
      '\'',
      '/',
      '•',
      '√',
      'π',
      '÷',
      '×',
      '§',
      '∆',
      '£',
      '¢',
      '€',
      '¥',
      '°',
      '©',
      '®',
      '™',
      '✓'
    ];
    for (String specialChar in specialCharacters) {
      if (email.endsWith(specialChar)) {
        return false;
      } else if (email.startsWith(specialChar)) {
        return false;
      }
    }
    if (email.endsWith(" ") || email.endsWith(".")) {
      return false;
    } else {
      return RegExp(
              // r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~.0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              r"^[a-zA-Z0-9a-zA-Z0-90-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
    }
  }

  // static bool validateEmails(String email) {
  //   return RegExp(
  //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
  //       .hasMatch(email);
  // }
  /// Validate Mobile Number with length = 9
  bool validateMobileNmb(String mobileNo) {
    if (mobileNo.length == 10) {
      return false;
    } else {
      if (mobileNo[0] == "7") {
        return true;
      } else {
        return false;
      }
        }
  }

  /// Validate Mobile Number
  bool validateMobileNumber(String mobileNo) {
    if (mobileNo.length != 10) {
      return false;
    } else {
      if (mobileNo[0] == "0" && mobileNo[1] == "7") {
        return true;
      } else {
        return false;
      }
        }
  }

  bool isValidMobileNumberOnFreshLogin(String mobile) {
    bool valid = false;
    try {
      if (mobile.toString().trim().isNotEmpty) {
        if (mobile.substring(0, 2) == "07") {
          if (mobile.length == 10) {
            valid = true;
          }
        }
      }
    } on Exception {}
    return valid;
  }

  // static ValidateState validatePassword(
  //     String password, PasswordPolicy passwordPolicy) {
  //   if (password.length < passwordPolicy.minLength!) {
  //     return ValidateState(
  //         validate: false,
  //         description:
  //         "password should be ${passwordPolicy.minLength} to ${passwordPolicy.maxLength} Characters");
  //     // description:
  //     // "Password should be ${passwordPolicy.minLength} to ${passwordPolicy.maxLength} Characters");
  //   } else if (password.length > passwordPolicy.maxLength!) {
  //     return ValidateState(
  //         validate: false,  description:
  //     "password should be ${passwordPolicy.minLength} to ${passwordPolicy.maxLength} Characters");
  //   } else if (!_isLowercaseValidated(
  //       password, passwordPolicy.minimumLowercaseChars)) {
  //     return ValidateState(
  //         validate: false,  description:
  //     "password must have at least ${passwordPolicy.minimumLowercaseChars}  lowercase Character");
  //   } else if (!_isUppercaseValidated(
  //       password, passwordPolicy.minimumUpperCaseChars)) {
  //     return ValidateState(
  //         validate: false, description:
  //     "password must have at least ${passwordPolicy.minimumUpperCaseChars}  upercase Character");
  //   } else if (!_isNumericValidated(
  //       password, passwordPolicy.minimumNumericalChars)) {
  //     return ValidateState(
  //         validate: false,  description:
  //     "password must have at least ${passwordPolicy.minimumNumericalChars}  numerical Character");
  //   } else if (!_isRepeatedCharsValidated(
  //       password, passwordPolicy.repeatedChars)) {
  //     return ValidateState(
  //         validate: false,  description:
  //     "password can only have ${passwordPolicy.repeatedChars}  same Characters");
  //   } else if (!_isSpecialCharsValidate(
  //       password, passwordPolicy.minimumSpecialChars)) {
  //     return ValidateState(
  //       validate: false,
  //         description:
  //         "password must have at least ${passwordPolicy.minimumSpecialChars}  special Character");
  //       // isAppString: true,
  //     // );
  //   } else {
  //     return ValidateState(validate: true, description: "aa");
  //   }
  // }

  // static ValidateState validateUsername(
  //     String username, UserNamePolicy userNamePolicy) {
  //   if (username.length < userNamePolicy.minLength!) {
  //     return ValidateState(
  //         validate: false,
  //         description:
  //             "Username should be ${userNamePolicy.minLength} to ${userNamePolicy.maxLength} Characters");
  //   } else if (username.length > userNamePolicy.maxLength!) {
  //     return ValidateState(
  //         validate: false,
  //         description:
  //             "Username should be ${userNamePolicy.minLength} to ${userNamePolicy.maxLength} Characters");
  //   } else if (!_isLowercaseValidated(
  //       username, userNamePolicy.minimumLowercaseChars)) {
  //     return ValidateState(
  //         validate: false,
  //         // description: AppString.usernameCheckByLowerCase,
  //         description:
  //             "Username must have at least ${userNamePolicy.minimumLowercaseChars}  lowercase Character");
  //     // isAppString: true,
  //     // );
  //   } else if (!_isUppercaseValidated(
  //       username, userNamePolicy.minimumUpperCaseChars)) {
  //     return ValidateState(
  //         validate: false,
  //         // description: AppString.usernameCheckByUpperCase,
  //         description:
  //             "Username must have at least ${userNamePolicy.minimumUpperCaseChars}  upercase Character");
  //     // isAppString: true,
  //     // );
  //   } else if (!_isNumericValidated(
  //       username, userNamePolicy.minimumNumericalChars)) {
  //     return ValidateState(
  //         validate: false,
  //         // description: AppString.usernameCheckByNumericChar,
  //         description:
  //             "Username must have at least ${userNamePolicy.minimumNumericalChars}  numerical Character");
  //     // isAppString: true,
  //     // );
  //   } else if (!_isRepeatedCharsValidated(
  //       username, userNamePolicy.repeatedChars)) {
  //     return ValidateState(
  //         validate: false,
  //         // description: AppString.usernameCheckByRepeatedChar,
  //         description:
  //             "Username can only have ${userNamePolicy.repeatedChars}  same Characters");
  //     // isAppString: true,
  //     // );
  //   } else if (!_isSpecialCharsValidate(
  //       username, userNamePolicy.minimumSpecialChars)) {
  //     return ValidateState(
  //         validate: false,
  //         // description: AppString.usernameCheckBySpecialCharLength,
  //         description:
  //             "Username must have at least ${userNamePolicy.minimumSpecialChars}  special Character");
  //     // isAppString: true,
  //     // );
  //   } else {
  //     return ValidateState(validate: true, description: "");
  //   }
  // }

  // static bool _isSpecialCharsValidate(String word, int? count) {
  //   if (count == 0) {
  //     return true;
  //   } else {
  //     List<String> _specialChar = word
  //         .replaceAll(RegExp('[A-Z]'), "")
  //         .replaceAll(RegExp('[a-z]'), "")
  //         .replaceAll(RegExp('[0-9]'), "")
  //         .split("");

  //     if (_specialChar.length >= count!) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   }
  // }

  // static bool _isUppercaseValidated(String word, int? count) {
  //   if (count == 0) {
  //     return true;
  //   } else {
  //     int matches = 0;
  //     word
  //         .replaceAll(RegExp(r'[^\w\s]+'), '')
  //         .replaceAll(RegExp('[0-9]'), '')
  //         .split('')
  //         .forEach((element) {
  //       if (isUppercase(element)) matches++;
  //     });

  //     if (matches >= count!) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   }
  // }

  // static bool _isLowercaseValidated(String word, int? count) {
  //   if (count == 0) {
  //     return true;
  //   } else {
  //     int matches = 0;
  //     word
  //         .replaceAll(RegExp(r'[^\w\s]+'), '')
  //         .replaceAll(RegExp('[0-9]'), '')
  //         .split('')
  //         .forEach((element) {
  //       if (isLowercase(element)) matches++;
  //     });

  //     if (matches >= count!) {
  //       return true;
  //     }
  //     return false;
  //   }
  // }

  // static bool _isNumericValidated(String word, int? count) {
  //   if (count == 0) {
  //     return true;
  //   } else {
  //     int matches = 0;
  //     word.split('').forEach((element) {
  //       if (isNumeric(element)) matches++;
  //     });

  //     if (matches >= count!) {
  //       return true;
  //     }
  //     return false;
  //   }
  // }

  // static bool _isRepeatedCharsValidated(String word, int? count) {
  //   var charCodeCounts = <String, int>{};
  //   for (var i = 0; i < word.length; i += 1) {
  //     charCodeCounts[word[i]] = (charCodeCounts[word[i]] ?? 0) + 1;
  //   }
  //   var uniqueCharCodes = <String>[
  //     for (var entry in charCodeCounts.entries)
  //       if (entry.value > count!) entry.key,
  //   ];
  //   if (uniqueCharCodes.isNotEmpty) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  static ValidateState validatePassword(
      String password, PasswordPolicy passwordPolicy) {
    if (password.length < passwordPolicy.minLength!) {
      return ValidateState(
          validate: false,
          description:
              "Password should be ${passwordPolicy.minLength} to ${passwordPolicy.maxLength} Characters");
    }
    if (password.length > passwordPolicy.maxLength!) {
      return ValidateState(
          validate: false,
          description:
              "Password should be ${passwordPolicy.minLength} to ${passwordPolicy.maxLength} Characters");
    }

    if (!_isLowercaseValidated(
        password, passwordPolicy.minimumLowercaseChars)) {
      return ValidateState(
          validate: false,
          description:
              "Password must have at least ${passwordPolicy.minimumLowercaseChars} lowercase Character");
    }

    if (!_isUppercaseValidated(
        password, passwordPolicy.minimumUpperCaseChars)) {
      return ValidateState(
          validate: false,
          description:
              "Password must have at least ${passwordPolicy.minimumUpperCaseChars} upercase Character");
    }

    if (!_isNumericValidated(password, passwordPolicy.minimumNumericalChars)) {
      return ValidateState(
          validate: false,
          description:
              "Password must have at least ${passwordPolicy.minimumNumericalChars} numerical Character");
    }

    if (!_isSpecialCharsValidate(
        password, passwordPolicy.minimumSpecialChars)) {
      return ValidateState(
          validate: false,
          description:
              "Password must have at least ${passwordPolicy.minimumSpecialChars} special Character");
    }

    if (!_isRepeatedCharsValidated(password, passwordPolicy.repeatedChars)) {
      return ValidateState(
          validate: false,
          description:
              "Password can only have ${passwordPolicy.repeatedChars} same Characters");
    }

    return ValidateState(validate: true, description: "");
  }

  static ValidateState validateUsername(
      String username, UserNamePolicy userNamePolicy) {
    if (username.length < userNamePolicy.minLength!) {
      return ValidateState(
          validate: false,
          description:
              "Username should be ${userNamePolicy.minLength} to ${userNamePolicy.maxLength} Characters");
    }
    if (username.length > userNamePolicy.maxLength!) {
      return ValidateState(
          validate: false,
          description:
              "Username should be ${userNamePolicy.minLength} to ${userNamePolicy.maxLength} Characters");
    }
    if (!_isLowercaseValidated(
        username, userNamePolicy.minimumLowercaseChars)) {
      return ValidateState(
          validate: false,
          description:
              "Username must have at least ${userNamePolicy.minimumLowercaseChars} lowercase Character");
    }
    if (!_isUppercaseValidated(
        username, userNamePolicy.minimumUpperCaseChars)) {
      return ValidateState(
          validate: false,
          description:
              "Username must have at least ${userNamePolicy.minimumUpperCaseChars} upercase Character");
    }
    if (!_isNumericValidated(username, userNamePolicy.minimumNumericalChars)) {
      return ValidateState(
          validate: false,
          description:
              "Username must have at least ${userNamePolicy.minimumNumericalChars} numerical Character");
    }
    if (!_isSpecialCharsValidate(
        username, userNamePolicy.minimumSpecialChars)) {
      return ValidateState(
          validate: false,
          description:
              "Username must have at least ${userNamePolicy.minimumSpecialChars}  special Character");
    }
    if (!_isRepeatedCharsValidated(username, userNamePolicy.repeatedChars)) {
      return ValidateState(
          validate: false,
          description:
              "Username can only have ${userNamePolicy.repeatedChars}  same Characters");
    }

    return ValidateState(validate: true, description: "");
  }

  static bool _isSpecialCharsValidate(String word, int? count) {
    if (count == 0) {
      return true;
    } else {
      RegExp specialCharRegExp = RegExp(r'[^a-zA-Z0-9\s]');

      Iterable<Match> matches = specialCharRegExp.allMatches(word);

      if (matches.length >= count!) {
        return true;
      } else {
        return false;
      }
    }
  }

  static bool _isUppercaseValidated(String word, int? count) {
    if (count == 0) {
      return true;
    } else {
      RegExp uppercaseRegExp = RegExp(r'[A-Z]');

      Iterable<Match> matches = uppercaseRegExp.allMatches(word);

      if (matches.length >= count!) {
        return true;
      } else {
        return false;
      }
    }
  }

  static bool _isLowercaseValidated(String word, int? count) {
    if (count == 0) {
      return true;
    } else {
      RegExp lowercaseRegExp = RegExp(r'[a-z]');

      Iterable<Match> matches = lowercaseRegExp.allMatches(word);

      if (matches.length >= count!) {
        return true;
      }
      return false;
    }
  }

  static bool _isNumericValidated(String word, int? count) {
    if (count == 0) {
      return true;
    } else {
      RegExp numericalRegExp = RegExp(r'\d');

      Iterable<Match> matches = numericalRegExp.allMatches(word);

      if (matches.length >= count!) {
        return true;
      }
      return false;
    }
  }

  static bool _isRepeatedCharsValidated(String word, int? count) {
    final pattern = RegExp(r'(.)\1{' + (count).toString() + ',}');
    return !pattern.hasMatch(word);
  }

  static RegExp isNumberRegex(String regexPattern){
    if(regexPattern.contains("[0-9]")){
      if(regexPattern == "[0-9]"){
        return  RegExp('^$regexPattern+\$');
      }else{
        return RegExp(r'^'+'$regexPattern'+'\$');
      }
    }else{
      return RegExp(r'^'+'$regexPattern'+'\$');
    }
  }

   static bool isNumber(String regexPattern) {
    return regexPattern.contains("[0-9]");
  }
}

class DateResponse {
  int? year;
  int? month;
  int? day;
}

class ValidateState {
  bool? validate;
  bool isAppString;
  String? description;

  ValidateState({
    this.validate,
    this.description,
    this.isAppString = false,
  });
}
