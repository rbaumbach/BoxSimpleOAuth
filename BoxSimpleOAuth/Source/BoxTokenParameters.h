#import <SimpleOAuth2/SimpleOAuth2.h>


@interface BoxTokenParameters : NSObject <TokenParameters>

@property (copy, nonatomic) NSString *clientID;
@property (copy, nonatomic) NSString *clientSecret;
@property (copy, nonatomic) NSString *callbackURLString;
@property (copy, nonatomic) NSString *authorizationCode;

@end