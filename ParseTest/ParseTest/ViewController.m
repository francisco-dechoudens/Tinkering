//
//  ViewController.m
//  ParseTest
//
//  Created by Frankie on 6/9/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//
//  All information found in : https://www.parse.com/docs/ios_guide#objects/iOS

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*Example of single Object Queries:*/
    
    //[self savingObject];
    //[self retrievingObjectById];
    //[self updateObjectById];
    //[self deleteObjectById];
    //[self removeSingleFieldById];
    //[self exampleOfDataType];
    
    /*Example of multiple Object Queries:*/
    //[self basicQuery];
    [self queryWithPredicate];
    
    
}


/*Create a Class table and save object following information:
 score = 1337
 playerName = "Sean Plott"
 cheatMode = NO
 
 ps- note that is save in background
 */
-(void)savingObject{
    PFObject *gameScore = [PFObject objectWithClassName:@"GameScore"];
    gameScore[@"score"] = @3555;
    gameScore[@"playerName"] = @"Frankie Plott";
    gameScore[@"cheatMode"] = @YES;
    
    [gameScore saveInBackground];
    //Note: You can use the saveInBackgroundWithBlock or saveInBackgroundWithTarget:selector: methods to provide additional logic which will run after the save completes.
    
}

-(void)retrievingObjectById{
    PFQuery *query = [PFQuery queryWithClassName:@"GameScore"];
    [query getObjectInBackgroundWithId:@"H5tycxqo5O" block:^(PFObject *gameScore, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
        NSLog(@"%@", gameScore);
        int score = [[gameScore objectForKey:@"score"] intValue];
        NSString *playerName = gameScore[@"playerName"];
        BOOL cheatMode = [gameScore[@"cheatMode"] boolValue];
        
        //three special value provided:
        
        NSString *objectId = gameScore.objectId;
        NSDate *updatedAt = gameScore.updatedAt;
        NSDate *createdAt = gameScore.createdAt;
        
        NSLog(@"Score %d, playerName %@, cheatMode %d",score,playerName,cheatMode);
    }];
    // The InBackground methods are asynchronous, so any code after this will run
    // immediately.  Any code that depends on the query result should be moved
    // inside the completion block above.
   
}

-(void)updateObjectById{
    PFQuery *query = [PFQuery queryWithClassName:@"GameScore"];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:@"H5tycxqo5O" block:^(PFObject *gameScore, NSError *error) {
        
        // Now let's update it with some new data. In this case, only cheatMode and score
        // will get sent to the cloud. playerName hasn't changed.
        gameScore[@"cheatMode"] = @NO;
        gameScore[@"score"] = @1234;
        [gameScore saveInBackground];
        
    }];
}

-(void)deleteObjectById{
    PFQuery *query = [PFQuery queryWithClassName:@"GameScore"];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:@"H5tycxqo5O" block:^(PFObject *gameScore, NSError *error) {
    
        //To delete an object from the cloud
        [gameScore deleteInBackground];
        
    }];
    
}

-(void)removeSingleFieldById{
    
    PFQuery *query = [PFQuery queryWithClassName:@"GameScore"];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:@"UK5pROfP1c" block:^(PFObject *gameScore, NSError *error) {
        
        // After this, the playerName field will be empty
        [gameScore removeObjectForKey:@"playerName"];
        
        // Saves the field deletion to the Parse Cloud
        [gameScore saveInBackground];
        
    }];

}

-(void)exampleOfDataType{
    NSNumber *number = @42;
    NSString *string = [NSString stringWithFormat:@"the number is %@", number];
    NSDate *date = [NSDate date];
    NSData *data = [@"foo" dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = @[string, number];
    NSDictionary *dictionary = @{@"number": number,
                                 @"string": string};
    NSNull *null = [NSNull null];
    
    PFObject *bigObject = [PFObject objectWithClassName:@"BigObject"];
    bigObject[@"myNumber"] = number;
    bigObject[@"myString"] = string;
    bigObject[@"myDate"] = date;
    bigObject[@"myData"] = data;
    bigObject[@"myArray"] = array;
    bigObject[@"myDictionary"] = dictionary;
    bigObject[@"myNull"] = null;
    [bigObject saveInBackground];
}

-(void)basicQuery{
    
    //Create a query
    PFQuery *query = [PFQuery queryWithClassName:@"GameScore"];
    
    //Condition
    [query whereKey:@"playerName" equalTo:@"Sean Plott"];
    
    //Retrieve a NSArray of matching PFObjects
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

/*
 For Predicates,
 
 These features are SUPPORTED:
 
 Simple comparisons such as =, !=, <, >, <=, >=, and BETWEEN with a key and a constant.
 Containment predicates, such as x IN {1, 2, 3}.
 Key-existence predicates, such as x IN SELF.
 BEGINSWITH expressions.
 Compound predicates with AND, OR, and NOT.
 Sub-queries with "key IN %@", subquery.
 
 
 The following types of predicates are NOT SUPPORTED:
 
 Aggregate operations, such as ANY, SOME, ALL, or NONE.
 Regular expressions, such as LIKE, MATCHES, CONTAINS, or ENDSWITH.
 Predicates comparing one key to another.
 Complex predicates with many ORed clauses.
 */

-(void)queryWithPredicate{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"playerName = 'Sean Plott'"];
    
    PFQuery *query = [PFQuery queryWithClassName:@"GameScore" predicate:predicate];
    
    //Retrieve a NSArray of matching PFObjects
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
