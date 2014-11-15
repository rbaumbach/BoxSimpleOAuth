#import "FakeBoxAuthenticationManager.h"


@implementation FakeBoxAuthenticationManager

- (void)authenticateClientWithAuthCode:(NSString *)authCode
                               success:(void (^)(BoxLoginResponse *reponse))success
                               failure:(void (^)(NSError *error))failure
{
    self.authCode = authCode;
    self.success = success;
    self.failure = failure;
}

@end
