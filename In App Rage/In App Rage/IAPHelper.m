//
//  IAPHelper.m
//  In App Rage
//
//  Created by Frankie on 8/18/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//


#import "IAPHelper.h"
#import <StoreKit/StoreKit.h>

NSString *const IAPHelperProductPurchasedNotification = @"IAPHelperProductPurchasedNotification";
NSString *const kSubscriptionExpirationDateKey = @"ExpirationDate";

@interface IAPHelper () <SKProductsRequestDelegate, SKPaymentTransactionObserver>
@end

@implementation IAPHelper {
    SKProductsRequest * _productsRequest;
    RequestProductsCompletionHandler _completionHandler;
    NSSet * _productIdentifiers;
    NSMutableSet * _purchasedProductIdentifiers;
}

- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers {
    
    if ((self = [super init])) {
        
        // Store product identifiers
        _productIdentifiers = productIdentifiers;
        
        // Check for previously purchased products
        _purchasedProductIdentifiers = [NSMutableSet set];
        for (NSString * productIdentifier in _productIdentifiers) {
            BOOL productPurchased = [[NSUserDefaults standardUserDefaults] boolForKey:productIdentifier];
            if (productPurchased) {
                [_purchasedProductIdentifiers addObject:productIdentifier];
                NSLog(@"Previously purchased: %@", productIdentifier);
            } else {
                NSLog(@"Not purchased: %@", productIdentifier);
            }
        }
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}

- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler {
    

    _completionHandler = [completionHandler copy];
    
    _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:_productIdentifiers];
    _productsRequest.delegate = self;
    [_productsRequest start];
    
}

- (BOOL)productPurchased:(NSString *)productIdentifier {
    return [_purchasedProductIdentifiers containsObject:productIdentifier];
}

- (void)buyProduct:(SKProduct *)product {
    
    NSLog(@"Buying %@...", product.productIdentifier);
    
    SKPayment * payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction * transaction in transactions) {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
            default:
                break;
        }
    };
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    NSLog(@"completeTransaction...");
    
    [self provideContentForProductIdentifier:transaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    NSLog(@"restoreTransaction...");
    
    [self provideContentForProductIdentifier:transaction.originalTransaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    
    NSLog(@"failedTransaction...");
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        NSLog(@"Transaction error: %@", transaction.error.localizedDescription);
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void)provideContentForProductIdentifier:(NSString *)productIdentifier {
    
    if ([productIdentifier isEqualToString:@"com.razeware.inappragedemo.randomragefaces"]) {
        int currentValue = [[NSUserDefaults standardUserDefaults] integerForKey:@"com.razeware.inappragedemo.randomragefaces"];
        currentValue += 5;
        [[NSUserDefaults standardUserDefaults] setInteger:currentValue forKey:@"com.razeware.inappragedemo.randomragefaces"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if ([productIdentifier hasSuffix:@"monthlyrageface"]) {
        if ([productIdentifier isEqualToString:@"com.razeware.inappragedemo.3monthlyrage"]) {
            [self purchaseSubscriptionWithMonths:3];
        } else {
            [self purchaseSubscriptionWithMonths:6];
        }
        // End of new code
    } else {
        [_purchasedProductIdentifiers addObject:productIdentifier];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:productIdentifier];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:IAPHelperProductPurchasedNotification object:productIdentifier userInfo:nil];
}

- (void)restoreCompletedTransactions {
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}


- (int)daysRemainingOnSubscription {
    
    NSDate *expirationDate = [[NSUserDefaults standardUserDefaults]
                              objectForKey:kSubscriptionExpirationDateKey];
    
    NSTimeInterval timeInt = [expirationDate timeIntervalSinceDate:[NSDate date]];
    
    int days = timeInt / 60 / 60 / 24;
    
    if (days > 0) {
        return days;
    }
    else {
        return 0;
    }
}

- (NSDate *)getExpirationDateForMonths:(int)months {
    
    NSDate *originDate = nil;
    
    if ([self daysRemainingOnSubscription] > 0) {
        originDate = [[NSUserDefaults standardUserDefaults]
                      objectForKey:kSubscriptionExpirationDateKey];
    }
    else {
        originDate = [NSDate date];
    }
    
    NSDateComponents *dateComp = [[NSDateComponents alloc] init];
    [dateComp setMonth:months];
    [dateComp setDay:1]; //add an extra day to subscription because we love our users
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComp
                                                         toDate:originDate
                                                        options:0];
}

- (NSString *)getExpirationDateString {
    if ([self daysRemainingOnSubscription] > 0) {
        NSDate *today = [[NSUserDefaults standardUserDefaults] objectForKey:kSubscriptionExpirationDateKey];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        return [NSString stringWithFormat:@"Subscribed! \nExpires: %@ (%i Days)",[dateFormat stringFromDate:today],[self daysRemainingOnSubscription]];
    } else {
        return @"Not Subscribed";
    }
}

- (void)purchaseSubscriptionWithMonths:(int)months {
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    
    [query getObjectInBackgroundWithId:[PFUser currentUser].objectId block:^(PFObject *object, NSError *error) {
        
        NSDate * serverDate = [[object objectForKey:kSubscriptionExpirationDateKey] lastObject];
        NSDate * localDate = [[NSUserDefaults standardUserDefaults] objectForKey:kSubscriptionExpirationDateKey];
        
        if ([serverDate compare:localDate] == NSOrderedDescending) {
            [[NSUserDefaults standardUserDefaults] setObject:serverDate forKey:kSubscriptionExpirationDateKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        NSDate * expirationDate = [self getExpirationDateForMonths:months];
        
        [object addObject:expirationDate forKey:kSubscriptionExpirationDateKey];
        [object saveInBackground];
        
        [[NSUserDefaults standardUserDefaults] setObject:expirationDate forKey:kSubscriptionExpirationDateKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    	NSLog(@"Subscription Complete!");
    }];
}

#pragma mark - SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
    NSLog(@"Loaded list of products...");
    _productsRequest = nil;
    
    NSArray * skProducts = response.products;
    for (SKProduct * skProduct in skProducts) {
        NSLog(@"Found product: %@ %@ %0.2f",
              skProduct.productIdentifier,
              skProduct.localizedTitle,
              skProduct.price.floatValue);
    }
    
    _completionHandler(YES, skProducts);
    _completionHandler = nil;
    
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    
    NSLog(@"Failed to load list of products.");
    NSLog(@"%@",error);
    _productsRequest = nil;
    
    _completionHandler(NO, nil);
    _completionHandler = nil;
    
}

@end

