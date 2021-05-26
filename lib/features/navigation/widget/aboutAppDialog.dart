import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppDialog extends StatefulWidget {
  AboutAppDialog({Key key}) : super(key: key);

  @override
  _AboutAppDialogState createState() => _AboutAppDialogState();
}

class _AboutAppDialogState extends State<AboutAppDialog> {
  Future<void> openLink(String urlString) async {
    if (await canLaunch(urlString)) {
      await launch(urlString);
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text('Не удалось найти подходящее приложение'),
        ));
    }
  }

  String getEmailUrl(String emailAddress, String subject) {
    final _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      queryParameters: {
        'subject': subject ?? '',
      },
    );
    return _emailLaunchUri.toString();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final infoPages = [
      ListTile(
        dense: true,
        title: Text('О проекте'),
        onTap: () async => await openLink('http://job-flow.ru/about_company'),
      ),
      ListTile(
        dense: true,
        title: Text('Официальный сайт'),
        onTap: () async => await openLink('http://job-flow.ru'),
      ),
      ListTile(
        dense: true,
        title: Text('Пользовательское соглашение'),
        onTap: () async => await openLink('http://job-flow.ru/oferta'),
      ),
      ListTile(
        dense: true,
        title: Text('Политика конфиденциальности'),
        onTap: () async => await openLink('http://job-flow.ru/personal_data'),
      ),
    ];

    final emailLinks = [
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'По вопросам работы приложения: ',
              style: themeData.textTheme.caption,
            ),
            TextSpan(
              text: '175940@edu.fa.ru',
              style: themeData.textTheme.caption
                  .copyWith(color: themeData.accentColor),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  await openLink(getEmailUrl(
                    '175940@edu.fa.ru',
                    'Вопрос по работе мобильного приложения Helperr',
                  ));
                },
            ),
          ],
        ),
      ),
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'По вопросам работы сайта: ',
              style: themeData.textTheme.caption,
            ),
            TextSpan(
              text: '175912@edu.fa.ru',
              style: themeData.textTheme.caption
                  .copyWith(color: themeData.accentColor),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  await openLink(getEmailUrl(
                    '175912@edu.fa.ru',
                    'Вопрос по работе сайта job-flow.ru',
                  ));
                },
            ),
          ],
        ),
      ),
    ];

    return AboutDialog(
      applicationIcon: ImageIcon(
        AssetImage('assets/logo-transparent-bg.png'),
      ),
      applicationLegalese: '© 2021 Helperr Все права защищены',
      children: [
        const Divider(),
        ...infoPages,
        const Divider(),
        Text(
          'Служба поддержки',
          style: themeData.textTheme.bodyText1,
        ),
        ...emailLinks,
      ],
    );
  }
}
