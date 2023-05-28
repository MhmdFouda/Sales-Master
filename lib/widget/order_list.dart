import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/providers/order_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderList extends ConsumerWidget {
  const OrderList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(asyncOrderProviderProvider);
    return orders.when(data: (data) {
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index].clientName),
            subtitle: Text(data[index].totalPrice.toString()),
          );
        },
      );
    }, error: (error, stackTrace) {
      return Center(
        child: Text(
          'Fouda Pharma',
          style: GoogleFonts.lora(
              textStyle: Theme.of(context).textTheme.headlineLarge,
              fontSize: 80),
        ),
      );
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
