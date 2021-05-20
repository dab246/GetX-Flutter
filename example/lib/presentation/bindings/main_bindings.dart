// LinShare is an open source filesharing software, part of the LinPKI software
// suite, developed by Linagora.
//
// Copyright (C) 2020 LINAGORA
//
// This program is free software: you can redistribute it and/or modify it under the
// terms of the GNU Affero General Public License as published by the Free Software
// Foundation, either version 3 of the License, or (at your option) any later version,
// bindingsd you comply with the Additional Terms applicable for LinShare software by
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

import 'package:data/data.dart';
import 'package:data/utils/device_manager.dart';
import 'package:device_info/device_info.dart';
import 'package:domain/domain.dart';
import 'package:example/presentation/utils/assets/app_image_paths.dart';
import 'package:example/presentation/utils/logger/app_toast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainBindings extends Bindings {

  @override
  void dependencies() {
    _bindingsAppToast();
    _bindingsProvider();
    _bindingsRemoteExceptionThrower();
    _bindingsAppImagePaths();
    _bindingsDeviceManager();
    _bindingsSharePreference();
    _bindingsDataSourceImpl();
    _bindingsDataSource();
    _bindingsRepositoryImpl();
    _bindingsRepository();
    _bindingsInteractor();
  }

  void _bindingsAppToast() {
    Get.put(AppToast());
  }

  void _bindingsRemoteExceptionThrower() {
    Get.lazyPut(() => RemoteExceptionThrower());
  }

  void _bindingsProvider() {
    Get.lazyPut(() => LinShareProvider());
  }

  void _bindingsAppImagePaths() {
    Get.put(AppImagePaths());
  }

  void _bindingsDeviceManager() {
    Get.lazyPut(() => DeviceInfoPlugin());
    Get.lazyPut(() => DeviceManager(Get.find<DeviceInfoPlugin>()));
  }

  void _bindingsSharePreference() {
    Get.putAsync(() => SharedPreferences.getInstance());
  }

  void _bindingsDataSource() {
    Get.lazyPut<AuthenticationDataSource>(() => Get.find<AuthenticationDataSourceImpl>());
  }

  void _bindingsDataSourceImpl() {
    Get.lazyPut(() => AuthenticationDataSourceImpl(
        Get.find<LinShareProvider>(),
        Get.find<DeviceManager>(),
        Get.find<RemoteExceptionThrower>()));
  }

  void _bindingsRepository() {
    Get.lazyPut<TokenRepository>(() => Get.find<TokenRepositoryImpl>());
    Get.lazyPut<CredentialRepository>(() => Get.find<CredentialRepositoryImpl>());
    Get.lazyPut<AuthenticationRepository>(() => Get.find<AuthenticationRepositoryImpl>());
  }

  void _bindingsRepositoryImpl() {
    Get.lazyPut(() => TokenRepositoryImpl(Get.find<SharedPreferences>()));
    Get.lazyPut(() => CredentialRepositoryImpl(Get.find<SharedPreferences>()));
    Get.lazyPut(() => AuthenticationRepositoryImpl(Get.find<AuthenticationDataSource>()));
  }

  void _bindingsInteractor() {
    Get.lazyPut(() => CreatePermanentTokenInteractor(
        Get.find<AuthenticationRepository>(),
        Get.find<TokenRepository>(),
        Get.find<CredentialRepository>(),
    ));
    Get.lazyPut(() => GetAuthorizedInteractor(
      Get.find<AuthenticationRepository>(),
    ));
    Get.lazyPut(() => DeletePermanentTokenInteractor(
      Get.find<AuthenticationRepository>(),
      Get.find<TokenRepository>(),
      Get.find<CredentialRepository>(),
    ));
  }
}