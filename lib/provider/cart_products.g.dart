// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_products.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CartProducts)
const cartProductsProvider = CartProductsProvider._();

final class CartProductsProvider
    extends $NotifierProvider<CartProducts, Set<Product>> {
  const CartProductsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartProductsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartProductsHash();

  @$internal
  @override
  CartProducts create() => CartProducts();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<Product> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<Product>>(value),
    );
  }
}

String _$cartProductsHash() => r'c6ec146e99623b2f0fbc17d71343ebb61c5ad329';

abstract class _$CartProducts extends $Notifier<Set<Product>> {
  Set<Product> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Set<Product>, Set<Product>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<Product>, Set<Product>>,
              Set<Product>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(totalCartPrice)
const totalCartPriceProvider = TotalCartPriceProvider._();

final class TotalCartPriceProvider
    extends $FunctionalProvider<double, double, double>
    with $Provider<double> {
  const TotalCartPriceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'totalCartPriceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$totalCartPriceHash();

  @$internal
  @override
  $ProviderElement<double> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  double create(Ref ref) {
    return totalCartPrice(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(double value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<double>(value),
    );
  }
}

String _$totalCartPriceHash() => r'06e470cd305eafc2caf7e2ad4a2d5f671b0216e7';
