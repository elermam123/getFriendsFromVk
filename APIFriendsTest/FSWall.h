//
//  FSWall.h
//  APIFriendsTest
//
//  Created by Elerman on 16.01.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSWall : NSObject

@property (strong,nonatomic) NSString *text;
@property (strong,nonatomic) NSString *date;
@property (strong,nonatomic) NSString *postImageURL;
//@property (strong,nonatomic) UIImage *userPhoto;
//@property (strong,nonatomic) UIImage *postPhoto;

-(id) initWithServerResponse:(NSDictionary*) responseObject;

@end
