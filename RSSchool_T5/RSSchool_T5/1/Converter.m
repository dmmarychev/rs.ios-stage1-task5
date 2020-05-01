#import "Converter.h"
#import "Country.h"

// Do not change
NSString *KeyPhoneNumber = @"phoneNumber";
NSString *KeyCountry = @"country";

@implementation PNConverter

- (NSDictionary*)converToPhoneNumberNextString:(NSString*)string; {
    
    NSCharacterSet *set = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSString *clearString = [self string:string byDeletingCharactersFromSet:set];

    Country *recognizedCountry = [self recognizeCountryForNumberString:clearString];
    
    //Country not recognized
    if (!recognizedCountry) {
        
        NSString *resultWithPossibleTrimming = [clearString length] > 12 ? [clearString substringToIndex:12] : clearString;
        
        return @{KeyPhoneNumber: [NSString stringWithFormat:@"+%@", resultWithPossibleTrimming],
                     KeyCountry: @""};
    }
    
    //Country recognized
    NSString *resultPhoneNumberString = [self formatePhoneNumberString:clearString withCountry:recognizedCountry];
    NSString *resultCountryIdentifer = recognizedCountry.identifer;
    
    return @{KeyPhoneNumber: resultPhoneNumberString,
                 KeyCountry: resultCountryIdentifer};
}


#pragma mark - Country recognizers

- (Country *)recognizeCountryForNumberString:(NSString *)numberString {

    for (Country *currentCountry in [Country allCountries]) {
        
        NSInteger lengthOfCurrentCountryCode = [[currentCountry.code stringValue] length];
        
        if ([numberString length] < lengthOfCurrentCountryCode) {
            continue;
        }
        
        NSString *possibleCountryCodeFromNumberString = [numberString substringToIndex: lengthOfCurrentCountryCode];
        NSString *currentCountryCodeInString = [currentCountry.code stringValue];
        
        if ([possibleCountryCodeFromNumberString isEqualToString: currentCountryCodeInString]) {
            
            //If country code will be equals "7" it makes additional check - Russia or Kazahstan, else returned recognized country
            return [currentCountry.code isEqual:@7] ?
            [self recognizeRussiaOrKazahstanNumberString:numberString] : currentCountry;
        }
    }
    return nil;
}

- (Country *)recognizeRussiaOrKazahstanNumberString:(NSString *)numberString {
    
    return [Country countryWithIdentifer:[numberString hasPrefix:@"77"] ? @"KZ" : @"RU"];
}


#pragma mark - Number formatters

- (NSString *)formatePhoneNumberString:(NSString *)numberString withCountry:(Country *)country {
    
    NSDictionary *numberFormatters = @{@"8" : @" (xx) xxx-xxx",
                                       @"9" : @" (xx) xxx-xx-xx",
                                      @"10" : @" (xxx) xxx-xx-xx"};
    
    //2 strings below will trim source string if it length > 12, and after trim coutry code
    NSString *sourceString = [numberString length] > 12 ? [numberString substringToIndex:12] : numberString;
    NSString *numberStringWithoutCountryCode = [sourceString substringFromIndex:[[country.code stringValue] length]];
    
    NSMutableString *resultString = [NSMutableString stringWithFormat:@"+%@", country.code];
    
    //Exception: no more left digits after country code trimming
    if ([numberStringWithoutCountryCode length] == 0) {
        
        return resultString;
    }
    
    NSString *formatterString = [numberFormatters valueForKey:[country.numberLength stringValue]];
    NSMutableString *currentNumberStringWithoutCountryCode = [NSMutableString stringWithString:numberStringWithoutCountryCode];
        
    for (NSUInteger i = 0; i < [formatterString length]; i++) {
        
        if ([currentNumberStringWithoutCountryCode length] == 0) {
            break;
        }
        
        NSString *currentCharacter = [formatterString substringWithRange:NSMakeRange(i, 1)];
        
        if ([currentCharacter isEqualToString:@"x"]) {
                
            [resultString appendString:[currentNumberStringWithoutCountryCode substringToIndex:1]];
            [currentNumberStringWithoutCountryCode deleteCharactersInRange:NSMakeRange(0, 1)];
                    
        } else {
            [resultString appendString:currentCharacter];
        }
    }
    return resultString;
}


#pragma mark - String processing

- (NSString *)string:(NSString *)string byDeletingCharactersFromSet:(NSCharacterSet *)characterSet {
    
    NSMutableString *result = [NSMutableString string];
    
    for (NSUInteger i = 0; i < [string length]; i++) {
        
        NSString *currentCharacter = [string substringWithRange:NSMakeRange(i, 1)];
        
        if ([currentCharacter rangeOfCharacterFromSet:characterSet].location == NSNotFound) {
            
            [result appendString:currentCharacter];
        }
    }
    return result;
}

@end
