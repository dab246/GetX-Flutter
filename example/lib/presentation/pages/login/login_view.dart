// LinShare is an open source filesharing software, part of the LinPKI software
// suite, developed by Linagora.
//
// Copyright (C) 2020 LINAGORA
//
// This program is free software: you can redistribute it and/or modify it under the
// terms of the GNU Affero General Public License as published by the Free Software
// Foundation, either version 3 of the License, or (at your option) any later version,
// provided you comply with the Additional Terms applicable for LinShare software by
// Linagora pursuant to Section 7 of the GNU Affero General Public License,
// subsections (b), (c), and (e), pursuant to which you must notably (i) retain the
// display in the interface of the “LinShare™” trademark/logo, the "Libre & Free" mention,
// the words “You are using the Free and Open Source version of LinShare™, powered by
// Linagora © 2009–2020. Contribute to Linshare R&D by subscribing to an Enterprise
// offer!”. You must also retain the latter notice in all asynchronous messages such as
// e-mails sent with the Program, (ii) retain all hypertext links between LinShare and
// http://www.linshare.org, between linagora.com and Linagora, and (iii) refrain from
// infringing Linagora intellectual property rights over its trademarks and commercial
// brands. Other Additional Terms apply, see
// <http://www.linshare.org/licenses/LinShare-License_AfferoGPL-v3.pdf>
// for more details.
// This program is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
// more details.
// You should have received a copy of the GNU Affero General Public License and its
// applicable Additional Terms for LinShare along with this program. If not, see
// <http://www.gnu.org/licenses/> for the GNU Affero General Public License version
//  3 and <http://www.linshare.org/licenses/LinShare-License_AfferoGPL-v3.pdf> for
//  the Additional Terms applicable to LinShare software.

import 'package:example/presentation/pages/login/login_controller.dart';
import 'package:example/presentation/utils/assets/app_image_paths.dart';
import 'package:example/presentation/utils/extensions/color_extension.dart';
import 'package:example/presentation/widgets/text/input_decoration_builder.dart';
import 'package:example/presentation/widgets/text/login_text_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {

  final imagePath = Get.find<AppImagePaths>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: AppColor.primaryColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                reverse: true,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 100),
                    child: Column(
                      key: Key('login_logo_header'),
                      children: [
                        Image(
                            image: AssetImage(imagePath.icLoginLogo),
                            alignment: Alignment.center),
                        Padding(
                          padding:
                          EdgeInsets.only(top: 16, left: 16, right: 16),
                          child: Text(
                            '',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 80),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: LoginTextBuilder()
                                .key(Key('login_url_input'))
                                .onChange((value) => controller.setUrlText(value))
                                .textInputAction(TextInputAction.next)
                                .textDecoration(_buildUrlInputDecoration())
                                .build()
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: LoginTextBuilder()
                                .key(Key('login_email_input'))
                                .onChange((value) => controller.setEmailText(value))
                                .textInputAction(TextInputAction.next)
                                .textDecoration(_buildCredentialInputDecoration('email', 'email'))
                                .build()
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: LoginTextBuilder()
                                .key(Key('login_password_input'))
                                .obscureText(true)
                                .onChange((value) => controller.setPasswordText(value))
                                .textInputAction(TextInputAction.done)
                                .textDecoration(_buildCredentialInputDecoration('password', 'password'))
                                .build()
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 67),
                          child: Obx(() => controller.loginState.value == LoginState.LOADING
                            ? loadingCircularProgress()
                            : loginButton(context))
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _buildUrlInputDecoration() {
    final loginInputDecorationBuilder = LoginInputDecorationBuilder()
      .labelText('https://')
      .prefixText('https://');
    return loginInputDecorationBuilder.build();
  }

  InputDecoration _buildCredentialInputDecoration(String labelText, String hintText) {
    final loginInputDecorationBuilder = LoginInputDecorationBuilder().labelText(labelText).hintText(hintText);
    return loginInputDecorationBuilder.build();
  }

  Widget loadingCircularProgress() {
    return SizedBox(
      key: Key('login_loading_icon'),
      width: 40,
      height: 40,
      child: CircularProgressIndicator(backgroundColor: Colors.white,),
    );
  }

  Widget loginButton(BuildContext context) {
    return SizedBox(
      key: Key('login_confirm_button'),
      width: double.infinity,
      height: 48,
      child: RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80),
          side: BorderSide(width: 0, color: AppColor.loginButtonColor),
        ),
        onPressed: () {
          FocusScope.of(context).unfocus();
          controller.handleLoginPressed();
        },
        color: AppColor.loginButtonColor,
        textColor: Colors.white,
        child: Text('Login', style: TextStyle(fontSize: 16, color: Colors.white)),
      ),
    );
  }
}