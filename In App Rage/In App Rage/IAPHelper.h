//
//  IAPHelper.h
//  In App Rage
//
//  Created by Frankie on 8/18/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import <Parse/Parse.h>

UIKIT_EXTERN NSString *const IAPHelperProductPurchasedNotification;
UIKIT_EXTERN NSString *const kSubscriptionExpirationDateKey;

typedef void (^RequestProductsCompletionHandler)(BOOL success, NSArray * products);

@interface IAPHelper : NSObject

- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers;
- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler;

- (void)buyProduct:(SKProduct *)product;
- (BOOL)productPurchased:(NSString *)productIdentifier;

- (void)restoreCompletedTransactions;

- (int)daysRemainingOnSubscription;
- (NSString *)getExpirationDateString;
- (NSDate *)getExpirationDateForMonths:(int)months;
- (void)purchaseSubscriptionWithMonths:(int)months;

@end