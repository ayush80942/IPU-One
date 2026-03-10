import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/profile_cubit.dart';
import 'cubit/profile_state.dart';
import 'widgets/academic_info_card.dart';
import 'widgets/account_status_card.dart';
import 'widgets/address_card.dart';
import 'widgets/completion_card.dart';
import 'widgets/documents_card.dart';
import 'widgets/guardian_info_card.dart';
import 'widgets/personal_info_card.dart';
import 'widgets/profile_header.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().loadProfile();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Profile"),
      ),

      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {

          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProfileLoaded) {

            final profile = state.profile;

            return SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120),
              child: Column(
                children: [

                  ProfileHeader(profile),

                  CompletionCard(profile),

                  PersonalInfoCard(profile),

                  AcademicInfoCard(profile),

                  GuardianInfoCard(profile),

                  AddressCard(
                    title: "Correspondence Address",
                    address: profile.correspondenceAddress,
                  ),

                  AddressCard(
                    title: "Permanent Address",
                    address: profile.permanentAddress,
                  ),

                  DocumentsCard(profile),

                  AccountStatusCard(profile),
                ],
              ),
            );
          }

          if (state is ProfileError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
    );
  }
}