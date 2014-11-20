//Copyright (c) 2014 Ryan Baumbach <rbaumbach.github@gmail.com>
//
//Permission is hereby granted, free of charge, to any person obtaining
//a copy of this software and associated documentation files (the "Software"),
//to deal in the Software without restriction, including
//without limitation the rights to use, copy, modify, merge, publish,
//distribute, sublicense, and/or sell copies of the Software, and to
//permit persons to whom the Software is furnished to do so, subject to
//the following conditions:
//
//The above copyright notice and this permission notice shall be
//included in all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "BoxLoginResponse.h"


NSString *const BoxAccessTokenKey = @"access_token";
NSString *const BoxAccessTokenExpiryKey = @"expires_in";
NSString *const BoxRestrictedToKey = @"restricted_to";
NSString *const BoxAccessTokenTypeKey = @"token_type";
NSString *const BoxRefreshTokenKey = @"refresh_token";

@interface BoxLoginResponse ()

@property (copy, nonatomic, readwrite) NSString *accessToken;
@property (copy, nonatomic, readwrite) NSNumber *accessTokenExpiry;
@property (copy, nonatomic, readwrite) NSArray *restrictedTo;
@property (copy, nonatomic, readwrite) NSString *accessTokenType;
@property (copy, nonatomic, readwrite) NSString *refreshToken;

@end

@implementation BoxLoginResponse

- (instancetype)initWithBoxOAuthResponse:(NSDictionary *)response
{
    self = [super init];
    if (self) {
        if (response) {
            self.accessToken = response[BoxAccessTokenKey];
            self.accessTokenExpiry = response[BoxAccessTokenExpiryKey];
            self.restrictedTo = response[BoxRestrictedToKey];
            self.accessTokenType = response[BoxAccessTokenTypeKey];
            self.refreshToken = response[BoxRefreshTokenKey];
        }
    }
    return self;
}

@end