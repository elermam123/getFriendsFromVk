//
//  ViewController.m
//  APIFriendsTest
//
//  Created by Elerman on 12.01.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import "FSViewController.h"
#import "FSServerManager.h"
#import "FSUser.h"
#import "UIImageView+AFNetworking.h"


@interface FSViewController ()

@property (strong, nonatomic) NSMutableArray *friendsArray;

@end

@implementation FSViewController

static NSInteger friendsInRequest = 5;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.friendsArray = [NSMutableArray array];
    
    [self getFriendsFromServer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - API
- (void) getFriendsFromServer{
    
    [[FSServerManager sharedManager]
     getFriendsWithOffset:[self.friendsArray count]
     count:friendsInRequest
     onSuccess:^(NSArray *friends) {
         [self.friendsArray addObjectsFromArray:friends];
         
         NSMutableArray *newPaths = [NSMutableArray array];
         for(int i = (int)[self.friendsArray count] - (int)[friends count]; i < [self.friendsArray count]; i++){
             [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
         }
         
         [self.tableView beginUpdates];
         [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationTop];
         [self.tableView endUpdates];
         
         [self.tableView reloadData];
     }
     onFailure:^(NSError *error, NSInteger statusCode) {
         NSLog(@"error = %@, code = %ld", [error localizedDescription], statusCode);
     }];
    
}

#pragma mark
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.friendsArray count] + 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    static NSString* identifier = @"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if(indexPath.row  == [self.friendsArray count]){
        cell.textLabel.text = @"Load Next Friends ...";
        cell.imageView.image = nil;
    }
    else{
        
        FSUser* friend = [self.friendsArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", friend.firstName, friend.lastName];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:friend.imageUrl];
        
        __weak UITableViewCell *weakCell = cell;
        
        [cell.imageView
         setImageWithURLRequest:request
         placeholderImage:nil
         success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
             weakCell.imageView.image = image;
             [weakCell layoutSubviews];
         }failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
             
         }];
        
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row  == [self.friendsArray count]){
        
        [self getFriendsFromServer];
    
    }
}


@end
