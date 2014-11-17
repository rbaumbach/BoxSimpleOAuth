#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "BoxRefreshTokenParameters.h"


SpecBegin(BoxRefreshTokenParametersTests)

describe(@"BoxRefreshTokenParameters", ^{
    __block BoxRefreshTokenParameters *tokenParameters;
    
    beforeEach(^{
        tokenParameters = [[BoxRefreshTokenParameters alloc] init];
        tokenParameters.clientID = @"client";
        tokenParameters.clientSecret = @"secret";
        tokenParameters.refreshToken = @"i-got-the-hookup";
    });
    
    it(@"has clientID", ^{
        expect(tokenParameters.clientID).to.equal(@"client");
    });
    
    it(@"has clientSecret", ^{
        expect(tokenParameters.clientSecret).to.equal(@"secret");
    });
    
    it(@"has refresh token", ^{
        expect(tokenParameters.refreshToken).to.equal(@"i-got-the-hookup");
    });
    
    describe(@"<TokenParameters>", ^{
        describe(@"#build", ^{
            __block NSDictionary *tokenParametersDict;
            
            beforeEach(^{
                tokenParametersDict = [tokenParameters build];
            });
            
            it(@"builds tokenParameters dictionary", ^{
                NSDictionary *expectedTokenParametersDict = @{ @"client_id"     : tokenParameters.clientID,
                                                               @"client_secret" : tokenParameters.clientSecret,
                                                               @"grant_type"    : @"refresh_token",
                                                               @"refresh_token" : tokenParameters.refreshToken
                                                             };
                
                expect(tokenParametersDict).to.equal(expectedTokenParametersDict);
            });
        });
    });
});

SpecEnd