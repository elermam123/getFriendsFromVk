//
//  FSDetailViewController.m
//  APIFriendsTest
//
//  Created by Elerman on 13.01.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import "FSDetailViewController.h"
#import "FSServerManager.h"
#import "UIImageView+AFNetworking.h"
#import "FSUser.h"

@interface FSDetailViewController ()

@end

@implementation FSDetailViewController

-(id) initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getFriendsDetailInfo:(NSString*) userID{
    NSLog(@"userID = %@", userID);
    [[FSServerManager sharedManager]
     getFriendInfoById:userID
     onSuccess:^(NSArray *friends) {
         FSUser *user = [friends firstObject];
         self.friendFullName.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
         
         if(user.cityTitle){
             self.friendCity.text = user.cityTitle;
         }
        
         
         NSInteger isOnline  = [user.isOnline integerValue];
         NSString*  onlineStr = isOnline == 1 ?  @"Online" : @"Offline";
         self.online.text = onlineStr;
         
         if(user.bDate){
             self.bDate.text  = user.bDate;
         }
         else{
             self.bDate.text = @"";
         }
         NSInteger sexVar = [user.sex integerValue];
         NSString* sexText = sexVar == 1 ? @"Female" : @"Male";
         self.sex.text = sexText;
         
         NSURLRequest *request = [NSURLRequest requestWithURL:user.imageUrl_100];
         
         self.friendAvatar.image = nil;
         
         [self.friendAvatar
          setImageWithURLRequest:request
          placeholderImage:nil
          success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
              self.friendAvatar.image = image;
              [self.friendAvatar layoutSubviews];
          }failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
              
          }];

         
     }
     onFailure:^(NSError *error, NSInteger statusCode) {
         NSLog(@"error = %@, code = %ld", [error localizedDescription], statusCode);
     }];

    
}

@end
