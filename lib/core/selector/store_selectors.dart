import '../entity/enum/enums.dart';
import '../entity/model/undeliverable_code_model.dart';
import '../store/store.dart';

List<UndeliverableCodeModel> getUndeliverableAndRedeliveryReasons(
        Store store) =>
    store.undeliverableCodes;

List<UndeliverableCodeModel> getRedeliveryReasons(
    List<UndeliverableCodeModel> allUndeliverableCodes) {
  return allUndeliverableCodes
      .where((reason) =>
          reason.type == UndeliverableCodeType.BACK_LATTER ||
          reason.type == UndeliverableCodeType.BOTH)
      .toList();
}
