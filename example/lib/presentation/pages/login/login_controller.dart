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

import 'package:domain/domain.dart';
import 'package:example/presentation/pages/authentication/authentication_arguments.dart';
import 'package:example/presentation/router/app_routes.dart';
import 'package:example/presentation/utils/extensions/url_extension.dart';
import 'package:example/presentation/utils/logger/app_toast.dart';
import 'package:get/get.dart';

enum LoginState {
  IDLE,
  LOADING,
  SUCCESS,
  FAILURE
}

class LoginController extends GetxController {

  final CreatePermanentTokenInteractor _getPermanentTokenInteractor;
  final appToast = Get.find<AppToast>();

  String _urlText = '';
  String _emailText = '';
  String _passwordText = '';

  var loginState = LoginState.IDLE.obs;

  LoginController(
    this._getPermanentTokenInteractor,
  );

  void setUrlText(String url) => _urlText = url.formatURLValid();

  void setEmailText(String email) => _emailText = email;

  void setPasswordText(String password) => _passwordText = password;

  Uri _parseUri(String url) => Uri.parse(url);

  UserName _parseUserName(String userName) => UserName(userName);

  Password _parsePassword(String password) => Password(password);

  void handleLoginPressed() {
    _loginAction(_parseUri(_urlText), _parseUserName(_emailText), _parsePassword(_passwordText));
  }

  void _loginAction(Uri baseUrl, UserName userName, Password password) async {
    loginState(LoginState.LOADING);
    await _getPermanentTokenInteractor.execute(baseUrl, userName, password)
      .then((result) => result.fold(
        (failure) => _loginFailureAction(failure),
        (success) => _loginSuccessAction(success)));
  }

  void _loginSuccessAction(CreatePermanentTokenSuccess success) {
    loginState(LoginState.SUCCESS);
    Get.offNamed(AppRoutes.AUTHENTICATION, arguments: AuthenticationArguments(_parseUri(_urlText)));
  }

  void _loginFailureAction(CreatePermanentTokenFailure failure) async {
    loginState(LoginState.FAILURE);
    appToast.showErrorToast(failure.toString());
  }
}