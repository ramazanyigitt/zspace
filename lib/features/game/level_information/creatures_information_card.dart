part of 'level_information_page.dart';

class _CreaturesInformationCard extends StatelessWidget {
  final LevelModel level;
  const _CreaturesInformationCard({
    Key? key,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 0,
      ),
      child: GridView.builder(
        itemCount: level.spawnModels?.length ?? 0,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 1,
          mainAxisSpacing: 15,
        ),
        itemBuilder: (context, index) {
          return Container(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 96,
                  height: 96,
                  child: Image.asset(
                    level.spawnModels![index].type!.getCreatureImage.appImage,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '${level.spawnModels![index].type!.name}',
                  style: AppTheme().paragraphSemiBoldText.copyWith(
                        color: AppTheme().greyScale5,
                      ),
                ),
              ],
            ),
          );
        },
      ),
      /*Text(
        '${level.spawnModels}',
        style: AppTheme().largeParagraphBoldText.copyWith(
              color: AppTheme().greyScale5,
            ),
      ),*/
    );
  }
}
