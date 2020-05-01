//
//  Country.h
//  RSSchool_T5
//
//  Created by Dmitry Marchenko on 5/1/20.
//  Copyright © 2020 iOSLab. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Country : NSObject

@property (strong, nonatomic) NSString *identifer;
@property (strong, nonatomic) NSNumber *code;
@property (strong, nonatomic) NSNumber *numberLength;

+ (NSArray<Country *> *)allCountries;
+ (Country *)countryWithIdentifer:(NSString *)identifer;

@end

NS_ASSUME_NONNULL_END
