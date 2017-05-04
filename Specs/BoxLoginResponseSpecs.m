#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

#import "BoxSimpleOAuth.h"
#import "FakeBoxOAuthResponse.h"

SpecBegin(BoxLoginResponse)

describe(@"BoxLoginResponse", ^{
    __block BoxLoginResponse *loginResponse;
    
    beforeEach(^{
        loginResponse = [[BoxLoginResponse alloc] initWithBoxOAuthResponse:[FakeBoxOAuthResponse response]];
    });
    
    it(@"has an oauth token", ^{
        expect(loginResponse.accessToken).to.equal(@"token123");
    });
    
    it(@"has an token expiry", ^{
        expect(loginResponse.accessTokenExpiry).to.equal(@5000);
    });
    
    it(@"has an array of restrictions", ^{
        expect(loginResponse.restrictedTo).to.equal(@[@"i-hope-this-is-a-string"]);
    });
    
    it(@"has a token type", ^{
        expect(loginResponse.accessTokenType).to.equal(@"tokenTypeO+");
    });
    
    it(@"has a refresh token", ^{
        expect(loginResponse.refreshToken).to.equal(@"very-refreshing...");
    });
});

SpecEnd
