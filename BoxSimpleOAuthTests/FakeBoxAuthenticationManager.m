#import "FakeBoxAuthenticationManager.h"


@implementation FakeBoxAuthenticationManager

- (void)authenticateClientWithAuthCode:(NSString *)authCode
                               success:(void (^)(BoxLoginResponse *response))success
                               failure:(void (^)(NSError *error))failure
{
    self.authCode = authCode;
    self.success = success;
    self.failure = failure;
}

- (void)refreshAccessTokenWithRefreshToken:(NSString *)refreshToken
                                   success:(void (^)(BoxLoginResponse *response))success
                                   failure:(void (^)(NSError *error))failure
{
    self.refreshToken = refreshToken;
    self.success = success;
    self.failure = failure;
}

@end
