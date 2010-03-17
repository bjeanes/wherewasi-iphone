
// URL
#define BASE_URL @"http://wherewasi.heroku.com"
//#define BASE_URL @"http://192.168.1.11:3000"
#define WHEREWASIURL(base, path) [NSString stringWithFormat:@"%@%@", base, path]
// Login
#define LOGIN_PATH @"/account/api_token"


// User defaults
#define SelectedLocationUserDefaults @"SelectedLocationUserDefaults"
#define APITokenUserDefaults @"APITokenUserDefaults"

// Notifications
#define LoginShouldReloadContentNotification @"LoginShouldReloadContentNotification"