import 'package:code_gen_test/test_metadata.dart';

@ParamMetadata("ParamMetadata", 100)
@TestMetadata("papap")
class TestModel {
  String param1 = "";
  String name = "lanshifu";

  void func1() {}

  String func2(String param1) {
    return param1;
  }
}
