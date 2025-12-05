import 'package:clothing_store/view/home/product_widget.dart';
import 'package:clothing_store/view/search/filter_widget.dart';
import 'package:clothing_store/view/widgets/custom_progress_indicator.dart';
import 'package:clothing_store/view_model/cubit/home_cubit/home_cubit.dart';
import 'package:clothing_store/view_model/cubit/search_cubit/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_model/cubit/search_cubit/search_cubit.dart';
import '../../view_model/utilities/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    SearchCubit.get(context).clearSearch();
    SearchCubit.get(context).clearFilter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(''),
        title: Text(
          "Discover",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          var homeCubit = HomeCubit.get(context);
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 80.w, vertical: 20.h),
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: SearchCubit.get(context).searchController,
                      focusNode: SearchCubit.get(context).searchNode,
                      onFieldSubmitted: (value) {
                        SearchCubit.get(context).searchProducts();
                      },
                      onTapOutside: (value) {
                        SearchCubit.get(context).searchNode.unfocus();
                      },
                      cursorColor: AppColors.grey,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColors.black),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.r),
                          borderSide: BorderSide(color: AppColors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.r),
                          borderSide: BorderSide(color: AppColors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.r),
                          borderSide: BorderSide(color: AppColors.transparent),
                        ),
                        contentPadding: EdgeInsetsDirectional.all(16.w),
                        hintText: "Search",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.grey, fontSize: 50.sp),
                        fillColor: AppColors.lightGrey,
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: AppColors.grey,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              SearchCubit.get(context).clearSearch();
                            },
                            icon: Icon(
                              Icons.close_outlined,
                              color: AppColors.blueGrey,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.lightGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        padding: EdgeInsetsDirectional.all(36.w),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return FilterWidget();
                          },
                          useSafeArea: true,
                          isScrollControlled: true,
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50.r),
                                topRight: Radius.circular(50.r)),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.filter_alt_rounded,
                        color: cubit.isFilterApplied?AppColors.red:AppColors.grey,
                      ))
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Visibility(
                  visible: (cubit.searchController.text.isEmpty && !cubit.isFilterApplied)||
                      (cubit.searchController.text.isNotEmpty &&
                          cubit.searchList.isNotEmpty) ||
                      (cubit.isFilterApplied && cubit.searchList.isNotEmpty),
                  replacement: Center(
                    child: (state is! ApplyFilterLoadingState && state is! SearchProductsLoadingState)?
                    Text(
                      'No Data Is Matched',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ):
                    CustomProgressIndicator(),
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        mainAxisSpacing: 30.h,
                        crossAxisSpacing: 60.w),
                    itemBuilder: (context, index) {
                      return ProductWidget(
                          productModel: (cubit.searchList.isNotEmpty)
                              ? cubit.searchList[index]
                              : homeCubit.products[index]);
                    },
                    itemCount: (cubit.searchList.isNotEmpty)
                        ? cubit.searchList.length
                        : homeCubit.products.length,
                  )),
            ],
          );
        },
      ),
    );
  }
}
