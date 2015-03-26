//
//  ViewController.m
//  JasperAndZotGame
//
//  Created by Frankie on 12/3/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "ViewController.h"
#import "JasperAndZotBoard.h"
#import "JasperAndZotBoardView.h"
#import "UIView+Animation.h"

@interface ViewController ()

@end

@implementation ViewController{
    JasperAndZotBoard* _board;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // create our game board
    _board = [[JasperAndZotBoard alloc] init];
    [_board setToInitialState];
    
    // create a view
    JasperAndZotBoardView* jasperAndZotBoard = [[JasperAndZotBoardView alloc] initWithFrame:CGRectMake(35,108,248,395) andBoard:_board];
    
    [self.view addSubview:jasperAndZotBoard];
    
}

- (IBAction)shootButton:(id)sender {
    [_board makeShot];
    
    //[self addingShootingView];
}

-(void)addingShootingView{
    UIImage* jasperPosiblePositionImage = [UIImage imageNamed: @"jasperPosiblePosition"];
    UIView *jasperPosiblePositionView = [[UIImageView alloc] initWithImage: jasperPosiblePositionImage];
    jasperPosiblePositionView.frame = CGRectMake(156, 464, jasperPosiblePositionView.frame.size.width,jasperPosiblePositionView.frame.size.height ); // set new position exactly

    jasperPosiblePositionView.alpha = 1.0;
    
    [self.view addSubview:jasperPosiblePositionView];
    
    [jasperPosiblePositionView moveTo:CGPointMake(164,292)duration:0.5 option:0];
}

- (IBAction)waitButton:(id)sender {
    [_board waitAction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
