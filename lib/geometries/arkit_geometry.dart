import 'package:arkit_plugin/geometries/arkit_material.dart';
import 'package:flutter/widgets.dart';
import 'package:arkit_plugin/utils/random_string.dart' as random_string;
import 'package:arkit_plugin/utils/vector_utils.dart';
import 'package:vector_math/vector_math_64.dart';

/// ARKitGeometry is an abstract class that represents the geometry that can be attached to a SCNNode.
abstract class ARKitGeometry {
  ARKitGeometry(
    Vector3 position, {
    this.materials,
    Vector3 scale,
    Vector4 rotation,
    String name,
  })  : name = name ?? random_string.randomString(),
        position = ValueNotifier(position),
        scale = ValueNotifier(scale),
        rotation = ValueNotifier(rotation);

  /// Specifies the receiver's materials array.
  /// Each geometry element can be rendered using a different material.
  /// The index of the material used for a geometry element is equal to the index of that element modulo the number of materials.
  final List<ARKitMaterial> materials;

  /// Determines the receiver's position.
  final ValueNotifier<Vector3> position;

  /// Determines the receiver's scale.
  final ValueNotifier<Vector3> scale;

  /// Determines the receiver's rotation.
  /// The rotation is axis angle rotation.
  /// The three first components are the axis, the fourth one is the rotation (in radian).
  final ValueNotifier<Vector4> rotation;

  /// Determines the name of the receiver.
  /// Will be autogenerated if not defined.
  final String name;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'position': convertVector3ToMap(position.value),
        'scale': convertVector3ToMap(scale.value),
        'rotation': convertVector4ToMap(rotation.value),
        'name': name,
        'materials':
            materials != null ? materials.map((m) => m.toMap()).toList() : null,
      }..removeWhere((String k, dynamic v) => v == null);
}
