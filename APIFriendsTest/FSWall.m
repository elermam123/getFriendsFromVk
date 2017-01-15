//
//  FSWall.m
//  APIFriendsTest
//
//  Created by Elerman on 16.01.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import "FSWall.h"
#import "UIImageView+AFNetworking.h"

@implementation FSWall

- (instancetype)initWithServerResponse:(NSDictionary *) responseObject {
    
    self = [super init];
    if (self) {
        self.text = [responseObject objectForKey:@"text"];
        
        NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
        [dateFormater setDateFormat:@"dd MMM yyyy "];
        NSDate *dateTime = [NSDate dateWithTimeIntervalSince1970:[[responseObject objectForKey:@"date"] floatValue]];
        NSString *date = [dateFormater stringFromDate:dateTime];
        self.date = date;
        
        NSDictionary *dict = [responseObject objectForKey:@"attachment"];
        NSDictionary *dictTemp = [dict objectForKey:@"photo"];
        
        self.postImageURL = [dictTemp objectForKey:@"src_big"];
    }
    return self;
}


@end
