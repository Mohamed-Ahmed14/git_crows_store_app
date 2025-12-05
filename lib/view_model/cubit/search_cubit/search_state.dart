
abstract class SearchState{}

class SearchInitState extends SearchState{}

class SearchProductsLoadingState extends SearchState{}
class SearchProductsSuccessState extends SearchState{}
class SearchProductsErrorState extends SearchState{}

class ClearSearchState extends SearchState{}


class SelectCategorySuccessState extends SearchState{}
class SelectPriceSuccessState extends SearchState{}

class ApplyFilterLoadingState extends SearchState{}
class ApplyFilterSuccessState extends SearchState{}
class ApplyFilterErrorState extends SearchState{}

class ClearFilterSuccessState extends SearchState{}
