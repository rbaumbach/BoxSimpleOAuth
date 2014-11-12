#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "BoxSimpleOAuthViewController.h"


SpecBegin(BoxSimpleOAuthViewControllerTests)

describe(@"BoxSimpleOAuthViewController", ^{
    __block BoxSimpleOAuthViewController *controller;
    __block BoxLoginResponse *retLoginResponse;
    __block NSError *retError;
    
    beforeEach(^{
        controller = [[BoxSimpleOAuthViewController alloc] initWithClientID:@"They-call-me-number-two"
                                                               clientSecret:@"beans"
                                                                callbackURL:[NSURL URLWithString:@"http://ilivedangerously.ios"]
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
    
    it(@"has a clientID", ^{
        expect(controller.clientID).to.equal(@"They-call-me-number-two");
    });
    
    it(@"has a clientSecret", ^{
        expect(controller.clientSecret).to.equal(@"beans");
    });
    
    it(@"has a callbackURL", ^{
        expect(controller.callbackURL).to.equal([NSURL URLWithString:@"http://ilivedangerously.ios"]);
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
});

SpecEnd
