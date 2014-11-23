#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import <SimpleOAuth2/SimpleOAuth2.h>
#import <RealFakes/RealFakes.h>
#import "FakeBoxOAuthResponse.h"
#import "FakeSimpleOAuth2AuthenticationManager.h"
#import "BoxAuthenticationManager.h"
#import "BoxLoginResponse.h"
#import "BoxTokenParameters.h"
#import "BoxRefreshTokenParameters.h"


@interface BoxAuthenticationManager ()

@property (copy, nonatomic) NSString *clientID;
@property (copy, nonatomic) NSString *clientSecret;
@property (copy, nonatomic) NSString *callbackURLString;
@property (copy, nonatomic) SimpleOAuth2AuthenticationManager *simpleOAuth2AuthenticationManager;

@end

SpecBegin(BoxAuthenticationManagerTests)

describe(@"BoxAuthenticationManager", ^{
    __block BoxAuthenticationManager *boxAuthenticationManager;
    __block FakeSimpleOAuth2AuthenticationManager *fakeSimpleAuthManager;
    __block BoxLoginResponse *retBoxLoginResponse;
    __block NSError *authError;
    
    beforeEach(^{
        boxAuthenticationManager = [[BoxAuthenticationManager alloc] initWithClientID:@"give-me-the-keys"
                                                                         clientSecret:@"spilling-beans"
                                                                    callbackURLString:@"http://call-me-back.8675309"];
        
        fakeSimpleAuthManager = [[FakeSimpleOAuth2AuthenticationManager alloc] init];
    });
    
    it(@"has an appKey", ^{
        expect(boxAuthenticationManager.clientID).to.equal(@"give-me-the-keys");
    });
    
    it(@"has an appSecret", ^{
        expect(boxAuthenticationManager.clientSecret).to.equal(@"spilling-beans");
    });
    
    it(@"has a callbackURLString", ^{
        expect(boxAuthenticationManager.callbackURLString).to.equal(@"http://call-me-back.8675309");
    });
    
    it(@"has a simpleOAuth2AuthenticationManager", ^{
        expect(boxAuthenticationManager.simpleOAuth2AuthenticationManager).to.beInstanceOf([SimpleOAuth2AuthenticationManager class]);
    });
    
    describe(@"#authenticateClientWithAuthCode:success:failure:", ^{
        beforeEach(^{
            boxAuthenticationManager.simpleOAuth2AuthenticationManager = fakeSimpleAuthManager;

            [boxAuthenticationManager authenticateClientWithAuthCode:@"SF-Giants-The-Best"
                                                             success:^(BoxLoginResponse *response) {
                                                                 retBoxLoginResponse = response;
                                                             } failure:^(NSError *error) {
                                                                 authError = error;
                                                             }];
        });
        
        it(@"is called with authURL", ^{
            expect(fakeSimpleAuthManager.authURL).to.equal([NSURL URLWithString:@"https://app.box.com/api/oauth2/token"]);
        });
        
        it(@"is called with token parameters", ^{
            BoxTokenParameters *tokenParameters = (BoxTokenParameters *)fakeSimpleAuthManager.tokenParameters;
            
            expect(tokenParameters.clientID).to.equal(@"give-me-the-keys");
            expect(tokenParameters.clientSecret).to.equal(@"spilling-beans");
            expect(tokenParameters.callbackURLString).to.equal(@"http://call-me-back.8675309");
            expect(tokenParameters.authorizationCode).to.equal(@"SF-Giants-The-Best");
        });
        
        context(@"On Success", ^{
            beforeEach(^{
                if (fakeSimpleAuthManager.success) {
                    fakeSimpleAuthManager.success([FakeBoxOAuthResponse response]);
                }
            });
            
            it(@"calls success block with BoxLoginResponse", ^{
                expect(retBoxLoginResponse.accessToken).to.equal(@"token123");
                expect(retBoxLoginResponse.accessTokenExpiry).to.equal(@5000);
                expect(retBoxLoginResponse.restrictedTo).to.equal(@[@"i-hope-this-is-a-string"]);
                expect(retBoxLoginResponse.accessTokenType).to.equal(@"tokenTypeO+");
                expect(retBoxLoginResponse.refreshToken).to.equal(@"very-refreshing...");
            });
        });
        
        context(@"On Failure", ^{
            __block id fakeError;
            
            beforeEach(^{
                fakeError = OCMClassMock([NSError class]);
                
                if (fakeSimpleAuthManager.failure) {
                    fakeSimpleAuthManager.failure(fakeError);
                }
            });
            
            it(@"calls simpleOAuth failure block with error", ^{
                expect(authError).to.equal(fakeError);
            });
        });
    });
    
    describe(@"#refreshAccessTokenWithRefreshToken:success:failure:", ^{
        beforeEach(^{
            boxAuthenticationManager.simpleOAuth2AuthenticationManager = fakeSimpleAuthManager;

            [boxAuthenticationManager refreshAccessTokenWithRefreshToken:@"give-me-mas-access"
                                                                 success:^(BoxLoginResponse *response) {
                                                                     retBoxLoginResponse = response;
                                                                 } failure:^(NSError *error) {
                                                                     authError = error;
                                                                 }];
        });
        
        it(@"is called with refresh token", ^{
            BoxRefreshTokenParameters *tokenParameters = (BoxRefreshTokenParameters *)fakeSimpleAuthManager.tokenParameters;
            
            expect(tokenParameters.refreshToken).to.equal(@"give-me-mas-access");
        });
        
        context(@"On Success", ^{
            beforeEach(^{
                if (fakeSimpleAuthManager.success) {
                    fakeSimpleAuthManager.success([FakeBoxOAuthResponse response]);
                }
            });
            
            it(@"calls success block with BoxLoginResponse", ^{
                expect(retBoxLoginResponse.accessToken).to.equal(@"token123");
                expect(retBoxLoginResponse.accessTokenExpiry).to.equal(@5000);
                expect(retBoxLoginResponse.restrictedTo).to.equal(@[@"i-hope-this-is-a-string"]);
                expect(retBoxLoginResponse.accessTokenType).to.equal(@"tokenTypeO+");
                expect(retBoxLoginResponse.refreshToken).to.equal(@"very-refreshing...");
            });
        });
        
        context(@"On Failure", ^{
            __block id fakeError;
            
            beforeEach(^{
                fakeError = OCMClassMock([NSError class]);
                
                if (fakeSimpleAuthManager.failure) {
                    fakeSimpleAuthManager.failure(fakeError);
                }
            });
            
            it(@"calls simpleOAuth failure block with error", ^{
                expect(authError).to.equal(fakeError);
            });
        });
    });
});

SpecEnd