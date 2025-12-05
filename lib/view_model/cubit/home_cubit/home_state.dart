abstract class HomeState{}

class HomeInitState extends HomeState{}


class GetPopularLoadingState extends HomeState{}
class GetPopularSuccessState extends HomeState{}
class GetPopularErrorState extends HomeState{}


class GetRecommendedLoadingState extends HomeState{}
class GetRecommendedSuccessState extends HomeState{}
class GetRecommendedErrorState extends HomeState{}

class GetAllProductLoadingState extends HomeState{}
class GetAllProductSuccessState extends HomeState{}
class GetAllProductErrorState extends HomeState{}

class ShowProductDetailsLoadingState extends HomeState{}
class ShowProductDetailsSuccessState extends HomeState{}
class ShowProductDetailsErrorState extends HomeState{}

class ChangeSelectedSizeState extends HomeState{}
class ChangeSelectedColorState extends HomeState{}

