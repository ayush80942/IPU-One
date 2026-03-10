import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipu_one/app.dart';
import 'package:ipu_one/core/network/dio_client.dart';
import 'package:ipu_one/core/storage/secure_storage_service.dart';
import 'package:ipu_one/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:ipu_one/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:ipu_one/features/profile/data/profile_repository.dart';

import 'features/auth/data/domain/repositories/auth_repository_impl.dart';
import 'features/profile/presentation/cubit/profile_cubit.dart';

void main() {
  final dio = DioClient().dio;
  final remote = AuthRemoteDataSourceImpl(dio);
  final repository = AuthRepositoryImpl(remote);
  final storage = SecureStorageService();
  final profileRepository = ProfileRepository(dio, storage);

  runApp(
  MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => AuthCubit(repository: repository, storage: storage),
      ),
      BlocProvider(
        create: (_) => ProfileCubit(profileRepository),
      ),
    ],
    child: const MyApp(),
  ),
);
}