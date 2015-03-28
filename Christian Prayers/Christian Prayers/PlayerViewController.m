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
    NSTimer* timer;
    int secondsLeft;
    bool isPause;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = [NSString stringWithFormat:@"%d:00",_timeSelected];
    secondsLeft = _timeSelected*60;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [timer invalidate];
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
            
            [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                
                int randomVerseSelection = arc4random_uniform((int)objects.count);
                
                PFObject* obj = objects[randomVerseSelection];
                
                bodyTextVC = (VerseViewController*)segue.destinationViewController;
                NSString *verseText = obj[@"verseText"];
                NSString *verseComplete = [[verseText stringByAppendingString:@" -- "]stringByAppendingString:obj[@"verseNumber"]];
                
                bodyTextVC.verseBody.text = verseComplete;
                bodyTextVC.actionLabel1.text = obj[@"ActionMessage"];
                bodyTextVC.actionLabel2.text = obj[@"ActionMessage2"];
                bodyTextVC.actionBody.text = obj[@"prayFor"];
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
            
            [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                
                int randomVerseSelection = arc4random_uniform((int)objects.count);
                
                PFObject* obj = objects[randomVerseSelection];
            
                NSString *verseText = obj[@"verseText"];
                NSString *verseComplete = [[verseText stringByAppendingString:@" -- "]stringByAppendingString:obj[@"verseNumber"]];
                
                bodyTextVC.verseBody.text = verseComplete;
                bodyTextVC.actionLabel1.text = obj[@"ActionMessage"];
                bodyTextVC.actionLabel2.text = obj[@"ActionMessage2"];
                bodyTextVC.actionBody.text = obj[@"prayFor"];
                
                [bodyTextVC resizeView];
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
            
            [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                
                int randomVerseSelection = arc4random_uniform((int)objects.count);
                
                PFObject* obj = objects[randomVerseSelection];
                
                NSString *verseText = obj[@"verseText"];
                NSString *verseComplete = [[verseText stringByAppendingString:@" -- "]stringByAppendingString:obj[@"verseNumber"]];
                
                bodyTextVC.verseBody.text = verseComplete;
                bodyTextVC.actionLabel1.text = obj[@"ActionMessage"];
                bodyTextVC.actionLabel2.text = obj[@"ActionMessage2"];
                bodyTextVC.actionBody.text = obj[@"prayFor"];
                
                [bodyTextVC resizeView];
            }];
        }];
    }
}
- (IBAction)playPauseButton:(id)sender {
    
    isPause = !isPause;
    
    if (isPause) {
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateElapsedTime) userInfo:nil repeats:YES];
        
        
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
    else{
        [timer invalidate];
    }
    
    
}

-(void) updateElapsedTime {
    int minutes, seconds;
    
    if ( secondsLeft <= 0 ) {
        [timer invalidate];
    }
    else{
        secondsLeft--;
        
        minutes = (secondsLeft % 3600) / 60;
        seconds = (secondsLeft %3600) % 60;
        self.navigationItem.title = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
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
