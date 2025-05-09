import 'package:collection/collection.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<String> getPlaceMarkFromLatLng(double latitude, double longitude) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

    final Placemark? placemark = placemarks.firstOrNull;
    if (placemark == null) return "Joy topilmadi!";

    return _placemarkAddressFullName(placemark);
  } catch (e) {
    // Xatolik bo‘lsa (masalan, internet yo‘q yoki joy aniqlanmadi)
    return "Joy aniqlashda xatolik: $e";
  }
}

String _placemarkAddressFullName(Placemark address) {
  var country = _editName(address.country ?? "");
  var administrativeArea = _editName(address.administrativeArea ?? "");
  var subAdministrativeArea = _editName(address.subAdministrativeArea ?? "");
  var locality = _editName(address.locality ?? "");
  var subLocality = _editName(address.subLocality ?? "");
  var thoroughfare = _editName(address.thoroughfare ?? "");
  var subThoroughfare = _editName(address.subThoroughfare ?? "");
  var street = _editName(address.street ?? "");

  var name = subAdministrativeArea + locality + subLocality + thoroughfare + subThoroughfare;
  return name.isNotEmpty
      ? name
      : administrativeArea.isNotEmpty
          ? administrativeArea
          : "Joy nomi aniqlanmadi!";

//   Name: 75,
//   Street: 75 Yusuf Hos Hojib ko'chasi,
//   ISO Country Code: UZ,
//   Country: Uzbekistan,
//   Postal code: 100087,
//   Administrative area: Toshkent,
//   Subadministrative area: ,
//   Locality: Tashkent,
//   Sublocality: Yakkasaroy tumani,
//   Thoroughfare: Yusuf Hos Hojib ko'chasi,
//   Subthoroughfare: 75
}

String _editName(String value) {
  if (value.isNotEmpty && value != "Unnamed Road") {
    return "$value, ";
  }
  return "";
}
