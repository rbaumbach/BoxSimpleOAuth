#import <MBProgressHUD/MBProgressHUD.h>
#import <SimpleOAuth2/SimpleOAuth2.h>
#import "BoxSimpleOAuthViewController.h"
#import "BoxConstants.h"


NSString *const BoxAuthClientIDEndpoint = @"/api/oauth2/authorize?client_id=";
NSString *const BoxAuthRequestParams = @"&response_type=code&redirect_uri=";

@interface BoxSimpleOAuthViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *boxWebView;
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

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
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
