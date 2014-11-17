@import Foundation;


@class BoxLoginResponse;

@interface BoxAuthenticationManager : NSObject

- (instancetype)initWithClientID:(NSString *)clientID
                    clientSecret:(NSString *)clientSecret
               callbackURLString:(NSString *)callbackURLString;

- (void)authenticateClientWithAuthCode:(NSString *)authCode
                               success:(void (^)(BoxLoginResponse *response))success
                               failure:(void (^)(NSError *error))failure;

- (void)refreshAccessTokenWithRefreshToken:(NSString *)refreshToken
                                   success:(void (^)(BoxLoginResponse *response))success
                                   failure:(void (^)(NSError *error))failure;

@end