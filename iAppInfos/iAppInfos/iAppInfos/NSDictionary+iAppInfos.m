//
//  NSDictionary+iAppInfos.m
//  iAppInfos
//
//  Created by Jerome Morissard on 11/21/13.
//  Copyright (c) 2013 Jerome Morissard. All rights reserved.
//

#import "NSDictionary+iAppInfos.h"
#import "JMOMobileProvisionning.h"

@implementation NSDictionary (MobileProvisionningParser)

+ (NSDictionary *)jmo_dictionaryWithMobileProvisioningString:(NSString *)RawMobileProvisionning
{
    NSMutableDictionary *dictionary =  [NSMutableDictionary new];
    NSArray* lines = [RawMobileProvisionning componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];

    for (int i = 0; i < lines.count; i++) {
        NSString *line = [lines objectAtIndex:i];
        if ([self lineString:line containsKey:MobileProvisioningAppIDName]) {
            NSString *nextLine = [lines objectAtIndex:i+1];
            NSString *appIDName = [self extractStringValueInLine:nextLine];
            if (appIDName.length > 0) {
                [dictionary setObject:appIDName forKey:MobileProvisioningAppIDName];
                continue;
            }
        }
        
        if ([self lineString:line containsKey:MobileProvisioningApplicationIdentifierPrefix]) {
            NSString *nextLine = [lines objectAtIndex:i+1];
            NSMutableArray *arryOfApplicationIdentifierPrefix = [NSMutableArray new];
            while ([nextLine rangeOfString:@"</array>"].location == NSNotFound) {
                NSString *value = [self extractStringValueInLine:nextLine];
                if (value.length > 0) {
                    [arryOfApplicationIdentifierPrefix addObject:value];
                }
                i++;
                nextLine = [lines objectAtIndex:i];
            }
            
            [dictionary setObject:arryOfApplicationIdentifierPrefix forKey:MobileProvisioningApplicationIdentifierPrefix];
        }

        if ([self lineString:line containsKey:MobileProvisioningCreationDate]) {
            NSString *nextLine = [lines objectAtIndex:i+1];
            NSString *creationDate = [self extractDateValueInLine:nextLine];
            if (nil != creationDate) {
                [dictionary setObject:creationDate forKey:MobileProvisioningCreationDate];
                continue;
            }
        }
        
        if ([self lineString:line containsKey:MobileProvisioningExpirationDate]) {
            NSString *nextLine = [lines objectAtIndex:i+1];
            NSString *creationDate = [self extractDateValueInLine:nextLine];
            if (nil != creationDate) {
                [dictionary setObject:creationDate forKey:MobileProvisioningExpirationDate];
                continue;
            }
        }
        
        if ([self lineString:line containsKey:MobileProvisioningName]) {
            NSString *nextLine = [lines objectAtIndex:i+1];
            NSString *name = [self extractStringValueInLine:nextLine];
            if (nil != name) {
                [dictionary setObject:name forKey:MobileProvisioningName];
                continue;
            }
        }
        
        if ([self lineString:line containsKey:MobileProvisioningProvisionedDevices]) {
            NSString *nextLine = [lines objectAtIndex:i+1];
            NSMutableArray *arryOfProvisionedDevices = [NSMutableArray new];
            while ([nextLine rangeOfString:@"</array>"].location == NSNotFound) {
                NSString *value = [self extractStringValueInLine:nextLine];
                if (value.length > 0) {
                    [arryOfProvisionedDevices addObject:value];
                }
                
                i++;
                nextLine = [lines objectAtIndex:i];
            }
            
            [dictionary setObject:arryOfProvisionedDevices forKey:MobileProvisioningProvisionedDevices];
            continue;
        }
        
        if ([self lineString:line containsKey:MobileProvisioningTeamName]) {
            NSString *nextLine = [lines objectAtIndex:i+1];
            NSString *creationDate = [self extractStringValueInLine:nextLine];
            if (nil != creationDate) {
                [dictionary setObject:creationDate forKey:MobileProvisioningTeamName];
                continue;
            }
        }
        
        if ([self lineString:line containsKey:MobileProvisioningGetTaskAllow]) {
            NSString *nextLine = [lines objectAtIndex:i+1];
            NSString *isDevMobileProvisioning = [self extractBoolValueInLine:nextLine];
            if (nil != isDevMobileProvisioning) {
                [dictionary setObject:isDevMobileProvisioning forKey:MobileProvisioningGetTaskAllow];
                continue;
            }
        }
        
        if ([self lineString:line containsKey:MobileProvisioningApsEnvironment]) {
            NSString *nextLine = [lines objectAtIndex:i+1];
            NSString *apsEnv = [self extractStringValueInLine:nextLine];
            if (nil != apsEnv) {
                [dictionary setObject:apsEnv forKey:MobileProvisioningApsEnvironment];
                continue;
            }

        }
    }
    
    return dictionary;
}

+ (BOOL)lineString:(NSString *)line containsKey:(NSString *)key
{
    if ([line rangeOfString:[NSString stringWithFormat:@"<key>%@</key>", key]].location != NSNotFound) {
        return YES;
    }
    return NO;
}

+ (NSString *)extractStringValueInLine:(NSString *)line
{
    NSRange rangeStart = [line rangeOfString:@"<string>"];
    NSRange rangeEnd = [line rangeOfString:@"</string>"];
    if (rangeStart.location != NSNotFound && rangeEnd.location != NSNotFound ) {
        return [line substringWithRange:NSMakeRange(rangeStart.location+rangeStart.length, rangeEnd.location - (rangeStart.location+rangeStart.length) )];
    }
    
    return @"";
}

+ (NSString *)extractDateValueInLine:(NSString *)line
{
    NSRange rangeStart = [line rangeOfString:@"<date>"];
    NSRange rangeEnd = [line rangeOfString:@"</date>"];
    if (rangeStart.location != NSNotFound && rangeEnd.location != NSNotFound ) {
        return [line substringWithRange:NSMakeRange(rangeStart.location+rangeStart.length, rangeEnd.location - (rangeStart.location+rangeStart.length) )];
    }
    
    return @"";
}

+ (NSString *)extractBoolValueInLine:(NSString *)line
{
    NSRange rangeTrue = [line rangeOfString:@"true"];
    if (rangeTrue.location != NSNotFound ) {
        return @"true";
    }
    
    return @"false";
}


@end
