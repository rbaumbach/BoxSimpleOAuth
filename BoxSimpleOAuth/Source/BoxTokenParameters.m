//Copyright (c) 2014-2019 Ryan Baumbach <github@ryan.codes>
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

#import "BoxTokenParameters.h"

NSString *const GrantTypeKey = @"grant_type";
NSString *const GrantTypeValue = @"authorization_code";
NSString *const ClientIDKey = @"client_id";
NSString *const ClientSecretKey = @"client_secret";
NSString *const RedirectURIKey = @"redirect_uri";
NSString *const CodeKey = @"code";

@implementation BoxTokenParameters

#pragma mark - <TokenParameters>

- (NSDictionary *)build
{
    return @{ ClientIDKey     : self.clientID,
              ClientSecretKey : self.clientSecret,
              GrantTypeKey    : GrantTypeValue,
              RedirectURIKey  : self.callbackURLString,
              CodeKey         : self.authorizationCode
            };
}

@end
