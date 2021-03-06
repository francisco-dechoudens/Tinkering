//
//  WTTableViewController.m
//  Weather
//
//  Created by Scott on 26/01/2013.
//  Updated by Joshua Greene 16/12/2013.
//
//  Copyright (c) 2013 Scott Sherwood. All rights reserved.
//

#import "WTTableViewController.h"
#import "WeatherAnimationViewController.h"
#import "NSDictionary+weather.h"
#import "NSDictionary+weather_package.h"
#import "Restaurant.h"
#import "UIImageView+AFNetworking.h"

static NSString * const BaseURLString = @"http://www.raywenderlich.com/demos/weather_sample/";

@interface WTTableViewController ()
@property(strong) NSDictionary *restaurantDict;
@property(strong) NSMutableArray* restArray;
@end

@implementation WTTableViewController

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
    self.navigationController.toolbarHidden = NO;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"WeatherDetailSegue"]){
        UITableViewCell *cell = (UITableViewCell *)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        WeatherAnimationViewController *wac = (WeatherAnimationViewController *)segue.destinationViewController;
        
        NSDictionary *w;
        switch (indexPath.section) {
            case 0: {
                w = self.restaurantDict.currentCondition;
                break;
            }
            case 1: {
                w = [self.restaurantDict upcomingWeather][indexPath.row];
                break;
            }
            default: {
                break;
            }
        }
        wac.weatherDictionary = w;
    }
}

#pragma mark - Actions

- (IBAction)clear:(id)sender
{
    self.title = @"";
    self.restaurantDict = nil;
    [self.tableView reloadData];
}

- (IBAction)jsonTapped:(id)sender
{
    // You first create a string representing the full url from the base URL string.
    //This is then used to create an NSURL object, which is used to make an NSURLRequest.
    NSString *string = [NSString stringWithFormat:@"http://sal.api.gfrmservices.com/v2/restaurants/listall/?lang=Espa&limit=3&start=0&api_key=sqa65sgd7kqvte8939dej5zp"];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //AFHTTPRequestOperation is an all-in-one class for handling HTTP transfers across the network.
    //You tell it that the response should be read as JSON by setting the responseSerializer property to the default JSON serializer.
    //AFNetworking will then take care of parsing the JSON for you.
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //The success block runs when (surprise!) the request succeeds.
        //The JSON serializer parses the received data and returns a dictionary in the responseObject variable, which is stored in the weather property.
        self.restaurantDict = (NSDictionary *)responseObject;
       self.restArray = [NSMutableArray new];
        
        for (id key in self.restaurantDict) {
            NSError *error;
            if (![key isEqualToString:@"status"]) {
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.restaurantDict[key]
                                                                   options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                                     error:&error];
                if (! jsonData) {
                    NSLog(@"Got an error: %@", error);
                } else {
                    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                    //NSLog(@"%@", jsonString);
                    NSError* err = nil;
                    Restaurant* restaurant = [[Restaurant alloc] initWithString:jsonString error:&err];
                    [_restArray addObject:restaurant];
                }
            }
           
        }
        self.title = @"JSON Retrieved";
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //The failure block runs if something goes wrong – such as if networking isn’t available.
        //If this happens, you simply display an alert with the error message.
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    //You must explicitly tell the operation to “start” (or else nothing will happen).
    [operation start];
    
}

- (IBAction)plistTapped:(id)sender
{
    
}

- (IBAction)xmlTapped:(id)sender
{
    
}

- (IBAction)clientTapped:(id)sender
{
    
}

- (IBAction)apiTapped:(id)sender
{
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return _restArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WeatherCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [(Restaurant*)self.restArray[indexPath.row] title];
    
    NSURL *url = [NSURL URLWithString:[(NSArray*)[(Restaurant*)self.restArray[indexPath.row] featuredImage] firstObject]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder"];
    
    __weak UITableViewCell *weakCell = cell;
    
    [cell.imageView setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       
                                       weakCell.imageView.image = image;
                                       [weakCell setNeedsLayout];
                                       
                                   }
                                   failure:nil];
    return cell;

}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
}

@end