//
//  ViewController.h
//  InAppPurchaseTutorial
//
//  Created by Frankie on 6/27/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import "PurchaseViewController.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *label;
- (IBAction)PurchaseItem:(id)sender;

@property (strong, nonatomic) PurchaseViewController *purchaseController;

-(void)Purchased;
@end
