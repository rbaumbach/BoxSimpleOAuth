#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "BoxSimpleOAuth.h"


SpecBegin(BoxSimpleOAuthViewControllerXibTests)

describe(@"BoxSimpleOAuthViewControllerXib", ^{
    __block BoxSimpleOAuthViewController *controller;
    __block UIView *boxView;
    __block UIWebView *boxWebView;
    
    beforeEach(^{
        // controller is only loaded for ownership needs when loading the nib from the bundle
        controller = [[BoxSimpleOAuthViewController alloc] init];
        NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"BoxSimpleOAuthViewController"
                                                          owner:controller
                                                        options:nil];
        
        boxView = nibViews[0];
        
        boxWebView = boxView.subviews[0]; // only subview of the main view
    });
    
    describe(@"dropbox web view", ^{
        it(@"s delegate is the file'z owner", ^{
            expect(boxWebView.delegate).to.equal(controller);
        });
    });
});

SpecEnd