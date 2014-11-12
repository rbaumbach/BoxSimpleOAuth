#import "BoxLoginResponse.h"


NSString *const BoxAccessTokenKey = @"access_token";
NSString *const BoxAccessTokenExpiryKey = @"expires_in";
NSString *const BoxRestrictedToKey = @"restricted_to";
NSString *const BoxAccessTokenTypeKey = @"token_type";
NSString *const BoxRefreshTokenKey = @"refresh_token";

@interface BoxLoginResponse ()

@property (copy, nonatomic, readwrite) NSString *accessToken;
@property (copy, nonatomic, readwrite) NSNumber *accessTokenExpiry;
@property (copy, nonatomic, readwrite) NSArray *restrictedTo;
@property (copy, nonatomic, readwrite) NSString *accessTokenType;
@property (copy, nonatomic, readwrite) NSString *refreshToken;

@end

@implementation BoxLoginResponse

- (instancetype)initWithBoxOAuthResponse:(NSDictionary *)response
{
    self = [super init];
    if (self) {
        if (response) {
            self.accessToken = response[BoxAccessTokenKey];
            self.accessTokenExpiry = response[BoxAccessTokenExpiryKey];
            self.restrictedTo = response[BoxRestrictedToKey];
            self.accessTokenType = response[BoxAccessTokenTypeKey];
            self.refreshToken = response[BoxRefreshTokenKey];
        }
    }
    return self;
}

@end