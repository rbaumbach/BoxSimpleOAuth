#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "BoxSimpleOAuthViewController.h"


SpecBegin(BoxSimpleOAuthViewControllerTests)

describe(@"BoxSimpleOAuthViewController", ^{
    __block BoxSimpleOAuthViewController *controller;
    
    beforeEach(^{
        controller = [[BoxSimpleOAuthViewController alloc] init];
    });
    
    it(@"exists", ^{
        expect(controller).notTo.beNil();
    });
});

SpecEnd
