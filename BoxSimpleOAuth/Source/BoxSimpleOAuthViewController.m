#import <MBProgressHUD/MBProgressHUD.h>
#import <SimpleOAuth2/SimpleOAuth2.h>
#import "BoxSimpleOAuthViewController.h"
#import "BoxConstants.h"
#import "BoxAuthenticationManager.h"


NSString *const BoxAuthClientIDEndpoint = @"/api/oauth2/authorize?client_id=";
NSString *const BoxAuthRequestParams = @"&response_type=code&redirect_uri=";
NSString *const NSLocalizedDescriptionKey = @"NSLocalizedDescription";
NSString *const BoxLoginErrorAlertTitle = @"Box Login Error";
NSString *const BoxLoginCancelButtonTitle = @"OK";

@interface BoxSimpleOAuthViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *boxWebView;
@property (strong, nonatomic) BoxAuthenticationManager *boxAuthenticationManager;
@property (strong, nonatomic) NSURLRequest *webLoginRequestBuilder;

@end

@implementation BoxSimpleOAuthViewController

#pragma mark - Init Methods

- (instancetype)initWithClientID:(NSString *)clientID
                    clientSecret:(NSString *)clientSecret
                     callbackURL:(NSURL *)callbackURL
                      completion:(void (^)(BoxLoginResponse *response, NSError *error))completion
{
    self = [super init];
    if (self) {
        self.clientID = clientID;
        self.clientSecret = clientSecret;
        self.callbackURL = callbackURL;
        self.completion = completion;
        self.shouldShowErrorAlert = YES;
        self.boxAuthenticationManager = [[BoxAuthenticationManager alloc] initWithClientID:self.clientID
                                                                              clientSecret:self.clientSecret
                                                                         callbackURLString:self.callbackURL.absoluteString];
        self.webLoginRequestBuilder = [[NSURLRequest alloc] init];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithClientID:nil
                     clientSecret:nil
                      callbackURL:nil
                       completion:nil];
}

#pragma mark - View Lifecycle

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self loadBoxLogin];
}

#pragma mark - <UIWebViewDelegate>

#pragma mark - <UIWebViewDelegate>

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    NSString *authorizationCode = [request oAuth2AuthorizationCode];
    
    if (authorizationCode) {
        [self.boxAuthenticationManager authenticateClientWithAuthCode:authorizationCode
                                                              success:^(BoxLoginResponse *reponse) {
                                                                  [self completeAuthWithLoginResponse:reponse];
                                                              } failure:^(NSError *error) {
                                                                  [self completeWithError:error];
                                                              }];
        return NO;
    }
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideProgressHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (error.code != 102) {
        [self completeWithError:error];
        
        if (self.shouldShowErrorAlert) {
            [self showErrorAlert:error];
        }
        
        [self dismissViewController];
    }
    
    [self hideProgressHUD];
}

#pragma mark - Private Methods

- (void)loadBoxLogin
{
    [self showProgressHUD];
    
    NSString *loginURLString = [NSString stringWithFormat:@"%@%@%@%@%@",
                                BoxAuthURL,
                                BoxAuthClientIDEndpoint,
                                self.clientID,
                                BoxAuthRequestParams,
                                self.callbackURL.absoluteString];
    
    NSURL *loginURL = [NSURL URLWithString:loginURLString];
    NSURLRequest *requestBuilder = [self.webLoginRequestBuilder buildWebLoginRequestWithURL:loginURL
                                                                            permissionScope:nil];
    
    [self.boxWebView loadRequest:requestBuilder];
}

- (void)completeAuthWithLoginResponse:(BoxLoginResponse *)response
{
    self.completion(response, nil);
    
    [self dismissViewController];
    [self hideProgressHUD];
}

- (void)completeWithError:(NSError *)error
{
    self.completion(nil, error);
    
    if (self.shouldShowErrorAlert) {
        [self showErrorAlert:error];
    }
    
    [self dismissViewController];
    [self hideProgressHUD];
}

- (void)dismissViewController
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES
                                 completion:nil];
    }
}

- (void)showErrorAlert:(NSError *)error
{
    NSString *errorMessage = [NSString stringWithFormat:@"%@ - %@", error.domain, error.userInfo[NSLocalizedDescriptionKey]];
    
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:BoxLoginErrorAlertTitle
                                                         message:errorMessage
                                                        delegate:nil
                                               cancelButtonTitle:BoxLoginCancelButtonTitle
                                               otherButtonTitles:nil];
    [errorAlert show];
}

- (void)showProgressHUD
{
    [MBProgressHUD showHUDAddedTo:self.view
                         animated:YES];
}

- (void)hideProgressHUD
{
    [MBProgressHUD hideHUDForView:self.view
                         animated:YES];
}

@end
