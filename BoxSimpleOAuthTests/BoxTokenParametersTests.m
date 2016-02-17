#import <Expecta/Expecta.h>
#import <Specta/Specta.h>
#import <OCMock/OCMock.h>
#import "BoxTokenParameters.h"


SpecBegin(BoxTokenParametersTests)

describe(@"BoxTokenParameters", ^{
    __block BoxTokenParameters *tokenParameters;
    
    beforeEach(^{
        tokenParameters = [[BoxTokenParameters alloc] init];
        tokenParameters.clientID = @"client";
        tokenParameters.clientSecret = @"secret";
        tokenParameters.callbackURLString = @"http://whatever.com";
        tokenParameters.authorizationCode = @"iua0f9us09iasdf";
    });
    
    it(@"has clientID", ^{
        expect(tokenParameters.clientID).to.equal(@"client");
    });
    
    it(@"has clientSecret", ^{
        expect(tokenParameters.clientSecret).to.equal(@"secret");
    });
    
    it(@"has callbackURLString", ^{
        expect(tokenParameters.callbackURLString).to.equal(@"http://whatever.com");
    });
    
    it(@"has authorizationCode", ^{
        expect(tokenParameters.authorizationCode).to.equal(@"iua0f9us09iasdf");
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
                                                               @"grant_type"    : @"authorization_code",
                                                               @"redirect_uri"  : tokenParameters.callbackURLString,
                                                               @"code"          : tokenParameters.authorizationCode
                                                             };
                
                expect(tokenParametersDict).to.equal(expectedTokenParametersDict);
            });
        });
    });
});

SpecEnd