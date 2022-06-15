part of 'inventory_page.dart';

class _ShipView extends StatelessWidget {
  final InventoryViewModel viewModel;
  const _ShipView({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: 150,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Image.asset(
              viewModel.ships
                  .firstWhere((element) => element.isEquipped!)
                  .item!
                  .imageUrl!
                  .appImage,
              fit: BoxFit.contain,
            ),
            ThemeButton(
              height: 45,
              color: AppTheme().primaryColor,
              onTap: () {
                Get.to(
                  () => ShipChangeView(viewModel: viewModel),
                  duration: Duration.zero,
                  transition: Transition.fadeIn,
                  opaque: false,
                );
              },
              text: 'My ships',
            ),
          ],
        ),
      ),
    );
  }
}
