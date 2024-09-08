import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/error_widget.dart';
import 'package:manicann/core/components/loading_widget.dart';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/features/branches/presentation/bloc/branches_bloc/branches_bloc.dart';
import 'package:manicann/features/branches/presentation/bloc/branches_bloc/branches_state.dart';
import 'package:manicann/features/branches/presentation/widgets/branch_widget.dart';
import 'package:sizer/sizer.dart';

class SelectBranchesScreen extends StatelessWidget {
  const SelectBranchesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BranchesBloc, BranchesState>(
      builder: (context, state) {
        BranchesBloc bloc = BlocProvider.of<BranchesBloc>(context);
        if (state is ErrorBranchesState) {
          return MyErrorWidget(
            text: state.message,
            onTap: () {
              bloc.getAllBranches();
            },
          );
        } else if (state is LoadingBranchesState) {
          return const LoadingWidget();
        } else {
          return SingleChildScrollView(
            child: Container(
              width: 80.w,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Branches",
                      style: TextStyle(
                        fontFamily: "Glegoo",
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    BlocBuilder<BranchesBloc, BranchesState>(
                        builder: (context, state) {
                      var bloc = BlocProvider.of<BranchesBloc>(context);
                      return SizedBox(
                        height: 80.h,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 7.w,
                            mainAxisSpacing: 5.h,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (context, index) {
                            print(bloc.branchSelected - 1);
                            return BranchWidget(
                              onTap: () {
                                bloc.changeBrancheSelected(index, context);
                              },
                              selected: AppLink.branchId ==
                                      bloc.data[index].id.toString()
                                  ? true
                                  : false,
                              branchModel: bloc.data[index],
                              index: index,
                            );
                          },
                          itemCount: bloc.data.length,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class BranchModelView {
  final String? imageUrl;
  final String? numOfClients;
  final String? cityName;
  final String? date;
  final String? manageBy;
  final String? nameBranch;

  BranchModelView({
    this.imageUrl,
    this.numOfClients,
    this.cityName,
    this.date,
    this.manageBy,
    this.nameBranch,
  });
}
