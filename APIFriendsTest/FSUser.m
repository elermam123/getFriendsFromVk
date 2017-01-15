//
//  FSUser.m
//  APIFriendsTest
//
//  Created by Elerman on 12.01.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import "FSUser.h"

@implementation FSUser

-(id) initWithServerResponse:(NSDictionary*) responseObject
{
    self = [super init];
    if (self) {
        self.firstName = [responseObject objectForKey:@"first_name"];
        self.lastName = [responseObject objectForKey:@"last_name"];
        self.userId = [responseObject objectForKey:@"user_id"];
        
        NSDictionary *cityObject  = [responseObject objectForKey:@"city"];
        self.cityTitle = [cityObject objectForKey:@"title"];
        
        self.bDate = [responseObject objectForKey:@"bdate"];
        self.sex = [responseObject objectForKey:@"sex"];
        self.isOnline = [responseObject objectForKey:@"online"];
        
        NSString* urlString_photo50 = [responseObject objectForKey:@"photo_50"];
        if(urlString_photo50){
            self.imageUrl_50 = [NSURL URLWithString:urlString_photo50];
        }

        NSString* urlString_photo100 = [responseObject objectForKey:@"photo_100"];
        if(urlString_photo100){
            self.imageUrl_100 = [NSURL URLWithString:urlString_photo100];
        }

        
    }
    return self;
}

@end
