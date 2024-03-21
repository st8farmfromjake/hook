import 'dart:developer';
import 'dart:math' hide log;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';


sendEmail({
  int? emailNum, 
  required String emailAdd, 
  required String name, 
  required String fromName, 
  required String companyName, 
  link = 'https://link.novusomni.com/hook'
  }) async {
    // If emailNum is null, generate a random number within the range of email cases
    emailNum = Random().nextInt(8); 
    log('$emailNum');

    String html;
    String subject;

    //Switch statement to select the email template
    switch (emailNum) {
      case 0: html = '''
        <p>Hello $name</p>
        <p>We are demanding that you give us all of your company's information, because if you don’t then we will leak some very sensitive information about you and your bosses. Please go to <a href="$link">this website</a> and follow ALL instructions carefully and promptly. If we don’t get this information within 24 hours everything will be leaked.</p>
        <p>Best Wishes,</p>
        <p>$fromName</p>
        ''';
        subject = "We have your information!"; 
        break;
      case 1:html = '''
        <p>$name,</p>
        <p>I have recently obtained sensitive information that could potentially damage your reputation and career. This information is of a confidential nature and was not intended to be shared with anyone outside of its original circle. I am giving you the opportunity to prevent this information from being made public by adhering to my demands.</p>
        <p>Complete silence and immediate action are expected. Any attempt to contact me or negotiate the terms of this agreement will be met with the swift dissemination of the aforementioned information. I will be monitoring your actions closely to ensure compliance. Failure to meet my demands will result in the release of this information to the public and relevant authorities.</p>
        <p>I will provide you with further instructions on how to proceed. In the meantime, I advise you to follow up through the following <a href="$link">link</a>. This is your only warning.</p>
        <p>Your response will be checked within the next 24 hours. If I do not receive a satisfactory reply, the countdown to public exposure will begin. Do not underestimate the severity of the situation. Act now to protect your interests.</p>
        '''; 
        subject = "Response Needed";
        break;
      case 2: html = '''
        <p>Hello $name</p>
        <p>This is the IT department at $companyName.There is an update needed on your computer. </p>
        <p>Please go to <a href="$link">this website</a>, so we can control your computer and help you download this update.</p>
        <p>Thank you,</p>
        <p>IT Department</p>
        '''; 
        subject = "Updated Needed";
        break;
      case 3: html = '''
        <p>Hello team,</p>
        <p>I hope this message finds you well.</p>
        <p>I'm currently facing an unexpected issue that requires some assistance.</p>
        <p>Due to unforeseen circumstances, I'm unable to access my work computer and need someone to help me with a few critical tasks.</p>
        <p> I understand that this is short notice, but I'm confident that together we can resolve this quickly and efficiently.</p>
        <p>I've attached a list of the files that need to be shared, along with the intended recipients. If you could kindly forward the files to the respective individuals and copy me on the emails, I would greatly appreciate it. This will ensure that the project remains on track and we can minimize any potential delays.</p>
        <p>I understand that this is an unconventional request, but I'm in a bind and trust that the team will understand the urgency.</p>
        <p>If you have any questions or concerns, please don't hesitate to reach out,</p>
        <p>Chuck</p>
        <p><a href="$link">Needed files.</a></p>
        '''; 
        subject = "Help Needed";
        break;
      case 4: html = '''
        <p>Good afternoon $name,</p>
        <p>We at $companyName want to hear from you, our employees! <a href="$link">Click here</a> to fill out a 5 minute survey about your quality of life here.</p>
        <p>Thank you,</p>
        <p>HR team</p>
        '''; 
        subject = "$companyName Survey";
        break;
      case 5: html = '''
        <p>Dear $name,</p>
        <p>We have recently detected suspicious activity on your account. To ensure the security of your information, we kindly ask you to confirm your personal details by clicking the link below and <a href="$link">logging into your account.</a></p>
        <p>Upon reviewing your account, we found that the email address associated with your account needs to be verified. This is a standard security measure to protect your account from unauthorized access.</p>
        <p>We appreciate your prompt attention to this matter. Your security is our top priority, and by updating your account information, you help us maintain the integrity of our system.</p>
        '''; 
        subject = "Suspicious Activty Detected";
        break;
      case 6: html = '''
        <p>Hello $name,</p>
        <p>Congratulations! You've entered and won a company wide raffle! Click <a href="$link">this link</a> to claim your 2 day cruise through the Bahamas!</p>
        <p>Congratulations,</p>
        <p>$name</p>
        '''; 
        subject = "Congratulations!";
        break;
      case 7: html = '''
        <p>Dear $name, </p>
        <p>We hope this message finds you well. As part of our ongoing efforts to enhance the tools at your disposal, the IT department has recently deployed a new software package that will streamline your workflow. This software update is mandatory for all employees to ensure compatibility with our internal systems and to take advantage of the latest features and security enhancements.</p>
        <p>To facilitate a smooth transition, please follow the steps below to download and install the new software on your workstation. If you encounter any issues during the installation process, please do not hesitate to contact the IT helpdesk.</p>
        <p>1. Navigate to <a href="$link">this website</a>. This is the secure company portal where you can download the latest version of the software. Ensure that you are accessing the website from a secure and company-approved device.</p>
        <p>2. Once you are on the software download page, click the 'Download' button to initiate the installation file. The file size is approximately 500MB, so please allow some time for the download to complete.</p>
        <p>3. After the download is complete, run the installation file by double-clicking on it. Follow the on-screen instructions to complete the installation. If you are prompted for any permissions or to enter your login credentials, please provide the necessary information to proceed.</p>
        <p>4. Once the installation is finished, restart your computer to ensure that the new software is fully integrated. You will be prompted to log back in with your username and password. If you have any issues with the software after installation, please report them to the IT helpdesk.</p>
        <p>Thank you for your prompt attention to this matter. We are confident that the new software will greatly improve your work experience and contribute to the success of our team. If you have any feedback or suggestions, please share them with us.</p>
        '''; 
        subject = "New Software";
        break;
      default: html = '''
      <p>Hello $name</p>
      <p>We are demanding that you give us all of your company's information, because if you don’t then we will leak some very sensitive information about you and your bosses. Please go to <a href="$link">this website</a> and follow ALL instructions carefully and promptly. If we don’t get this information within 24 hours everything will be leaked.</p>
      <p>Best Wishes,</p>
      <p>$fromName</p>
      ''';
      subject = "We have your information!";
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
    ..from = Address(username, fromName)
    ..recipients.add(emailAdd)
    // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    // ..bccRecipients.add(Address('bccAddress@example.com'))
    ..subject = subject
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