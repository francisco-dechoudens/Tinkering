//
//  ViewController.h
//  NewsFeedSample
//
//  Created by Tope Abayomi on 11/04/2014.
//  Copyright (c) 2014 App Design Vault. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView* feedTableView;

@end
