#import "JustAViewController.h"
#import "BoxSimpleOAuth.h"

@implementation JustAViewController

#pragma mark - IBActions

- (IBAction)pushBoxVCOnNavStackTapped:(id)sender
{
    BoxSimpleOAuthViewController
    *viewController = [[BoxSimpleOAuthViewController alloc] initWithClientID:@"enter_your_app_key_here"
                                                                clientSecret:@"enter_your_app_secret_here"
                                                                 callbackURL:[NSURL URLWithString:@"http://enter.callback.url.here"]
                                                                  completion:^(BoxLoginResponse *response, NSError *error) {
                                                                      if (response.accessToken) {
                                                                          [self displayToken:response.accessToken];
                                                                      }
                                                                  }];
    
    [self.navigationController pushViewController:viewController
                                         animated:YES];
}

#pragma mark - Private Method

- (void)displayToken:(NSString *)authToken
{
    UIAlertController *tokenAlertController = [UIAlertController alertControllerWithTitle:@"Box Token"
                                                                                  message:[NSString stringWithFormat:@"Your Token is: %@", authToken]
                                                                           preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:tokenAlertController
                       animated:YES
                     completion:nil];
}

@end
