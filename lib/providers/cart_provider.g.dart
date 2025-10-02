// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_provider.dart';

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

String _$cartProductsHash() => r'463881368b1a35f1074f6dd37365e5507e294b62';

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

String _$totalCartPriceHash() => r'36dd9d5b1da466d8e2a167a5a317cd3f62b37782';

@ProviderFor(numberCartItems)
const numberCartItemsProvider = NumberCartItemsProvider._();

final class NumberCartItemsProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  const NumberCartItemsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'numberCartItemsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$numberCartItemsHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return numberCartItems(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$numberCartItemsHash() => r'7c0c698ee037f2a26fc90ec7837268a931387cd7';
