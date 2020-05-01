//
//  Country.m
//  RSSchool_T5
//
//  Created by Dmitry Marchenko on 5/1/20.
//  Copyright © 2020 iOSLab. All rights reserved.
//

#import "Country.h"

@implementation Country

#pragma mark - Init & dealloc

- (instancetype)initWithIdentifer:(NSString *)identifer
                             code:(NSNumber *)code
                     numberLength:(NSNumber *)numberLength {
    
    self = [super init];
    if (self) {
        _identifer = identifer;
        _code = code;
        _numberLength = numberLength;
    }
    return self;
}


#pragma mark - Class methods

+ (NSArray<Country *> *)allCountries {
    
    Country *russia = [[Country alloc] initWithIdentifer:@"RU" code:@7 numberLength:@10];
    Country *kazahstan = [[Country alloc] initWithIdentifer:@"KZ" code:@7 numberLength:@10];
    Country *moldova = [[Country alloc] initWithIdentifer:@"MD" code:@373 numberLength:@8];
    Country *armenia = [[Country alloc] initWithIdentifer:@"AM" code:@374 numberLength:@8];
    Country *belarus = [[Country alloc] initWithIdentifer:@"BY" code:@375 numberLength:@9];
    Country *ukraine = [[Country alloc] initWithIdentifer:@"UA" code:@380 numberLength:@9];
    Country *tajikistan = [[Country alloc] initWithIdentifer:@"TJ" code:@992 numberLength:@9];
    Country *turkmenistan = [[Country alloc] initWithIdentifer:@"TM" code:@993 numberLength:@8];
    Country *azerbaijan = [[Country alloc] initWithIdentifer:@"AZ" code:@994 numberLength:@9];
    Country *kyrgyzstan = [[Country alloc] initWithIdentifer:@"KG" code:@996 numberLength:@9];
    Country *uzbekistan = [[Country alloc] initWithIdentifer:@"UZ" code:@998 numberLength:@9];
    
    return @[russia, kazahstan, moldova, armenia, belarus, ukraine,
             tajikistan, turkmenistan, azerbaijan, kyrgyzstan, uzbekistan];
}


+ (Country *)countryWithIdentifer:(NSString *)identifer {
    
    NSArray *allCountries = [Country allCountries];
    
    for (Country *currentCountry in allCountries) {
        
        if ([currentCountry.identifer isEqualToString:identifer]) {
            return currentCountry;
        }
    }
    return nil;
}

@end
