part of 'inventory_page.dart';

class _ShipInventory extends StatefulWidget {
  final InventoryViewModel viewModel;
  const _ShipInventory({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  State<_ShipInventory> createState() => _ShipInventoryState();
}

class _ShipInventoryState extends State<_ShipInventory> {
  double speed = 0, shield = 0, armor = 0, damage = 0;

  @override
  void initState() {
    getUserShipStatus();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _ShipInventory oldWidget) {
    getUserShipStatus();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            height: 280,
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DraggableItemBox(
                      item: widget.viewModel.inventoryItems[0],
                      viewModel: widget.viewModel,
                    ),
                    DraggableItemBox(
                      item: widget.viewModel.inventoryItems[1],
                      viewModel: widget.viewModel,
                    ),
                    DraggableItemBox(
                      item: widget.viewModel.inventoryItems[2],
                      viewModel: widget.viewModel,
                    ),
                  ],
                ),
                Expanded(
                  child: _ShipView(
                    viewModel: widget.viewModel,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DraggableItemBox(
                      item: widget.viewModel.inventoryItems[3],
                      viewModel: widget.viewModel,
                    ),
                    DraggableItemBox(
                      item: widget.viewModel.inventoryItems[4],
                      viewModel: widget.viewModel,
                      isLocked: true,
                    ),
                    DraggableItemBox(
                      item: widget.viewModel.inventoryItems[5],
                      viewModel: widget.viewModel,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Armor',
                      style: AppTheme().paragraphRegularText.apply(
                            color: Colors.white,
                          ),
                    ),
                    Text(
                      '$armor',
                      style: AppTheme().paragraphRegularText.apply(
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Shield',
                      style: AppTheme().paragraphRegularText.apply(
                            color: Colors.white,
                          ),
                    ),
                    Text(
                      '$shield',
                      style: AppTheme().paragraphRegularText.apply(
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Speed',
                      style: AppTheme().paragraphRegularText.apply(
                            color: Colors.white,
                          ),
                    ),
                    Text(
                      '$speed',
                      style: AppTheme().paragraphRegularText.apply(
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Damage',
                      style: AppTheme().paragraphRegularText.apply(
                            color: Colors.white,
                          ),
                    ),
                    Text(
                      '$damage',
                      style: AppTheme().paragraphRegularText.apply(
                            color: Colors.white,
                          ),
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

  Future<void> getUserShipStatus() async {
    speed = 0;
    shield = 0;
    armor = 0;
    damage = 0;
    final equippedItems = widget.viewModel.inventoryItems
        .map((e) => e.inventoryItem)
        .where((element) => element?.isEquipped == true)
        .toList();
    final equippedShips = widget.viewModel.ships
        .where((element) => element.isEquipped == true)
        .toList();
    equippedItems.addAll(equippedShips);
    log('Eqipped items: $equippedItems');
    for (InventoryItem? inventoryItem in equippedItems) {
      if (inventoryItem!.item!.isShip) {
        armor += inventoryItem.item!.ship!.armor!;
        shield += inventoryItem.item!.ship!.shield!;
        speed += inventoryItem.item!.ship!.speed!;
      } else if (inventoryItem.item!.isWeapon) {
        damage += inventoryItem.item!.weapon!.damage!;
      } else if (inventoryItem.item!.isEnergyGenerator) {
        speed += inventoryItem.item!.energyGenerator!.shipSpeed!;
      } else if (inventoryItem.item!.isShieldGenerator) {
        shield += inventoryItem.item!.shieldGenerator!.shieldAmount!;
      }
    }
  }
}
