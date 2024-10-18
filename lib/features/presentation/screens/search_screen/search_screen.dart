import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rj/features/presentation/screens/brand_details_screen/bloc/brand_details_bloc.dart';
import 'package:rj/features/presentation/screens/search_screen/bloc/search_bloc.dart';
import 'package:rj/features/presentation/widgets/empty_list_widget.dart';
import 'package:rj/features/presentation/widgets/filter_icon_widget.dart';
import 'package:rj/features/presentation/widgets/product_layout.dart';

import '../../../../utils/text_controllers.dart';
import '../../widgets/filter_bottom_sheet_content.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          height: 40,
          padding: const EdgeInsets.only(left: 4.0),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: TextField(
            controller: searchAppBarController,
            autofocus: true,
            //onChanged: searchBar,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search",
              prefixIcon: const Icon(
                Icons.search,
              ),
              suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.mic,
                  )),
            ),
            onChanged: (value) =>
                context
                    .read<SearchBloc>()
                    .add(FetchSearchResultEvent(letter: value)),
          ),
        ),
      ),
      body: PopScope(
        canPop: true,
        onPopInvokedWithResult: (w,e){
          searchAppBarController.clear();
        },
        child: Column(
          children: [
            _topSection(context),
            _searchResults(),
          ],
        ),
      ),
    );
  }

  Expanded _searchResults() {
    return Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if(state is FetchSearchItemsSuccessState) {
                  return GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5),
                    itemBuilder: (context, index) {
                      return ProductLayout(productsModel: state.productList[index]);
                    },
                    itemCount: state.productList.length,
                  );
                }else if(state is FetchSearchItemsNULLState){
                  return const EmptyListWidget();
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          );
  }

  Row _topSection(BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              IconButton(
                  onPressed: () {
                    //context.read<BottomSheetBloc>().add(CategoryBrandEvent());
                    showModalBottomSheet(
                        context: context,
                        enableDrag: true,
                        isDismissible: false,
                        builder: (context) =>  const FilterBottomSheetContent(
                          tag: "Search",
                          tagName: "Search",
                        ));
                  },
                  icon: const Icon(Icons.filter_alt_outlined)),
            ],
          );
  }
}
