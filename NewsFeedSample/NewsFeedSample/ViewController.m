//
//  ViewController.m
//  NewsFeedSample
//
//  Created by Tope Abayomi on 11/04/2014.
//  Copyright (c) 2014 App Design Vault. All rights reserved.
//

#import "ViewController.h"
#import "FeedCell.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray* profileImages;

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	

    [self styleNavigationBar];
    
    self.title = @"Feed";
    
    self.feedTableView.dataSource = self;
    self.feedTableView.delegate = self;
    
    self.feedTableView.backgroundColor = [UIColor whiteColor];
    self.feedTableView.separatorColor = [UIColor colorWithWhite:0.9 alpha:0.6];
    
    self.profileImages = [NSArray arrayWithObjects:@"profile.jpg", @"profile-1.jpg", @"profile-2.jpg", @"profile-3.jpg", nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if(indexPath.row % 2){
        
        FeedCell* cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
        
        cell.nameLabel.text = @"Laura Leamington";
        cell.updateLabel.text = @"This is a pic I took while on holiday on Wales. The weather played along nicely which doesn't happen often";
        
        cell.dateLabel.text = @"1 hr ago";
        cell.likeCountLabel.text = @"293 Likes";
        cell.commentCountLabel.text = @"55 Comments";
        
        NSString* profileImageName = self.profileImages[indexPath.row%self.profileImages.count];
        cell.profileImageView.image = [UIImage imageNamed:profileImageName];
        
        return cell;
    }
    else{
        
        FeedCell* cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell-Pic"];
        
        cell.nameLabel.text = @"John Keynetown";
        cell.updateLabel.text = @"On the trip to San Fransisco, the Golden gate bridge looked really magnificent. This is a city I would love to visit very often.";
        
        cell.dateLabel.text = @"1 hr ago";
        cell.likeCountLabel.text = @"134 Likes";
        cell.commentCountLabel.text = @"21 Comments";
        
        NSString* profileImageName = self.profileImages[indexPath.row%self.profileImages.count];
        cell.profileImageView.image = [UIImage imageNamed:profileImageName];
        
        cell.picImageView.image = [UIImage imageNamed:@"feed-bridge.jpg"];
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return (indexPath.row % 2) ? 125 : 251;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)styleNavigationBar{
    
    //NSString* navigationTitleFont = @"Avenir-Heavy";
    //UIColor* color = [UIColor colorWithRed:58.0/255 green:153.0/255 blue:216.0/255 alpha:1.0];
    
    NSString* navigationTitleFont = @"EuphemiaUCAS-Bold";
    UIColor* color = [UIColor colorWithRed:216.0/255 green:58.0/255 blue:58.0/255 alpha:1.0];

    self.navigationController.navigationBar.barTintColor = color;
    
    self.navigationController.navigationBar.titleTextAttributes =
  
        @{NSForegroundColorAttributeName : [UIColor whiteColor],
        NSFontAttributeName : [UIFont fontWithName:navigationTitleFont size:18.0f]
    };
    
    
    UIImageView* searchView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search.png"]];
    searchView.frame = CGRectMake(0, 0, 20, 20);
    
    UIBarButtonItem* searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchView];
    
    self.navigationItem.rightBarButtonItem = searchItem;
    
    UIButton* menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 28, 20)];
    [menuButton setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(dismissView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* menuItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    self.navigationItem.leftBarButtonItem = menuItem;
}

-(IBAction)dismissView:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


//NSString* navigationTitleFont = @"EuphemiaUCAS-Bold";
//UIColor* color = [UIColor colorWithRed:216.0/255 green:58.0/255 blue:58.0/255 alpha:1.0];


@end
