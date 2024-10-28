import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';
import 'package:rj/config/colors.dart';
import 'package:rj/features/data/models/brand_model.dart';
import 'package:rj/features/data/models/category_model.dart';
import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/domain/use_cases/home_use_cases.dart';
import 'package:rj/features/presentation/screens/home_screen/widgets/categories_list_widget.dart';
import 'package:rj/features/presentation/screens/home_screen/widgets/home_brand_section_widget.dart';
import 'package:rj/features/presentation/screens/home_screen/widgets/price_drop_widget.dart';
import 'package:rj/features/presentation/widgets/product_layout.dart';
import 'package:rj/utils/common.dart';
import 'package:rj/utils/constants.dart';
import 'package:rj/utils/styles.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stroke_text/stroke_text.dart';

import '../../../domain/use_cases/common_use_cases.dart';
import 'bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeBloc>().add(FetchDataHomeEvent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    debugPrint("MAIN WIDGET\n"
        "HEIGHT ${size.height}\n"
        "WIDTH ${size.width}\n");
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _topMarquee(),
            SizedBox(height: 3,),
            _banner(),
            _category(),
            _topBrand(),
            sizedH20,
            const PriceDropwidget(),
            sizedH40,
            sizedH40,
            sizedH40,
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("That's it For Now\n",style: style(fontSize: 30, color:Colors.grey, weight: FontWeight.normal),),
                  Text("RJ Online",style: style(fontSize: 30, color:Colors.grey, weight: FontWeight.normal),)

                ],
              ),
            ),
            sizedH40,
          ],
        ),
      ),
    );
  }

  BlocBuilder<HomeBloc, HomeState> _topBrand() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        print("Home State ${state.runtimeType}");
        if (state is FetchDataHomeSuccessState) {
          return HomeBrandSectionWidget(brandList: state.brandList);
        }
        return SizedBox();
      },
    );
  }

  BlocBuilder<HomeBloc, HomeState> _category() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        print("Home State ${state.runtimeType}");
        if (state is FetchDataHomeSuccessState) {
          return HomeCategoryWidget(
            categoryList: state.categoryList,
          );
        }
        return SizedBox();
      },
    );
  }

  Widget _banner() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is FetchDataHomeSuccessState) {
          final images = getImageList(state.bannerModel.bannerImages);
          return CarouselSlider(
            items: List.generate(images.length, (index) {
              return Image.network(
                images[index].downloadUrl,
                loadingBuilder: (context, child, loadingProgress) =>
                    CommonUseCases.checkIfImageLoadingBANNERPlaceholder(
                        loadingProgress, child),
              );
            }),
            options: CarouselOptions(autoPlay: true, viewportFraction: 1),
          );
        }
        return CarouselSlider(
          items: const [
            Center(child: Text("Loading ...")),
          ],
          options: CarouselOptions(autoPlay: true, viewportFraction: 1),
        );
      },
    );
  }

  Widget _topMarquee() {
    return  Container(
      height: 40,
      width: double.infinity,
      color: Colors.black,
      child: Center(
        child: Marquee(
          text: "Best Products | Popular Brands | Best Offers | Faster Delivery | Responsible Customer Care | ",
          style: const TextStyle(

            backgroundColor: Colors.black,
              color: Colors.white, fontSize: 15),
          crossAxisAlignment: CrossAxisAlignment.center,
          scrollAxis: Axis.horizontal,
          blankSpace: 1,
          fadingEdgeStartFraction: 0.1,
          fadingEdgeEndFraction: 0.1,
        ),
      ),
    );
  }
}

class HomeCategoryWidget extends StatelessWidget {
  const HomeCategoryWidget({
    super.key,
    required this.categoryList,
  });

  final List<CategoryModel> categoryList;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    print("HomeCategoryWidget\n"
        "HEIGHT ${size.height}\n"
        "WIDTH ${size.width}\n");
    return Container(
      height: size.height*0.18,
      alignment: Alignment.center,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          return CategoryItemsWidget(
            categoryList: categoryList[index],
            index: index,
          );
        },
      ),
    );
  }
}
