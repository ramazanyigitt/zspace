part of 'inventory_page.dart';

class _PlayerInventory extends StatelessWidget {
  final InventoryViewModel viewModel;
  const _PlayerInventory({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final item = viewModel.inventoryItems[index + 6];
            item.index = index + 6;
            return DraggableItemBox(
              item: item,
              viewModel: viewModel,
            );
          },
          childCount: viewModel.inventoryItems.length - 6,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 20,
          crossAxisSpacing: 15,
        ),
      ),
    );
  }
}
