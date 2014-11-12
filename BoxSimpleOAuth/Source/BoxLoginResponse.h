#import <Foundation/Foundation.h>


@interface BoxLoginResponse : NSObject

@property (copy, nonatomic, readonly) NSString *accessToken;
@property (copy, nonatomic, readonly) NSNumber *accessTokenExpiry;
@property (copy, nonatomic, readonly) NSArray *restrictedTo;
@property (copy, nonatomic, readonly) NSString *accessTokenType;
@property (copy, nonatomic, readonly) NSString *refreshToken;

- (instancetype)initWithBoxOAuthResponse:(NSDictionary *)response;

@end
