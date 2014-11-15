#import "BoxAuthenticationManager.h"


@interface FakeBoxAuthenticationManager : BoxAuthenticationManager

@property (copy, nonatomic) NSString *authCode;
@property (copy, nonatomic) void (^success)(BoxLoginResponse *response);
@property (copy, nonatomic) void (^failure)(NSError *error);

@end
