part of 'inventory_page.dart';

class ShipChangeView extends StatefulWidget {
  final InventoryViewModel viewModel;
  const ShipChangeView({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  State<ShipChangeView> createState() => _ShipChangeViewState();
}

class _ShipChangeViewState extends State<ShipChangeView> {
  late InventoryItem _selectedShip, _currentShip;
  late ValueNotifier<double?> dotPosition;
  late final CarouselController carouselController;
  @override
  void initState() {
    _selectedShip =
        widget.viewModel.ships.firstWhere((element) => element.isEquipped!);
    _currentShip = widget.viewModel.ships.first;
    carouselController = CarouselController();
    dotPosition = ValueNotifier(0.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.30),
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            width: 1.sw,
            height: 1.sh,
            color: Colors.transparent,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  //
                },
                child: Container(
                  width: 1.sw,
                  height: 0.50.sh,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          child: CarouselSlider.builder(
                            options: CarouselOptions(
                              autoPlay: false,
                              initialPage: 0,
                              scrollPhysics: AlwaysScrollableScrollPhysics(),
                              enableInfiniteScroll: false,
                              enlargeCenterPage: false,
                              viewportFraction: 1,
                              onScrolled: (value) {
                                dotPosition.value = value;
                              },
                              onPageChanged: (value, reason) {
                                _currentShip = widget.viewModel.ships[value];
                                log('Current ship: ${_currentShip.item?.name}');
                              },
                            ),
                            carouselController: carouselController,
                            itemCount: widget.viewModel.ships.length,
                            itemBuilder: (BuildContext context, int itemIndex,
                                    int pageViewIndex) =>
                                Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Text(
                                      widget.viewModel.ships[itemIndex].item!
                                          .name!,
                                      style: AppTheme()
                                          .paragraphSemiBoldText
                                          .copyWith(
                                            color: AppTheme().greyScale5,
                                          )),
                                ),
                                Expanded(
                                  child: Hero(
                                    tag:
                                        '${widget.viewModel.ships[itemIndex].item!.name}',
                                    transitionOnUserGestures: false,
                                    child: Image.asset(
                                      widget.viewModel.ships[itemIndex].item!
                                          .imageUrl!.appImage,
                                      width: 1.sw,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ValueListenableBuilder<double?>(
                        valueListenable: dotPosition,
                        builder: (context, dotpos, child) {
                          return DotsIndicator(
                            dotsCount: widget.viewModel.ships.length,
                            position: dotpos ?? 0,
                            decorator: DotsDecorator(
                              color: AppTheme().greyScale0,
                              activeColor: AppTheme().greyScale5,
                            ),
                          );
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 10),
                        child: ThemeButton(
                          height: 45,
                          onTap: () async {
                            log('Current ship: ${_currentShip.item?.name}');
                            if (_currentShip == _selectedShip) {
                              Get.back();
                              return;
                            } else {
                              log('Selected ship: ${_selectedShip.item?.name}');
                              LockOverlay().showClassicLoadingOverlay();
                              await widget.viewModel.equipItem(
                                _currentShip,
                                unEquipItem: _selectedShip,
                              );
                              LockOverlay().closeOverlay();
                            }

                            _selectedShip.isEquipped = false;
                            _currentShip.isEquipped = true;
                            widget.viewModel.notifyListeners();
                            Get.back();
                          },
                          text: 'Change Ship',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
