//
//  ViewController.m
//  InAppPurchaseTutorial
//
//  Created by Frankie on 6/27/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)PurchaseItem:(id)sender {
    _purchaseController = [self.storyboard instantiateViewControllerWithIdentifier:@"PurchaseIdentifier"];
    
    _purchaseController.productID = @"com.geekylemon.inappurchase.iap1";
    
    [self presentViewController:_purchaseController animated:YES completion:nil];
    
    [_purchaseController getProductID:self];
    //[self.navigationController pushViewController:_purchaseController animated:YES];
}

-(void)Purchased{
    self.label.text = @"item has been purchased";
}
@end
