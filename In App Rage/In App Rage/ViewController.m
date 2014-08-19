//
//  ViewController.m
//  In App Rage
//
//  Created by Frankie on 8/18/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "RageIAPHelper.h"
#import <StoreKit/StoreKit.h>

@interface ViewController (){
    NSArray *_products;
    NSNumberFormatter * _priceFormatter;
}
@property(nonatomic,strong) UIRefreshControl* refreshControl;
@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PFLogInViewController *logInController = [[PFLogInViewController alloc] init];
    logInController.delegate = self;
    [self presentViewController:logInController animated:YES completion:nil];
    
    PFSignUpViewController *signUpController = logInController.signUpController;
    signUpController.fields = PFSignUpFieldsUsernameAndPassword
    | PFSignUpFieldsSignUpButton
    | PFSignUpFieldsDismissButton;
    signUpController.delegate = logInController;
    
    self.title = @"In App Rage";
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reload) forControlEvents:UIControlEventValueChanged];
    [self reload];
    [self.refreshControl beginRefreshing];
    
    _priceFormatter = [[NSNumberFormatter alloc] init];
    [_priceFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [_priceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Restore" style:UIBarButtonItemStyleBordered target:self action:@selector(restoreTapped:)];
    
}

- (void)logInViewController:(PFLogInViewController *)controller
               didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)reload {
    _products = nil;
    [self.tableView reloadData];
    [[RageIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        if (success) {
            _products = products;
            [self.tableView reloadData];
        }
        [self.refreshControl endRefreshing];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)productPurchased:(NSNotification *)notification {
    
    NSString * productIdentifier = notification.object;
    [_products enumerateObjectsUsingBlock:^(SKProduct * product, NSUInteger idx, BOOL *stop) {
        if ([product.productIdentifier isEqualToString:productIdentifier]) {
            if ([product.productIdentifier hasSuffix:@"monthlyrage"]) {
                [self reload];
                [self.refreshControl beginRefreshing];
            } else {
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            }
            *stop = YES;
        }
    }];
}

- (void)restoreTapped:(id)sender {
    [[RageIAPHelper sharedInstance] restoreCompletedTransactions];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"inAppCell" forIndexPath:indexPath];
    
    SKProduct * product = (SKProduct *) _products[indexPath.row];
    cell.textLabel.text = product.localizedTitle;
    
    [_priceFormatter setLocale:product.priceLocale];
    cell.detailTextLabel.text = [_priceFormatter stringFromNumber:product.price];
    
    if (![product.productIdentifier isEqualToString:@"com.razeware.inapprage.randomrageface"] && [[RageIAPHelper sharedInstance] productPurchased:product.productIdentifier]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.accessoryView = nil;
    } else {
        UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        buyButton.frame = CGRectMake(0, 0, 72, 37);
        [buyButton setTitle:@"Buy" forState:UIControlStateNormal];
        buyButton.tag = indexPath.row;
        [buyButton addTarget:self action:@selector(buyButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryView = buyButton;
    }
    
    return cell;
}

- (void)buyButtonTapped:(id)sender {
    
    UIButton *buyButton = (UIButton *)sender;
    SKProduct *product = _products[buyButton.tag];
    
    NSLog(@"Buying %@...", product.productIdentifier);
    [[RageIAPHelper sharedInstance] buyProduct:product];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if(indexPath.row == 2){

        [self performSegueWithIdentifier:@"segueId" sender:self];
    //}
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segueId"]) {
        SecondViewController *detailViewController = (SecondViewController *) segue.destinationViewController;
        SKProduct *product = (SKProduct *) _products[self.tableView.indexPathForSelectedRow.row];
        
        // this is the statement you need to modify
        if ([[RageIAPHelper sharedInstance] productPurchased:product.productIdentifier] ||
			[[RageIAPHelper sharedInstance] daysRemainingOnSubscription] > 0) {
            
            if ([product.productIdentifier isEqualToString:@"com.youridentifier.inapprage.drummerrage"]) {
                detailViewController.image = [UIImage imageNamed:@"drummer.png"];
            } else if ([product.productIdentifier isEqualToString:@"com.youridentifier.inapprage.itunesconnectrage"]) {
                detailViewController.image = [UIImage imageNamed:@"iphonerage.png"];
            } else if ([product.productIdentifier isEqualToString:@"com.youridentifier.inapprage.nightlyrage"]) {
                detailViewController.image = [UIImage imageNamed:@"01_night.png"];
            } else if ([product.productIdentifier isEqualToString:@"com.youridentifier.inapprage.studylikeaboss"]) {
                detailViewController.image = [UIImage imageNamed:@"study.jpg"];
            } else if ([product.productIdentifier isEqualToString:@"com.youridentifier.inapprage.updogsadness"]) {
                detailViewController.image = [UIImage imageNamed:@"updog.png"];
            }
            
        } else {
            detailViewController.image = nil;
            detailViewController.message = @"Purchase to see comic!";
        }
    }
}


@end
