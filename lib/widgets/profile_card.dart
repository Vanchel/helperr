import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key key,
    this.name,
    this.description,
    this.backgroundUrl,
    this.avatarUrl,
    this.dateOfBirth,
    this.region,
    this.country,
  }) : super(key: key);

  final String name;
  final String description;
  final String backgroundUrl;
  final String avatarUrl;
  final String dateOfBirth;
  final String region;
  final String country;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    ImageProvider backgroundImage;
    try {
      // plug
      if (backgroundUrl == "") throw Exception();
      //
      backgroundImage = NetworkImage(backgroundUrl);
    } catch (_) {
      backgroundImage = const AssetImage('assets/background.png');
    }

    ImageProvider avatarImage;
    try {
      // plug
      if (avatarUrl == "") throw Exception();
      //
      avatarImage = NetworkImage(backgroundUrl);
    } catch (_) {
      avatarImage = const AssetImage('assets/avatar.jpg');
    }

    final Widget headWidget = Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: backgroundImage,
          fit: BoxFit.cover,
        ),
      ),
      child: CircleAvatar(
        radius: 40.0,
        backgroundImage: avatarImage,
      ),
    );

    Widget nameWidget;
    if (name != null) {
      nameWidget = Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(name, style: themeData.textTheme.headline6),
      );
    } else {
      nameWidget = const SizedBox.shrink();
    }

    Widget descriptionWidget;
    if (description != null) {
      descriptionWidget = Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          description,
          maxLines: 5,
          style: themeData.textTheme.caption,
        ),
      );
    } else {
      descriptionWidget = const SizedBox.shrink();
    }

    Widget birthdayWidget;
    if (dateOfBirth != null) {
      birthdayWidget = Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            const Icon(Icons.cake_rounded),
            Text(dateOfBirth),
          ],
        ),
      );
    } else {
      birthdayWidget = const SizedBox.shrink();
    }

    Widget locationWidget;
    if (region != null || country != null) {
      locationWidget = Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            const Icon(Icons.apartment_rounded),
            Text('${region ?? ""}'
                '${(region != null && country != null) ? ", " : ""}'
                '${country ?? ""}'),
          ],
        ),
      );
    } else {
      locationWidget = const SizedBox.shrink();
    }

    Widget editProfileButton = Container(
      margin: const EdgeInsets.all(8.0),
      width: double.infinity,
      child: OutlinedButton(
        child: Text('Редактировать профиль'),
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute<EditProfilePage>(builder: (context) {
          //     return BlocProvider.value(
          //       value: profileCubit,
          //       child: EditProfilePage(worker.userId),
          //     );
          //   }),
          // );
        },
      ),
    );

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headWidget,
          nameWidget,
          descriptionWidget,
          birthdayWidget,
          locationWidget,
          editProfileButton,
        ],
      ),
    );
  }
}
