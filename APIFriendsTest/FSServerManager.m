//
//  FSServerManager.m
//  APIFriendsTest
//
//  Created by Elerman on 12.01.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import "FSServerManager.h"
#import "FSUser.h"
#import "AFNetworking.h"
#import "FSWall.h"

@interface FSServerManager ()

@property (strong, nonatomic) AFHTTPSessionManager *requestOperationManager;

@end

@implementation FSServerManager

+ (FSServerManager*) sharedManager{
    
    static FSServerManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FSServerManager alloc] init];
    });
    
    
    return manager;
}

- (id) init{
    self = [super init];
    if(self){
        
        NSURL* url = [NSURL URLWithString:@"https://api.vk.com/method/"];
        
        self.requestOperationManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
    
    return self;
}

- (void) getFriendsWithOffset:(NSInteger) offset
                        count:(NSInteger) count
                    onSuccess:(void(^)(NSArray* friends)) success
                    onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
  
    NSDictionary* params =
    [NSDictionary dictionaryWithObjectsAndKeys:
     @"5787951",    @"user_id",
     @"name",       @"order",
     @(count),      @"count",
     @(offset),     @"offset",
     @"photo_100",   @"fields",
     @"nom",        @"name_case", nil];
    
    
    [self.requestOperationManager
     GET:@"friends.get"
     parameters:params
     progress:nil
     success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
         
        NSArray* dictsArray = [responseObject objectForKey:@"response"];
        
         NSMutableArray* objectsArray = [NSMutableArray array];
         
         for(NSDictionary* dict in dictsArray){
             FSUser* user = [[FSUser alloc] initWithServerResponse:dict];
             [objectsArray addObject:user];
         }
         
         
         if(success){
             success(objectsArray);
         }
         
         
     } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
         
         if(failure){
             //failure(error, operation.);
         }
         
    }];
    
    
    
}


- (void) getFriendInfoById:(NSString*) userID
                 onSuccess:(void(^)(NSArray* friends)) success
                 onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
    
    
    NSDictionary* params =
    [NSDictionary dictionaryWithObjectsAndKeys:
     userID,                                   @"user_ids",
     @"city, bdate, sex, photo_100, online",   @"fields",
     @"nom",                                   @"name_case", nil];
    
    
    [self.requestOperationManager
     GET:@"users.get?v=5.62"
     parameters:params
     progress:nil
     success:^(NSURLSessionTask *task, id responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         NSArray* dictsArray = [responseObject objectForKey:@"response"];
         
         NSMutableArray* objectsArray = [NSMutableArray array];
         
         for(NSDictionary* dict in dictsArray){
             FSUser* user = [[FSUser alloc] initWithServerResponse:dict];
             [objectsArray addObject:user];
         }
         
         
         if(success){
             success(objectsArray);
         }
         
         
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if(failure){
             //failure(error, operation.);
         }
         
     }];
    
}

- (void) getWallById:(NSString*) userID
               count:(NSInteger) count
              offset:(NSInteger) offset
           onSuccess:(void(^)(NSArray* friends)) success
           onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
    
    NSDictionary* params =
    [NSDictionary dictionaryWithObjectsAndKeys:
     userID,           @"owner_id",
     @(count),      @"count",
     @(offset),     @"offset",
     @"owner",      @"filter", nil];
    
    [self.requestOperationManager
     GET:@"wall.get?v=3.0"
     parameters:params
     progress:nil
     success:^(NSURLSessionTask *task, id responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         NSArray* dictsArray = [responseObject objectForKey:@"response"];
         
         NSMutableArray* objectsArray = [NSMutableArray array];
         
         for (int i = 1; i < [dictsArray count]; i++) {
             
             FSWall *wall = [[FSWall alloc] initWithServerResponse:[dictsArray objectAtIndex:i]];
             [objectsArray addObject:wall];
             
         }
         
         
         
         if(success){
             success(objectsArray);
         }
         
         
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if(failure){
             //failure(error, operation.);
         }
         
     }];


    
    
}




@end
