import 'dart:developer';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<String> loadHtmlContent(String email) async {
  String htmlContent = await rootBundle.loadString(email);
  
  // Now you have the HTML content in the 'htmlContent' variable
  return htmlContent;
}

sendEmail({int? emailNum, String? emailAdd = 'wolly0305@icloud.com', String? name = 'Mufasa', String? fromName = 'Your mom', String? companyName = 'Hook'}) async {
  String html;
  switch (emailNum) {
  case 0: html = '''
  <p>Hello $name</p>
  <p>We are demanding that you give us all of your company's information, because if you don’t then we will leak some very sensitive information about you and your bosses. Please go to <a href="https://novusomni.com/hook/">this website</a> and follow ALL instructions carefully and promptly. If we don’t get this information within 24 hours everything will be leaked.</p>
  <p>Best Wishes,</p>
  <p>$fromName</p>
  '''; break;
  case 1:html = '''
  <p>$name</p>
  <p>I have recently obtained sensitive information that could potentially damage your reputation and career. This information is of a confidential nature and was not intended to be shared with anyone outside of its original circle. I am giving you the opportunity to prevent this information from being made public by adhering to my demands.</p>
  <p>Complete silence and immediate action are expected. Any attempt to contact me or negotiate the terms of this agreement will be met with the swift dissemination of the aforementioned information. I will be monitoring your actions closely to ensure compliance. Failure to meet my demands will result in the release of this information to the public and relevant authorities.</p>
  <p>I will provide you with further instructions on how to proceed. In the meantime, I advise you to follow up through the following <a href="https://novusomni.com/hook/">link</a>. This is your only warning.</p>
  <p>Your response will be checked within the next 24 hours. If I do not receive a satisfactory reply, the countdown to public exposure will begin. Do not underestimate the severity of the situation. Act now to protect your interests.</p>
  '''; break;
  // additional cases as needed
  default: html = '''
  <p>Good afternoon $name,</p>
  <p>We at $companyName want to hear from you, our employees! <a href="https://novusomni.com/hook/">Click here</a> to fill out a 5 minute survey about your quality of life here.</p>
  <p>Thank you,</p>
  <p>HR team</p>
  ''';
    // code block to execute if expression does not match any case
}

  // Note that using a username and password for gmail only works if
  // you have two-factor authentication enabled and created an App password.
  // Search for "gmail app password 2fa"
  // The alternative is to use oauth.
  String username = 'novusomni@gmail.com';
  String password = 'qulobpzqizfroblh';

  final smtpServer = gmail(username, password);
  // Use the SmtpServer class to configure an SMTP server:
  // final smtpServer = SmtpServer('smtp.domain.com');
  // See the named arguments of SmtpServer for further configuration
  // options.  
  // Read HTML content from file
  // final String htmlContent = await loadHtmlContent('assets/emails/blackmail_1.html');

  // Create our message.
  final message = Message()
    ..from = Address(username, 'Your Boss')
    ..recipients.add(emailAdd)
    // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    // ..bccRecipients.add(Address('bccAddress@example.com'))
    ..subject = 'Watch Out!!'
    // ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = html;

  try {
    final sendReport = await send(message, smtpServer);
    log('Message sent: ${sendReport.toString()}');
  } on MailerException catch (e) {
    log('Message not sent.');
    for (var p in e.problems) {
      log('Problem: ${p.code}: ${p.msg}');
    }
  }
  // DONE


  // Let's send another message using a slightly different syntax:
  //
  // Addresses without a name part can be set directly.
  // For instance `..recipients.add('destination@example.com')`
  // If you want to display a name part you have to create an
  // Address object: `new Address('destination@example.com', 'Display name part')`
  // Creating and adding an Address object without a name part
  // `new Address('destination@example.com')` is equivalent to
  // adding the mail address as `String`.
  // final equivalentMessage = Message()
  //   ..from = Address(username, 'Your name 😀')
  //   ..recipients.add(Address('destination@example.com'))
  //   ..ccRecipients.addAll([Address('destCc1@example.com'), 'destCc2@example.com'])
  //   ..bccRecipients.add('bccAddress@example.com')
  //   ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
  //   ..text = 'This is the plain text.\nThis is line 2 of the text part.'
  //   ..html = '<h1>Test</h1>\n<p>Hey! Here is some HTML content</p><img src="cid:myimg@3.141"/>';

  // final sendReport2 = await send(equivalentMessage, smtpServer);

  // Sending multiple messages with the same connection
  //
  // Create a smtp client that will persist the connection
  var connection = PersistentConnection(smtpServer);

  // // Send the first message
  // await connection.send(message);

  // send the equivalent message
  // await connection.send(equivalentMessage);

  // close the connection
  await connection.close();
}