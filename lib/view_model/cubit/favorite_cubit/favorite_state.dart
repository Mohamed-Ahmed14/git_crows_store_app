abstract class FavoriteState{}
class FavoriteInitState extends FavoriteState{}


class GetFavoriteProductsLoadingState extends FavoriteState{}
class GetFavoriteProductsSuccessState extends FavoriteState{}
class GetFavoriteProductsErrorState extends FavoriteState{}

class AddFavoriteProductsLoadingState extends FavoriteState{}
class AddFavoriteProductsSuccessState extends FavoriteState{}
class AddFavoriteProductsErrorState extends FavoriteState{}

class RemoveFavoriteProductsLoadingState extends FavoriteState{}
class RemoveFavoriteProductsSuccessState extends FavoriteState{}
class RemoveFavoriteProductsErrorState extends FavoriteState{}