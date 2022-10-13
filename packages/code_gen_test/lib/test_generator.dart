import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'test_metadata.dart';

///element.toString: class TestModel
// element.name: TestModel
// element.metadata: [@ParamMetadata("ParamMetadata", 2),@TestMetadata("papapa")]
// element.kind: CLASS
// element.displayName: TestModel
// element.documentationComment: null
// element.enclosingElement: flutter_annotation|lib/demo_class.dart
// element.hasAlwaysThrows: false
// element.hasDeprecated: false
// element.hasFactory: false
// element.hasIsTest: false
// element.hasLiteral: false
// element.hasOverride: false
// element.hasProtected: false
// element.hasRequired: false
// element.isPrivate: false
// element.isPublic: true
// element.isSynthetic: false
// element.nameLength: 9
// element.runtimeType: ClassElementImpl
// ...
/// 入口，build.yaml里面要配置这个
Builder testBuilder(BuilderOptions options) => LibraryBuilder(TestGenerator());

class TestGenerator extends GeneratorForAnnotation<TestMetadata> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    /// 1、Element
    print("element.toString=${element.toString()}");
    print("element.name=${element.name}");
    print("element.metadata=${element.metadata}");
    print("element.kind=${element.kind}");
    print("element.displayName=${element.displayName}");
    print("element.documentationComment=${element.documentationComment}");
    print("element.enclosingElement=${element.enclosingElement3}");
    print("element.hasAlwaysThrows=${element.hasAlwaysThrows}");
    print("element.runtimeType=${element.runtimeType}");

    if (element.kind == ElementKind.CLASS) {
      ///读取字段
      for (var e in ((element as ClassElement).fields)) {
        print("field:$e \n");
      }

      /// 读取方法
      for (var e in ((element as ClassElement).methods)) {
        print("method:$e \n");
      }
    }

    /// 2、annotation
    print("annotation.runtimeType=${annotation.runtimeType}");
    //read方法读取了不存在的参数名，会抛出异常，peek则不会，而是返回null。
    print("annotation.read(name)=${annotation.read("name")}");
    print("annotation.peek(id)=${annotation.peek("id")}");
    print("annotation.objectValue=${annotation.objectValue}");

    ///3、buildStep
//buildStep.runtimeType: BuildStepImpl
// buildStep.inputId.path: lib/demo_class.dart
// buildStep.inputId.extension: .dart
// buildStep.inputId.package: flutter_annotation
// buildStep.inputId.uri: package:flutter_annotation/demo_class.dart
// buildStep.inputId.pathSegments: [lib, demo_class.dart]
// buildStep.expectedOutputs.path: lib/demo_class.g.dart
// buildStep.expectedOutputs.extension: .dart
// buildStep.expectedOutputs.package: flutter_annotation

    /// 生成以下代码
    // return "class TestClass{}";
    ///字符串进行拼接，不推荐
    // StringBuffer codeBuffer = StringBuffer("\n");
    // codeBuffer
    //   ..write("class ")
    //   ..write(element.name)
    //   ..write("_APT{")
    //   ..writeln("\n")
    //   ..writeln("}");
    // return codeBuffer.toString();

    return tempCode(element.name ?? "");
  }
}

///三引号,结合占位符后，可以实现比较清晰的模板代码：
tempCode(String className) {
  return """
      class ${className}APT {
 
      }
      """;
}
