//
//  PurchaseViewController.h
//  InAppPurchaseTutorial
//
//  Created by Frankie on 6/27/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface PurchaseViewController : UIViewController <SKPaymentTransactionObserver,SKProductsRequestDelegate>

@property(strong,nonatomic)SKProduct *product;
@property(strong,nonatomic)NSString *productID;


@property (weak, nonatomic) IBOutlet UILabel *productTitle;
@property (weak, nonatomic) IBOutlet UITextView *productDescription;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;

- (IBAction)GoBack:(id)sender;
- (IBAction)BuyProduct:(id)sender;
- (IBAction)Restore:(id)sender;

-(void)getProductID:(UIViewController *)viewController;

@end
