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
#import "FSDetailViewController.h"
#import "UIImageView+AFNetworking.h"


@interface FSViewController ()

@property (strong, nonatomic) NSMutableArray *friendsArray;
@property (assign,nonatomic) BOOL loadingData;

@end

@implementation FSViewController

static NSInteger friendsInRequest = 10;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.friendsArray = [NSMutableArray array];
    self.loadingData = YES;
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
         self.loadingData = NO;
         
     }
     onFailure:^(NSError *error, NSInteger statusCode) {
         NSLog(@"error = %@, code = %ld", [error localizedDescription], statusCode);
     }];
    
}

#pragma mark
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.friendsArray count] ;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    static NSString* identifier = @"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    FSUser* friend = [self.friendsArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", friend.firstName, friend.lastName];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:friend.imageUrl_100];
    
    __weak UITableViewCell *weakCell = cell;
    
    [cell.imageView
     setImageWithURLRequest:request
     placeholderImage:nil
     success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
         weakCell.imageView.image = image;
         [weakCell layoutSubviews];
     }failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
         
     }];
    
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
        if (!self.loadingData)
        {
            self.loadingData = YES;
            [self getFriendsFromServer];
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"Detail"]) {
        NSLog(@"vse polu4ilosssss!!!!!");
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if(indexPath.row != [self.friendsArray count]){
            FSUser *friend = [self.friendsArray objectAtIndex:indexPath.row];
            FSDetailViewController *detailVC = [segue destinationViewController];
            [detailVC getFriendsDetailInfo:friend.userId];
        }
        
    }
    
}


@end
