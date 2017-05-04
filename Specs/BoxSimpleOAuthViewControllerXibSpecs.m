#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

#import "BoxSimpleOAuth.h"
#import "NSLayoutConstraint+TestUtils.h"


SpecBegin(BoxSimpleOAuthViewControllerXibTests)

describe(@"BoxSimpleOAuthViewControllerXib", ^{
    __block BoxSimpleOAuthViewController *controller;
    __block UIView *boxView;
    __block UIWebView *boxWebView;
    
    beforeEach(^{
        // controller is only loaded for ownership needs when loading the nib from the bundle
        controller = [[BoxSimpleOAuthViewController alloc] init];
        
        NSBundle *bundle = [NSBundle bundleForClass:[BoxSimpleOAuthViewController class]];
        
        NSArray *nibViews = [bundle loadNibNamed:@"BoxSimpleOAuthViewController"
                                                          owner:controller
                                                        options:nil];
        
        boxView = nibViews[0];
        
        boxWebView = boxView.subviews[0]; // only subview of the main view
    });
    
    describe(@"box web view", ^{
        it(@"s delegate is the file'z owner", ^{
            expect(boxWebView.delegate).to.equal(controller);
        });
    });
    
    describe(@"constraints", ^{
        it(@"has at least 4 constraints", ^{
            expect(boxView.constraints.count).to.beGreaterThanOrEqualTo(4);
        });
        
        it(@"has Vertical Space - boxWebView to View", ^{
            NSLayoutConstraint *expectedConstraint = [NSLayoutConstraint constraintWithItem:boxWebView
                                                                                  attribute:NSLayoutAttributeTop
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:boxView
                                                                                  attribute:NSLayoutAttributeTop
                                                                                 multiplier:1
                                                                                   constant:0];
            expectedConstraint.priority = 1000;
            expectedConstraint.shouldBeArchived = YES;
            
            expect(boxView.constraints).to.contain(expectedConstraint);
        });
        
        it(@"has Horizontal Space - View to boxWebView", ^{
            NSLayoutConstraint *expectedConstraint = [NSLayoutConstraint constraintWithItem:boxView
                                                                                  attribute:NSLayoutAttributeTrailing
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:boxWebView
                                                                                  attribute:NSLayoutAttributeTrailing
                                                                                 multiplier:1
                                                                                   constant:0];
            expectedConstraint.priority = 1000;
            expectedConstraint.shouldBeArchived = YES;
            
            expect(boxView.constraints).to.contain(expectedConstraint);
        });
        
        it(@"has Vertical Space - View to boxWebView", ^{
            NSLayoutConstraint *expectedConstraint = [NSLayoutConstraint constraintWithItem:boxView
                                                                                  attribute:NSLayoutAttributeBottom
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:boxWebView
                                                                                  attribute:NSLayoutAttributeBottom
                                                                                 multiplier:1
                                                                                   constant:0];
            expectedConstraint.priority = 1000;
            expectedConstraint.shouldBeArchived = YES;
            
            expect(boxView.constraints).to.contain(expectedConstraint);
        });
        
        it(@"has Horizontal Space - boxWebView to View", ^{
            NSLayoutConstraint *expectedConstraint = [NSLayoutConstraint constraintWithItem:boxWebView
                                                                                  attribute:NSLayoutAttributeLeading
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:boxView
                                                                                  attribute:NSLayoutAttributeLeading
                                                                                 multiplier:1
                                                                                   constant:0];
            expectedConstraint.priority = 1000;
            expectedConstraint.shouldBeArchived = YES;
            
            expect(boxView.constraints).to.contain(expectedConstraint);
        });
    });
});

SpecEnd
