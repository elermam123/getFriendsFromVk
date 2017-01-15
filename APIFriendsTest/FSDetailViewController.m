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
#import "FSWallController.h"

@interface FSDetailViewController ()

@property (strong,nonatomic) NSString *uID;

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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void) getFriendsDetailInfo:(NSString*) userID{
    NSLog(@"userID = %@", userID);
    self.uID = userID;
    [[FSServerManager sharedManager]
     getFriendInfoById:userID
     onSuccess:^(NSArray *friends) {
         FSUser *user = [friends firstObject];
         self.friendFullName.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
         
         if(user.cityTitle){
             self.friendCity.text = user.cityTitle;
         }
         else{
             self.friendCity.text = @"";
         }
         
         NSInteger isOnline  = [user.isOnline integerValue];
         NSString*  onlineStr = isOnline == 1 ?  @"Online" : @"Offline";
         UIColor *color = isOnline == 1 ? [UIColor greenColor] : [UIColor lightGrayColor];
         self.online.textColor = color;
         self.online.text = onlineStr;
         
         if(user.bDate){
             self.bDate.text  = user.bDate;
         }
         else{
             self.bDate.text = @"--.--.--";
             self.bDate.textColor = [UIColor lightGrayColor];
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
              CALayer *imageLayer = self.friendAvatar.layer;
              [imageLayer setCornerRadius:46];
              [imageLayer setBorderWidth:2];
              [imageLayer setBorderColor:[[UIColor grayColor] CGColor]];
              [imageLayer setMasksToBounds:YES];
              
              
              [self.friendAvatar layoutSubviews];
          }failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
              
          }];

         
     }
     onFailure:^(NSError *error, NSInteger statusCode) {
         NSLog(@"error = %@, code = %ld", [error localizedDescription], statusCode);
     }];

}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"wallInfo"]) {
        NSLog(@"Enter to WALLLLL!!!!!");
        
        FSWallController *wallVC = [segue destinationViewController];
        [wallVC getWallInfo:self.uID];
        
       // FSDetailViewController *detailVC = [segue destinationViewController];
        //[detailVC getFriendsDetailInfo:friend.userId];
        
        
    }
    
}

@end
