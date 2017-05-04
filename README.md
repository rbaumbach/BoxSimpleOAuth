# BoxSimpleOAuth [![CircleCI](https://circleci.com/gh/rbaumbach/BoxSimpleOAuth.svg?style=svg)](https://circleci.com/gh/rbaumbach/BoxSimpleOAuth) [![codecov.io](https://codecov.io/github/rbaumbach/BoxSimpleOAuth/coverage.svg?branch=master)](https://codecov.io/github/rbaumbach/BoxSimpleOAuth?branch=master) [![Cocoapod Version](https://img.shields.io/cocoapods/v/BoxSimpleOAuth.svg)](http://cocoapods.org/?q=BoxSimpleOAuth) [![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)[![Cocoapod Platform](https://img.shields.io/badge/platform-iOS-blue.svg)](http://cocoapods.org/?q=BoxSimpleOAuth) [![License](https://img.shields.io/dub/l/vibe-d.svg)](https://github.com/rbaumbach/BoxSimpleOAuth/blob/master/MIT-LICENSE.txt)

A quick and simple way to authenticate a Box user in your iPhone or iPad app.

<p align="center">
   <img src="https://github.com/rbaumbach/BoxSimpleOAuth/blob/master/iPhone5Screenshot.jpg?raw=true" alt="iPhone5 Screenshot"/>
   <img src="https://github.com/rbaumbach/BoxSimpleOAuth/blob/master/iPadScreenshot.jpg?raw=true" alt="iPad Screenshot"/>
</p>

## Adding BoxSimpleOAuth to your project

### CocoaPods

[CocoaPods](http://cocoapods.org) is the recommended way to add BoxSimpleOAuth to your project.

1.  Add BoxSimpleOAuth to your Podfile `pod 'BoxSimpleOAuth'`.
2.  Install the pod(s) by running `pod install`.
3.  Add BoxSimpleOAuth to your files with `#import <BoxSimpleOAuth/BoxSimpleOAuth.h>`.

### Carthage

1. Add `github "rbaumbach/BoxSimpleOAuth"` to your Cartfile.
2. [Follow the directions](https://github.com/Carthage/Carthage#getting-started) to add the dynamic framework to your target.

### Clone from Github

1.  Clone repository from github and copy files directly, or add it as a git submodule.
2.  Add all files from 'Source' directory to your project.

## How To

* Create an instance of `BoxSimpleOAuthViewController` and pass in an [Box client ID, client secret, client callback URL](https://developers.box.com) and completion block to be executed with `BoxLoginResponse` and `NSError` arguments.
* Once the instance of `BoxSimpleOAuthViewController` is presented (either as a modal or pushed on the navigation stack), it will allow the user to login.  After the user logs in, the completion block given in the initialization of the view controller will be executed.  The argument in the completion block, `BoxLoginResponse`, contains an accessToken and other login information for the authenticated user provided by [Box API Response](https://developers.box.com/oauth/).  If there is an issue attempting to authenticate, an error will be given instead.
* By default, if there are issues with authentication, an UIAlertView will be given to the user.  To disable this, and rely on the NSError directly, set the property `shouldShowErrorAlert` to NO.
* An access_token can be refreshed using the underlying BoxAuthenticationManager.
* Note: Even though an instance of the view controller itself can be initialized without client ID, client secret, client callback and completion block (to help with testing), this data must be set using the view controller's properties before it is presented to the user.

### Example Usage

```objective-c
// Simplest Example:

BoxSimpleOAuthViewController
    *viewController = [[BoxSimpleOAuthViewController alloc] initWithClientID:@"panchos_client_id"
                                                                clientSecret:@"shhhhhh, I'm a secret"
                                                                 callbackURL:[NSURL URLWithString:@"http://chihuahuas.dog"]
                                                                  completion:^(BoxLoginResponse *response, NSError *error) {
                                                                      NSLog(@"My Access Token is: %@", response.accessToken);
                                                                  }];
[self.navigationController pushViewController:viewController
                                     animated:YES];

// Disable error UIAlertViews Example:

BoxSimpleOAuthViewController
    *viewController = [[BoxSimpleOAuthViewController alloc] initWithClientID:@"pancho_jrs_client_id"
                                                                clientSecret:@"shhhhhh, I'm a secret"
                                                                 callbackURL:[NSURL URLWithString:@"http://your.fancy.site"]
                                                                  completion:^(BoxLoginResponse *response, NSError *error) {
                                                                      NSLog(@"My OAuth Token is: %@", response.accessToken);
                                                                  }];
viewController.shouldShowErrorAlert = NO;

[self.navigationController pushViewController:viewController
                                     animated:YES];

```

## Testing

* Prerequisites: [ruby](https://github.com/sstephenson/rbenv), [ruby gems](https://rubygems.org/pages/download), [bundler](http://bundler.io)

This project has been setup to use [fastlane](https://fastlane.tools) to run the tests.

First, run the setup.sh script to bundle required gems and CocoaPods when in the project directory:

```bash
$ ./setup.sh
```

And then use fastlane to run all the specs on the command line:

```bash
$ bundle exec fastlane specs
```

## Version History

Version history can be found [on releases page](https://github.com/rbaumbach/BoxSimpleOAuth/releases).

## Suggestions, requests, and feedback

Thanks for checking out BoxSimpleOAuth for your in-app Box Authentication.  Any feedback can be can be sent to: github@ryan.codes.
