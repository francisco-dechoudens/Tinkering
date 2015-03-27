//
//  PlayerViewController.m
//  Christian Prayers
//
//  Created by Frankie on 3/23/15.
//  Copyright (c) 2015 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "PlayerViewController.h"
#import "VerseViewController.h"
#import "AppDelegate.h"

@interface PlayerViewController ()

@end

@implementation PlayerViewController{
    NSArray* prayerTypeSubdivitionsArray;
    int selectedPrayerTypeSubdivitions;
    VerseViewController *bodyTextVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[VerseViewController class]]) {
        prayerTypeSubdivitionsArray = self.prayerTypeObject[@"PrayerTypeSubdivionsArray"];
        selectedPrayerTypeSubdivitions = 0;
        
        PFQuery* query = [PFQuery queryWithClassName:@"PrayerTypeCategorySubdivition"];
        [query getObjectInBackgroundWithId:prayerTypeSubdivitionsArray[selectedPrayerTypeSubdivitions] block:^(PFObject *object, NSError *error) {
            // Do something with the returned PFObject in the gameScore variable.
            self.prayerTypeSubdivitionLabel.text = object[@"name"];
            
            PFQuery* query2 = [PFQuery queryWithClassName:@"BibleVerse"];
            
            [query2 whereKey:@"PrayerTypeSubdivitionsId" equalTo:object.objectId];
            
            [query2 getFirstObjectInBackgroundWithBlock:^(PFObject *obj, NSError *error) {
                bodyTextVC = (VerseViewController*)segue.destinationViewController;
                bodyTextVC.playerBodyTextLabel.text = obj[@"verseText"];
                bodyTextVC.actionLabel.text = obj[@"ActionMessage"];
            }];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)nextButton:(id)sender {
    
    
    
    if (selectedPrayerTypeSubdivitions+1<prayerTypeSubdivitionsArray.count) {
        selectedPrayerTypeSubdivitions++;
        PFQuery* query = [PFQuery queryWithClassName:@"PrayerTypeCategorySubdivition"];
        [query getObjectInBackgroundWithId:prayerTypeSubdivitionsArray[selectedPrayerTypeSubdivitions] block:^(PFObject *object, NSError *error) {
            // Do something with the returned PFObject in the gameScore variable.
            self.prayerTypeSubdivitionLabel.text = object[@"name"];
            
            PFQuery* query2 = [PFQuery queryWithClassName:@"BibleVerse"];
            
            [query2 whereKey:@"PrayerTypeSubdivitionsId" equalTo:object.objectId];
            
            [query2 getFirstObjectInBackgroundWithBlock:^(PFObject *obj, NSError *error) {
                bodyTextVC.playerBodyTextLabel.text = obj[@"verseText"];
                bodyTextVC.actionLabel.text = obj[@"ActionMessage"];
            }];
        }];
    }
  
}

- (IBAction)previousButton:(id)sender {
   
    
    if (selectedPrayerTypeSubdivitions-1>=0 && selectedPrayerTypeSubdivitions<prayerTypeSubdivitionsArray.count) {
         selectedPrayerTypeSubdivitions--;
        PFQuery* query = [PFQuery queryWithClassName:@"PrayerTypeCategorySubdivition"];
        [query getObjectInBackgroundWithId:prayerTypeSubdivitionsArray[selectedPrayerTypeSubdivitions] block:^(PFObject *object, NSError *error) {
            // Do something with the returned PFObject in the gameScore variable.
            self.prayerTypeSubdivitionLabel.text = object[@"name"];
            
            PFQuery* query2 = [PFQuery queryWithClassName:@"BibleVerse"];
            
            [query2 whereKey:@"PrayerTypeSubdivitionsId" equalTo:object.objectId];
            
            [query2 getFirstObjectInBackgroundWithBlock:^(PFObject *obj, NSError *error) {
                bodyTextVC.playerBodyTextLabel.text = obj[@"verseText"];
                bodyTextVC.actionLabel.text = obj[@"ActionMessage"];
            }];
        }];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
