#import <SimpleOAuth2/SimpleOAuth2.h>


@interface BoxRefreshTokenParameters : NSObject <TokenParameters>

@property (copy, nonatomic) NSString *clientID;
@property (copy, nonatomic) NSString *clientSecret;
@property (copy, nonatomic) NSString *refreshToken;

@end
