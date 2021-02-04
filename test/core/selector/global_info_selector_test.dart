import 'package:flutter_test/flutter_test.dart';
import 'package:gm_driver_lite/core/entity/enum/enums.dart';
import 'package:gm_driver_lite/core/entity/model/undeliverable_code_model.dart';
import 'package:gm_driver_lite/core/global/global_info.dart';
import 'package:gm_driver_lite/core/selector/global_info_selectors.dart';

void main() {
  group('GlobalInfo selectors', () {
    test(
      '''WHEN getUndeliverableAndRedeliveryReasons is called
         SHOULD return all undeliverableCodes
      ''',
      () {
        final globalInfo = GlobalInfo();
        globalInfo.undeliverableCodes = [
          UndeliverableCodeModel(),
        ];
        expect(
          getUndeliverableAndRedeliveryReasons(globalInfo),
          [
            UndeliverableCodeModel(),
          ],
        );
      },
    );

    test(
      '''WHEN getRedeliveryReasons is called
         SHOULD return all undeliverableCodes
      ''',
      () {
        final globalInfo = GlobalInfo();
        globalInfo.undeliverableCodes = [
          UndeliverableCodeModel(
            type: UndeliverableCodeType.BACK_LATTER,
          ),
          UndeliverableCodeModel(
            type: UndeliverableCodeType.BOTH,
          ),
          UndeliverableCodeModel(
            type: UndeliverableCodeType.UNSUCCESSFULL,
          ),
        ];
        expect(
          getRedeliveryReasons(globalInfo.undeliverableCodes),
          [
            UndeliverableCodeModel(
              type: UndeliverableCodeType.BACK_LATTER,
            ),
            UndeliverableCodeModel(
              type: UndeliverableCodeType.BOTH,
            ),
          ],
        );
      },
    );
  });
}
