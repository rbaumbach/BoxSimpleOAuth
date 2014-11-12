#import <UIKit/UIKit.h>


@class BoxLoginResponse;

@interface BoxSimpleOAuthViewController : UIViewController

@property (copy, nonatomic) NSString *clientID;
@property (copy, nonatomic) NSString *clientSecret;
@property (strong, nonatomic) NSURL *callbackURL;
@property (copy, nonatomic) void (^completion)(BoxLoginResponse *response, NSError *error);
@property (nonatomic) BOOL shouldShowErrorAlert;

- (instancetype)initWithClientID:(NSString *)clientID
                    clientSecret:(NSString *)clientSecret
                     callbackURL:(NSURL *)callbackURL
                      completion:(void (^)(BoxLoginResponse *response, NSError *error))completion;

@end
