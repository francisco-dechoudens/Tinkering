//
//  RKCardFeedController.m
//  RKCardFeedController
//
//  Created by Richard Kim on 8/26/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//

#import "RKCardFeedController.h"
#import "RKCardCell.h"

@interface RKCardFeedController () {
    NSArray *photoArray;
    NSArray *titleArray;
    NSArray *nameArray;
    NSArray *descriptionArray;
    NSArray *introductionArray;
    NSArray *cardSizeArray;

}

@end

@implementation RKCardFeedController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadExampleData];
    self.tableView.separatorColor = [UIColor clearColor];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo.png"]];
    
    self.view.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1]; //%%% This is so if you overscroll, the color is still gray
    
    self.tableView.contentSize = CGSizeMake(self.view.frame.size.width, 1000);
    self.originalFrame = self.tabBarController.tabBar.frame;
}

-(void)loadExampleData
{
    /* 
     this is just example data and you shouldn't be using your table like this because it's static.  
     For example, if you want to have a news feed, you should be using an NSMutableArray and pulling 
     the information from the internet somehow.  If you'd like some help figuring out the logistics, 
     I'd be happy to help, contact me at cwrichardkim@gmail.com or twitter: @cwRichardKim
     */
    photoArray = [[NSArray alloc]initWithObjects:@"1",@"2",@"3", nil];
    titleArray = [[NSArray alloc]initWithObjects:@"Mayaguez's Zoo",@"Botanical Garden",@"Castillo San Cristobal", nil];
    nameArray = [[NSArray alloc]initWithObjects:@"Mayaguez's Zoo",@"Botanical Garden",@"Castillo San Cristobal", nil];
    descriptionArray = [[NSArray alloc]initWithObjects:@"Mayaguez's Zoo",@"Botanical Garden",@"Castillo San Cristobal", nil];
    introductionArray = [[NSArray alloc]initWithObjects:@"Dr. Juan A. Rivero Zoo is a 45-acre zoo located in Mayagüez, Puerto Rico. It is the only zoo on the island. It is named in honor of Juan A. Rivero, its first director. Wikipedia",@"The production and trade of sugar constituted inseparable elements of Caribbean evolution of the last century. In the Botanical Garden Cultural William Miranda Marín appear as witnesses, the centennial ruins of the old sugar mill San José, as well as traces of slave labor, whose invaluable sacrifice, represented an important element in the development of Creole personality. Also, important archaeological sites in the Taino Indians who inhabited Boriken -name Aboriginal Puerto Rico, pieces dating from pre-Columbian times until the time of the Spanish colonization are located.",@"Castillo de San Cristóbal is the largest fortification built by the Spanish in the New World. When it was finished in 1783, it covered about 27 acres of land and basically wrapped around the city of San Juan. Entry to the city was sealed by San Cristóbal's double gates. After close to one hundred years of relative peace in the area, part of the fortification (about a third) was demolished in 1897 to help ease the flow of traffic in and out of the walled city.", nil];
    cardSizeArray = [[NSArray alloc]initWithObjects:@300,@500,@400, nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //%%% this is asking for the number in the cardSizeArray.  If you're seriously
    // thinking about making your cards dynamic, they should depend on something more reliable
    // for example, facebook's post sizes depend on whether it's a status update or photo, etc
    // so there should be a switch statement in here that returns different heights depending on
    // what kind of post it is.  Also, don't forget to change the height of the
    // cardView if you use dynamic cards
    return [((NSNumber*)[cardSizeArray objectAtIndex:indexPath.row])intValue];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning you're going to want to change this
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning you're going to want to change this
    return 3;
}

//creates cell with a row number (0,1,2, etc), sets the name and description as strings from event object
//from _events
//called after hitting "activate" button, numberOfSectionsInTableView times per event
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RKCardCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"RKCardCell"];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[RKCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RKCardCell"];
    }
    
    cell.profileImage.image = [UIImage imageNamed:[photoArray objectAtIndex:indexPath.row]];
    cell.titleLabel.text = [titleArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = [nameArray objectAtIndex:indexPath.row];
    cell.descriptionLabel.text = [descriptionArray objectAtIndex:indexPath.row];
    cell.introductionTextView.text = [introductionArray objectAtIndex:indexPath.row];
    
    cell.postImageView.image = [UIImage imageNamed:[photoArray objectAtIndex:indexPath.row]];
   
    
    //%%% I made the cards pseudo dynamic, so I'm asking the cards to change their frames depending on the height of the cell
    cell.cardView.frame = CGRectMake(10, 5, 300, [((NSNumber*)[cardSizeArray objectAtIndex:indexPath.row])intValue]-10);
    
 
    
    cell.nameLabel.frame = CGRectMake(8, cell.cardView.frame.size.height-100, 180, 21);
    cell.descriptionLabel.frame = CGRectMake(8, cell.cardView.frame.size.height-70, 168, 21);
    cell.introductionTextView.frame = CGRectMake(68, 28, 226, cell.cardView.frame.size.height-200);
    
    cell.postImageView.frame = CGRectMake(66, cell.introductionTextView.frame.size.height, 226, 66);
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGRect frame = self.navigationController.navigationBar.frame;
    CGFloat size = frame.size.height - 21;
    CGFloat framePercentageHidden = ((20 - frame.origin.y) / (frame.size.height - 1));
    CGFloat scrollOffset = scrollView.contentOffset.y;
    CGFloat scrollDiff = scrollOffset - self.previousScrollViewYOffset;
    CGFloat scrollHeight = scrollView.frame.size.height;
    CGFloat scrollContentSizeHeight = scrollView.contentSize.height + scrollView.contentInset.bottom;
    
    if (scrollOffset <= -scrollView.contentInset.top) {
        frame.origin.y = 20;
    } else if ((scrollOffset + scrollHeight) >= scrollContentSizeHeight) {
        frame.origin.y = -size;
    } else {
        frame.origin.y = MIN(20, MAX(-size, frame.origin.y - scrollDiff));
    }
    
    [self.navigationController.navigationBar setFrame:frame];
    [self updateBarButtonItems:(1 - framePercentageHidden)];
    self.previousScrollViewYOffset = scrollOffset;
    
    //tab bar
    
    UITabBar *tb = self.tabBarController.tabBar;
    NSInteger yOffset = scrollView.contentOffset.y;
    if (yOffset > 0) {
        tb.frame = CGRectMake(tb.frame.origin.x, self.originalFrame.origin.y + yOffset, tb.frame.size.width, tb.frame.size.height);
    }
    if (yOffset < 1) tb.frame = self.originalFrame;

}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self stoppedScrolling];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self stoppedScrolling];
    }
}

- (void)stoppedScrolling
{
    CGRect frame = self.navigationController.navigationBar.frame;
    if (frame.origin.y < 20) {
        [self animateNavBarTo:-(frame.size.height - 21)];
    }
}

- (void)updateBarButtonItems:(CGFloat)alpha
{
    [self.navigationItem.leftBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem* item, NSUInteger i, BOOL *stop) {
        item.customView.alpha = alpha;
    }];
    [self.navigationItem.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem* item, NSUInteger i, BOOL *stop) {
        item.customView.alpha = alpha;
    }];
    self.navigationItem.titleView.alpha = alpha;
    self.navigationController.navigationBar.tintColor = [self.navigationController.navigationBar.tintColor colorWithAlphaComponent:alpha];
}

- (void)animateNavBarTo:(CGFloat)y
{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.navigationController.navigationBar.frame;
        CGFloat alpha = (frame.origin.y >= y ? 0 : 1);
        frame.origin.y = y;
        [self.navigationController.navigationBar setFrame:frame];
        [self updateBarButtonItems:alpha];
    }];
}

@end
