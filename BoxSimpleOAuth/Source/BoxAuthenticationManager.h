@import Foundation;


@class BoxLoginResponse;

@interface BoxAuthenticationManager : NSObject

- (instancetype)initWithAppKey:(NSString *)appKey
                     appSecret:(NSString *)appSecret
             callbackURLString:(NSString *)callbackURLString;

- (void)authenticateClientWithAuthCode:(NSString *)authCode
                               success:(void (^)(BoxLoginResponse *reponse))success
                               failure:(void (^)(NSError *error))failure;

@end