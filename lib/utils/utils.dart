import 'dart:ui';

import '../exports.dart';

Widget showMyProgress() {
  return BackdropFilter(
    filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
    child: Container(
      alignment: Alignment.center,
      // color: Colors.black.withValues(alpha: 0.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.greenAccent,
              blurRadius: 150,
              spreadRadius: 1,
              blurStyle: BlurStyle.normal,
            ),
          ],
          color: Colors.greenAccent.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: CircularProgressIndicator(),
      ),
    ),
  );
}

Widget skeleton({double? height, double? width, double? radius, Widget? child}) {
  radius ??= 16;
  return Container(
    height: height,
    width: width,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(radius),
    ),
    child: child,
  );
}

Widget shimmerColors({required Widget child, bool enabled = true}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey,
    highlightColor: Colors.grey.shade100,
    enabled: enabled,
    child: child,
  );
}

confirmGeneralDialog(
    BuildContext context,
    String title, {
      String? subTitle,
      Alignment? alignment,
      Color? backgraoundColor,
      Color? okBtnColor,
      Color? noBtnColor,
      Color? okTextColor,
      Color? noTextColor,
      Function()? pressOk,
      Function()? pressNo,
      bool visibleBtnNo = true,
      bool visibleBtnYes = true,
      String? textOk,
      String? textNo,
      TextAlign? titleAlignment,
      TextAlign? subTitleAlignment,
    }) async {
  backgraoundColor ??= Colors.white;
  return showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black.withValues(alpha: 0.7),
    transitionDuration: const Duration(milliseconds: 250),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      alignment ??= Alignment.center;
      return Align(
        alignment: alignment!,
        child: Container(
          margin: const EdgeInsets.all(26),
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: backgraoundColor,
              border: Border.all(width: 1, color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(22))),
          child: Material(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Icon(Icons.clear, size: 24, color: Colors.grey),
                      ),
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        textAlign: titleAlignment ?? TextAlign.center,
                        title,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                    if (subTitle != null) 4.height,
                    if (subTitle != null)
                      Text(
                        textAlign: subTitleAlignment ?? TextAlign.center,
                        subTitle,
                        style: const TextStyle(fontSize: 16, color: colorGrey),
                      ),
                    4.height,
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (visibleBtnNo)
                            Expanded(
                              child: Container(
                                height: 56,
                                decoration: BoxDecoration(
                                  color: noBtnColor ?? colorLightGrey,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      if (pressNo != null) {
                                        pressNo();
                                      }
                                    },
                                    child: Text(
                                      textNo ?? "No",
                                      style: TextStyle(
                                        color: noTextColor ?? Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )),
                              ),
                            ),
                          if (visibleBtnNo && visibleBtnYes) 10.width,
                          if (visibleBtnYes)
                            Expanded(
                              child: Container(
                                height: 56,
                                decoration: BoxDecoration(
                                  color: okBtnColor ?? colorPrimary,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    if (pressOk != null) {
                                      pressOk();
                                    }
                                  },
                                  child: Text(
                                    textOk ?? "Yes",
                                    style: TextStyle(
                                      color: okTextColor ?? Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return ScaleTransition(
        scale: Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: anim1, curve: Curves.easeInOut),
        ),
        child: child,
      );
    },
  );
}
