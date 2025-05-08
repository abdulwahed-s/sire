class AppLink{
static const String server = "http://10.0.2.2/ecommerce";
// 
static const String test = "$server/test.php";
//Auth 
static const String signup = "$server/auth/signup.php";
static const String login = "$server/auth/login.php";
static const String verifycode = "$server/auth/verifycode.php";
static const String resendcode = "$server/auth/resendcode.php";

//Forget password
static const String checkemail = "$server/forgotpassword/checkemail.php";
static const String verifycodepass = "$server/forgotpassword/verifycodepass.php";
static const String resetpassword = "$server/forgotpassword/resetpassword.php";
//Home
static const String home = "$server/home.php";
//Images
static const String image = "http://10.0.2.2/ecommerce/upload";
static const String itemimage = "$image/items/";
static const String categoriesimage = "$image/categories/";
//items
static const String items = "$server/items/items.php";
//favourites
static const String favouritesAdd = "$server/favourites/add.php";
static const String favouritesDelete = "$server/favourites/delete.php";
static const String favouritesView = "$server/favourites/view.php";
//cart
static const String cartAdd = "$server/cart/addcart.php";
static const String cartDelete = "$server/cart/deletecart.php";
static const String cartView = "$server/cart/viewcart.php";
static const String cartCount = "$server/cart/countcart.php";
//search
static const String search ="$server/search/search.php";
static const String suggestion ="$server/search/suggestion.php";
//addresses
static const String addAddress    ="$server/address/add.php";
static const String deleteAddress ="$server/address/delete.php";
static const String updateAddress ="$server/address/update.php";
static const String viewAddress   ="$server/address/view.php";
//coupon
static const String checkCoupon   ="$server/coupon/checkcoupon.php";
//checkout
static const String checkout = "$server/checkout/checkout.php";
//notification
static const String viewNotification = "$server/notification/viewnotification.php";
static const String deleteNotification = "$server/notification/deleteNotification.php";
//orders
static const String viewPendingOrders = "$server/orders/pending.php";
static const String viewArchivedOrders = "$server/orders/archived.php";
static const String getOrderDetails = "$server/orders/vieworder.php";
static const String cancelOrder = "$server/orders/cancel.php";
//rating
static const String addRating = "$server/rating/add.php";













} 