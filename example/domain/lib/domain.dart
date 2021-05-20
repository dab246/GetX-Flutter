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

library domain;

// extension
export 'package:domain/extension/token_extension.dart';

// model
export 'package:domain/model/password.dart';
export 'package:domain/model/user_name.dart';
export 'package:domain/model/authentication/token_id.dart';
export 'package:domain/model/authentication/token.dart';
export 'package:domain/model/user/user_id.dart';
export 'package:domain/model/user/user.dart';
export 'package:domain/model/account/account_id.dart';
export 'package:domain/model/account/account_type.dart';
export 'package:domain/model/account/account.dart';
export 'package:domain/model/quota/quota_id.dart';
export 'package:domain/model/quota/quota_size.dart';
export 'package:domain/model/quota/account_quota.dart';

// repository
export 'package:domain/repository/authentication/authentication_repository.dart';
export 'package:domain/repository/authentication/credential_repository.dart';
export 'package:domain/repository/authentication/token_repository.dart';

// interactor
export 'package:domain/usecases/authentication/create_permanent_token_interactor.dart';
export 'package:domain/usecases/authentication/get_authorized_interactor.dart';
export 'package:domain/usecases/authentication/delete_permanent_token_interactor.dart';

// network
export 'package:domain/network/service_path.dart';

// exception
export 'package:domain/exception/remote_exception.dart';
export 'package:domain/exception/user_exception.dart';

// state
export 'package:domain/state/success.dart';
export 'package:domain/state/failure.dart';
export 'package:domain/state/create_permanent_token_state.dart';
export 'package:domain/state/get_authorized_state.dart';
export 'package:domain/state/delete_permanent_token_state.dart';