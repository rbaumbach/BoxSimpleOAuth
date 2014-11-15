#import "MainViewController.h"
#import "BoxSimpleOAuth.h"

@implementation MainViewController

- (IBAction)presentBoxVCTapped:(id)sender
{
    BoxSimpleOAuthViewController
    *viewController = [[BoxSimpleOAuthViewController alloc] initWithClientID:@"enter_your_app_key_here"
                                                                clientSecret:@"enter_your_app_secret_here"
                                                                 callbackURL:[NSURL URLWithString:@"http://enter.callback.url.here"]
                                                                  completion:^(BoxLoginResponse *response, NSError *error) {
                                                                      ;
                                                                  }];
    [self presentViewController:viewController
                       animated:YES
                     completion:nil];
}

- (IBAction)boxVCOnNavControllerTapped:(id)sender
{
    
}

@end
