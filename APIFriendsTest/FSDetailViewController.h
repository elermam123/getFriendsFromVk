//
//  FSDetailViewController.h
//  APIFriendsTest
//
//  Created by Elerman on 13.01.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSDetailViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIImageView *friendAvatar;

@property (weak, nonatomic) IBOutlet UILabel *friendFullName;

@property (weak, nonatomic) IBOutlet UILabel *friendCity;
@property (weak, nonatomic) IBOutlet UILabel *bDate;

@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UILabel *online;


-(void) getFriendsDetailInfo:(NSString*) userID;


@end
