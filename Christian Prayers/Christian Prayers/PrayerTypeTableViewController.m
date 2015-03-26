//
//  PrayerTypeTableViewController.m
//  Christian Prayers
//
//  Created by Frankie on 3/13/15.
//  Copyright (c) 2015 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "PrayerTypeTableViewController.h"
#import "SimpleTableCell.h"
#import "SimpleTableCellExtended.h"
#import "MinuteSetupViewController.h"
#import <Parse/Parse.h>

@interface PrayerTypeTableViewController ()

@end

@implementation PrayerTypeTableViewController{
    BOOL showCellInfoExtended;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeInfoDark];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn addTarget:self action:@selector(toggleInfo) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)toggleInfo{
    NSLog(@"Enter");
     showCellInfoExtended = !showCellInfoExtended;
    
    [self loadObjects];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 147;
    }
    if (indexPath.row == 1) {
        return 33;
    }
    else {
        if (showCellInfoExtended) {
            static NSString *simpleTableIdentifier = @"SimpleTableCellExtended";
            
            SimpleTableCellExtended *cellExt = (SimpleTableCellExtended *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
            cellExt.extendedInfo.text = self.objects[indexPath.row-2][@"extendedInfo"];
            [cellExt AdjustToFittingHeight];
            
            return cellExt.cellHeight + 42;
        }
        else
            return 78;
    }
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

//Parse

- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // The className to query on
        self.parseClassName = @"PrayerType";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"name";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = NO;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = NO;
    }
    return self;
}

- (PFQuery *)queryForTable
{
    PFQuery *query;
    
    query = [PFQuery queryWithClassName:self.parseClassName];
    
    return query;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.objects.count>0){

        return self.objects.count+2;//Plus 2 for adding "Image and message" in categories
    }
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SimpleTableCell *cell;
    
    if (indexPath.row == 0) {
        return [tableView dequeueReusableCellWithIdentifier:@"SimpleTableCellTop"];
        
    }
    else if(indexPath.row == 1){
        return [tableView dequeueReusableCellWithIdentifier:@"SimpleTableCellInfo"];
    }
    
    if (showCellInfoExtended) {
        //cell.prepTimeLabel.hidden = NO;
        static NSString *simpleTableIdentifier = @"SimpleTableCellExtended";
        
        SimpleTableCellExtended *cellExt = (SimpleTableCellExtended *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        PFObject * object = [self.objects objectAtIndex:indexPath.row-2];
        
        cellExt.nameLabel.text = object[@"name"];
    
        cellExt.extendedInfo.text = object[@"extendedInfo"];
        [cellExt AdjustToFittingHeight];
        
        PFFile *thumbnail = [object objectForKey:@"thumbnail"];
        
        cellExt.thumbnailImageView.image = [UIImage imageNamed:@"thumbnail.png"];
        cellExt.thumbnailImageView.file = thumbnail;
        
        [cellExt.thumbnailImageView loadInBackground];
        
        return cellExt;
    }
    else{
        static NSString *simpleTableIdentifier = @"SimpleTableCell";
        
        cell = (SimpleTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        PFObject * object = [self.objects objectAtIndex:indexPath.row-2];

        cell.nameLabel.text = [object objectForKey:@"name"];
        
        PFFile *thumbnail = [object objectForKey:@"thumbnail"];
        
        cell.thumbnailImageView.image = [UIImage imageNamed:@"thumbnail.png"];
        cell.thumbnailImageView.file = thumbnail;
        
        [cell.thumbnailImageView loadInBackground];
        
    }
    
    return  cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *selectedIndex= [self.tableView indexPathForSelectedRow];
    
    UIViewController* vc = [segue destinationViewController];
    vc.navigationItem.title = self.objects[selectedIndex.row-2][@"name"];

}


@end
