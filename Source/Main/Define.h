
// URL
#define BASE_URL @"http://wherewasi.heroku.com"
#define WHEREWASIURL(base, path) [NSString stringWithFormat:@"%@%@?source=iphoneapp", base, path]
// Login
#define LOGIN_PATH @"/account/api_token"


// User defaults
#define SelectedLocationUserDefaults @"SelectedLocationUserDefaults"
#define APITokenUserDefaults @"APITokenUserDefaults"

// Notifications
#define LoginShouldReloadContentNotification @"LoginShouldReloadContentNotification"