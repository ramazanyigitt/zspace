part of 'inventory_page.dart';

class _PlayerInventory extends StatelessWidget {
  final InventoryViewModel viewModel;
  const _PlayerInventory({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        itemCount: viewModel.inventoryItems.length - 6,
        itemBuilder: (context, index) {
          final item = viewModel.inventoryItems[index + 6];
          item.index = index + 6;
          return DraggableItemBox(
            item: item,
            viewModel: viewModel,
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 20,
          crossAxisSpacing: 15,
        ),
      ),
    );
  }
}
