#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import <Swizzlean/Swizzlean.h>
#import <SimpleOAuth2/SimpleOAuth2.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "BoxSimpleOAuth.h"


@interface BoxSimpleOAuthViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *boxWebView;
@property (strong, nonatomic) NSURLRequest *webLoginRequestBuilder;

@end

SpecBegin(BoxSimpleOAuthViewControllerTests)

describe(@"BoxSimpleOAuthViewController", ^{
    __block BoxSimpleOAuthViewController *controller;
    __block BoxLoginResponse *retLoginResponse;
    __block NSError *retError;
    
    beforeEach(^{
        controller = [[BoxSimpleOAuthViewController alloc] initWithClientID:@"They-call-me-number-two"
                                                               clientSecret:@"beans"
                                                                callbackURL:[NSURL URLWithString:@"http://beansAndCheese.ios"]
                                                                 completion:^(BoxLoginResponse *response, NSError *error) {
                                                                     retLoginResponse = response;
                                                                     retError = error;
                                                                 }];
    });
    
    describe(@"init", ^{
        it(@"calls -initWithAppKey:appSecret:callbackURL:completion: with nil parameters", ^{
            BoxSimpleOAuthViewController *basicController = [[BoxSimpleOAuthViewController alloc] init];
            expect(basicController.clientID).to.beNil;
            expect(basicController.clientSecret).to.beNil;
            expect(basicController.callbackURL).to.beNil;
            expect(basicController.completion).to.beNil;
        });
    });
    
    it(@"conforms to <UIWebViewDelegate>", ^{
        BOOL conformsToWebViewDelegateProtocol = [controller conformsToProtocol:@protocol(UIWebViewDelegate)];
        expect(conformsToWebViewDelegateProtocol).to.equal(YES);
    });
    
    it(@"has a clientID", ^{
        expect(controller.clientID).to.equal(@"They-call-me-number-two");
    });
    
    it(@"has a clientSecret", ^{
        expect(controller.clientSecret).to.equal(@"beans");
    });
    
    it(@"has a callbackURL", ^{
        expect(controller.callbackURL).to.equal([NSURL URLWithString:@"http://beansAndCheese.ios"]);
    });
    
    it(@"has a completion block", ^{
        BOOL hasCompletionBlock = NO;
        if (controller.completion) {
            hasCompletionBlock = YES;
        }
        expect(hasCompletionBlock).to.beTruthy();
    });
    
    it(@"has shouldShowErrorAlert flag that defaults to YES", ^{
        expect(controller.shouldShowErrorAlert).to.beTruthy();
    });
    
    it(@"has a webRequestBuiler", ^{
        expect(controller.webLoginRequestBuilder).to.beInstanceOf([NSURLRequest class]);
    });
    
    describe(@"#viewDidAppear", ^{
        __block Swizzlean *superSwizz;
        __block BOOL isSuperCalled;
        __block BOOL retAnimated;
        __block id hudClassMethodMock;
        __block UIWebView *fakeWebView;
        __block id fakeLoginRequest;
        
        beforeEach(^{
            isSuperCalled = NO;
            superSwizz = [[Swizzlean alloc] initWithClassToSwizzle:[UIViewController class]];
            [superSwizz swizzleInstanceMethod:@selector(viewDidAppear:) withReplacementImplementation:^(id _self, BOOL isAnimated) {
                isSuperCalled = YES;
                retAnimated = isAnimated;
            }];
            
            [controller view];
            
            hudClassMethodMock = OCMClassMock([MBProgressHUD class]);
            
            fakeWebView = OCMClassMock([UIWebView class]);
            controller.boxWebView = fakeWebView;
            
            fakeLoginRequest = OCMClassMock([NSURLRequest class]);
            controller.webLoginRequestBuilder = fakeLoginRequest;
            
            NSURL *expectedLoginURL = [NSURL URLWithString:@"https://app.box.com/api/oauth2/authorize?client_id=They-call-me-number-two&response_type=code&redirect_uri=http://beansAndCheese.ios"];
            OCMStub([fakeLoginRequest buildWebLoginRequestWithURL:expectedLoginURL permissionScope:nil]).andReturn(fakeLoginRequest);
            
            [controller viewDidAppear:YES];
        });
        
        it(@"calls super!!! Thanks for asking!!! =)", ^{
            expect(retAnimated).to.beTruthy();
            expect(isSuperCalled).to.beTruthy();
        });
        
        it(@"displays Progress HUD", ^{
            OCMVerify([hudClassMethodMock showHUDAddedTo:controller.view animated:YES]);
        });
        
        it(@"loads the login using the login request", ^{
            OCMVerify([fakeWebView loadRequest:fakeLoginRequest]);
        });
    });
    
    describe(@"<UIWebViewDelegate>", ^{
        describe(@"#webViewDidFinishLoad:", ^{
            __block id hudClassMethodMock;
            
            beforeEach(^{
                hudClassMethodMock = OCMClassMock([MBProgressHUD class]);
                [controller webViewDidFinishLoad:nil];
            });
            
            it(@"removes the progress HUD", ^{
                OCMVerify([hudClassMethodMock hideHUDForView:controller.view
                                                    animated:YES]);
            });
        });
    });
});

SpecEnd
