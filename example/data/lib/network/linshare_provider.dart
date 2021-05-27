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

import 'dart:convert';
import 'dart:io';

import 'package:data/data.dart';
import 'package:get/get.dart';

class LinShareProvider extends GetConnect {

  var _jSessionId = '';

  @override
  void onInit() {
    httpClient.addRequestModifier((request) {
      request.headers[HttpHeaders.cookieHeader] = '${Constant.jSessionId}=$_jSessionId';
      return request;
    });

    httpClient.addResponseModifier((request, response) {
      _extractSessionIdFromHeader(response.headers);
      return response;
    });
  }

  void _extractSessionIdFromHeader(Map<String, String> headers) {
    final cookieHeader = headers[HttpHeaders.setCookieHeader];
    if (cookieHeader != null) {
      cookieHeader.split(';')
          .map((element) => element.contains(Constant.jSessionId) ? element : null)
          .map((validElement) => validElement.substring(Constant.jSessionId.length + 1))
          .map((jSessionId) => _jSessionId = jSessionId);
    }
  }

  Future<PermanentToken> createPermanentToken(
      Uri authenticateUrl,
      String userName,
      String password,
      PermanentTokenBodyRequest bodyRequest) async {
    final basicAuth = 'Basic ' + base64Encode(utf8.encode('$userName:$password'));

    final resultJson = await post(
        Endpoint.authentication.generateAuthenticationUrl(authenticateUrl),
        bodyRequest.toJson(),
        headers: {
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: basicAuth
        });

    if (resultJson.status.hasError) {
      return Future.error(resultJson.status);
    } else {
      return PermanentToken.fromJson(resultJson.body);
    }
  }

  Future<bool> deletePermanentToken(PermanentToken token) async {
    final deletedToken = await delete(
      Endpoint.authentication.withPathParameter(token.tokenId.uuid).generateEndpointPath());

    if (deletedToken.status.hasError) {
      return Future.error(deletedToken.status);
    } else {
      return deletedToken.body;
    }
  }

  Future<UserResponse> getAuthorizedUser() async {
    final resultJson = await get(Endpoint.authorizedUser.generateEndpointPath());
    if (resultJson.status.hasError) {
      return Future.error(resultJson.status);
    } else {
      return UserResponse.fromJson(resultJson.body);
    }
  }
}