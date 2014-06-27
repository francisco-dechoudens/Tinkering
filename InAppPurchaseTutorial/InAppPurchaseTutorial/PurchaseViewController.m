//
//  PurchaseViewController.m
//  InAppPurchaseTutorial
//
//  Created by Frankie on 6/27/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "PurchaseViewController.h"
#import "ViewController.h"

@interface PurchaseViewController ()
@property(strong,nonatomic) ViewController *homeViewController;
@end

@implementation PurchaseViewController

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
    // Do any additional setup after loading the view.
    
    _buyButton.enabled = NO;
    //[self getProductID:_homeViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)GoBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)BuyProduct:(id)sender {
    SKPayment *payment = [SKPayment paymentWithProduct:_product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

//If was bought previosly and by some problem it delete the app and installed again can restore the buy
- (IBAction)Restore:(id)sender {
    [[SKPaymentQueue defaultQueue]addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue]restoreCompletedTransactions];
}

-(void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue{
    [self UnlockPurchase];
}

-(void)getProductID:(ViewController *)viewController{
    _homeViewController = viewController;
    if ([SKPaymentQueue canMakePayments]) {
        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:self.productID]];
        
        request.delegate = self;
        
        [request start];
    }
    else{
        _productDescription.text = @"Please enable in app purchase in your settings";
    }
}

#pragma mark _
#pragma mark SKProductsRequestDelgate

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
    NSArray *products = response.products;
    
    if (products.count != 0) {
        _product = products[0];
        _buyButton.enabled = YES;
        _productTitle.text = _product.localizedTitle;
        _productDescription.text = _product.localizedDescription;
    }
    else{
        _productTitle.text = @"Product Not Found";
    }
    
    products = response.invalidProductIdentifiers;
    
    for (SKProduct *product in products) {
        NSLog(@"Product not Found: %@",product); //Display what kind of error, that is causing to not been found
    }
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"%@",error);
}

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:[self UnlockPurchase];
                [[SKPaymentQueue defaultQueue]finishTransaction:transaction];
                break;
                
            case SKPaymentTransactionStateFailed:NSLog(@"Transaction Failed");
                [[SKPaymentQueue defaultQueue]finishTransaction:transaction];
                break;
            default:
                break;
        }
    }
}

-(void)UnlockPurchase{
    _buyButton.enabled = NO;
    [_buyButton setTitle:@"Purchased" forState:UIControlStateDisabled];
    [_homeViewController Purchased];
}


@end
