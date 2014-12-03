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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
