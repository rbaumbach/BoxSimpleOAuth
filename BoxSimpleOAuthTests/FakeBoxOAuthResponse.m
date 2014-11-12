#import "FakeBoxOAuthResponse.h"


@implementation FakeBoxOAuthResponse

+ (NSDictionary *)response
{
    return @{
             @"access_token": @"token123",
             @"expires_in": @5000,
             @"restricted_to": @[@"i-hope-this-is-a-string"],
             @"token_type": @"tokenTypeO+",
             @"refresh_token": @"very-refreshing..."
             };
}

@end
