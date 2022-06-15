part of 'inventory_page.dart';

class _ShipInventory extends StatelessWidget {
  final InventoryViewModel viewModel;
  const _ShipInventory({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            height: 350,
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DraggableItemBox(
                      item: viewModel.inventoryItems[0],
                      viewModel: viewModel,
                    ),
                    DraggableItemBox(
                      item: viewModel.inventoryItems[1],
                      viewModel: viewModel,
                    ),
                    DraggableItemBox(
                      item: viewModel.inventoryItems[2],
                      viewModel: viewModel,
                    ),
                  ],
                ),
                Expanded(
                  child: _ShipView(
                    viewModel: viewModel,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DraggableItemBox(
                      item: viewModel.inventoryItems[3],
                      viewModel: viewModel,
                    ),
                    DraggableItemBox(
                      item: viewModel.inventoryItems[4],
                      viewModel: viewModel,
                      isLocked: true,
                    ),
                    DraggableItemBox(
                      item: viewModel.inventoryItems[5],
                      viewModel: viewModel,
                      isLocked: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: 20,
              top: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inventory,
                  size: 32,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text(
                  'Inventory',
                  style: AppTheme().paragraphRegularText.apply(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
