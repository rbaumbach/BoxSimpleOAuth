#import "BoxRefreshTokenParameters.h"


NSString *const RefreshTokenGrantTypeKey = @"grant_type";
NSString *const RefreshTokenGrantTypeValue = @"refresh_token";
NSString *const RefreshTokenClientIDKey = @"client_id";
NSString *const RefreshTokenClientSecretKey = @"client_secret";

@implementation BoxRefreshTokenParameters

#pragma mark - <TokenParameters>

- (NSDictionary *)build
{
    return @{ RefreshTokenClientIDKey     : self.clientID,
              RefreshTokenClientSecretKey : self.clientSecret,
              RefreshTokenGrantTypeKey    : RefreshTokenGrantTypeValue,
              RefreshTokenGrantTypeValue  : self.refreshToken
            };
}

@end