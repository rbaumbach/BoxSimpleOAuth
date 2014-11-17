#import "BoxTokenParameters.h"


NSString *const GrantTypeKey = @"grant_type";
NSString *const GrantTypeValue = @"authorization_code";
NSString *const ClientIDKey = @"client_id";
NSString *const ClientSecretKey = @"client_secret";
NSString *const RedirectURIKey = @"redirect_uri";
NSString *const CodeKey = @"code";

@implementation BoxTokenParameters

#pragma mark - <TokenParameters>

- (NSDictionary *)build
{
    return @{ ClientIDKey     : self.clientID,
              ClientSecretKey : self.clientSecret,
              GrantTypeKey    : GrantTypeValue,
              RedirectURIKey  : self.callbackURLString,
              CodeKey         : self.authorizationCode
            };
}

@end
