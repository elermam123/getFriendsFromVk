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
        
        NSString* urlString = [responseObject objectForKey:@"photo_50"];
        if(urlString){
            self.imageUrl = [NSURL URLWithString:urlString];
        }
    }
    return self;
}

@end
