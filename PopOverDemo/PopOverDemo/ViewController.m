//
//  ViewController.m
//  PopOverDemo
//
//  Created by Frankie on 8/11/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "ViewController.h"
#import "WYPopoverController.h"
#import "PopOverInsideViewController.h"

@interface ViewController ()<WYPopoverControllerDelegate>
- (IBAction)showPopover:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *button;
@end

@implementation ViewController
{
    WYPopoverController* popoverController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    [self setupPopOver];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupPopOver{
    UIColor *greenColor = [UIColor colorWithRed:26.f/255.f green:188.f/255.f blue:156.f/255.f alpha:1];
    
    [WYPopoverController setDefaultTheme:[WYPopoverTheme theme]];
    
    WYPopoverBackgroundView *popoverAppearance = [WYPopoverBackgroundView appearance];
    
    [popoverAppearance setOuterCornerRadius:4];
    [popoverAppearance setOuterShadowBlurRadius:0];
    [popoverAppearance setOuterShadowColor:[UIColor clearColor]];
    [popoverAppearance setOuterShadowOffset:CGSizeMake(0, 0)];
    
    [popoverAppearance setGlossShadowColor:[UIColor clearColor]];
    [popoverAppearance setGlossShadowOffset:CGSizeMake(0, 0)];
    
    [popoverAppearance setBorderWidth:8];
    [popoverAppearance setArrowHeight:10];
    [popoverAppearance setArrowBase:20];
    
    [popoverAppearance setInnerCornerRadius:4];
    [popoverAppearance setInnerShadowBlurRadius:0];
    [popoverAppearance setInnerShadowColor:[UIColor clearColor]];
    [popoverAppearance setInnerShadowOffset:CGSizeMake(0, 0)];
    
    [popoverAppearance setFillTopColor:greenColor];
    [popoverAppearance setFillBottomColor:greenColor];
    [popoverAppearance setOuterStrokeColor:greenColor];
    [popoverAppearance setInnerStrokeColor:greenColor];
    
}

- (IBAction)showPopover:(id)sender
{
    
    PopOverInsideViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"PopOverInsideViewControllerId"];
    controller.preferredContentSize = CGSizeMake(100, 100);
    
    popoverController = [[WYPopoverController alloc] initWithContentViewController:controller];
    popoverController.delegate = self;
    [popoverController presentPopoverFromBarButtonItem:_button permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES options:WYPopoverAnimationOptionScale];
    
    
}

- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    return YES;
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    popoverController.delegate = nil;
    popoverController = nil;
}

@end
