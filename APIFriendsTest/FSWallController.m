//
//  FSWallController.m
//  APIFriendsTest
//
//  Created by Elerman on 16.01.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import "FSWallController.h"
#import "FSServerManager.h"
#import "FSWall.h"

@interface FSWallController ()

@property (strong,nonatomic) NSString *uID;
@property (strong,nonatomic) NSMutableArray *wallPostArray;
@property (assign,nonatomic) BOOL loadingData;


@end

@implementation FSWallController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.wallPostArray = [NSMutableArray array];
    self.loadingData = YES;
    
  //  dispatch_queue_t serialQueue = dispatch_queue_create("com.myapp.queue", NULL);
    
   

   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getWallInfo:(NSString*) userId{
    
    self.uID = userId;
    [[FSServerManager sharedManager]
     getWallById:userId
     count:3
     offset:[self.wallPostArray count]
     onSuccess:^(NSArray *wallPost) {
         
         
     }
     onFailure:^(NSError *error, NSInteger statusCode) {
         NSLog(@"error = %@, code = %ld", [error localizedDescription], statusCode);
     }];
    

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
        if (!self.loadingData)
        {
            self.loadingData = YES;
            [self getWallInfo:self.uID];
        }
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   
    return [self.wallPostArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* identifier = @"wallCell";

    UITableViewCell *wallCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!wallCell) {
        wallCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    FSWall *wall = [self.wallPostArray objectAtIndex:indexPath.row];
    
    /*wallCell.userImageView.image = wall.userPhoto;
    CALayer *imageLayer = wallCell.userImageView.layer;
    [imageLayer setCornerRadius:20];
    [imageLayer setBorderWidth:1];
    [imageLayer setBorderColor:[[UIColor grayColor] CGColor]];
    [imageLayer setMasksToBounds:YES];
    
    wallCell.dateLabel.text = wall.date;*/
    //wallCell.textPostLabel.text = [self stringByStrippingHTML:wall.text];
    return wallCell;
}


@end
