//
//  SHCViewController.m
//  SHCReversiGame
//
//  Created by Colin Eberhardt on 07/12/2012.
//  Copyright (c) 2012 Colin Eberhardt. All rights reserved.
//

#import "SHCViewController.h"
#import "SHCReversiBoard.h"
#import "SHCReversiBoardView.h"

@interface SHCViewController ()

@end

@implementation SHCViewController
{
    SHCReversiBoard* _board;
    SHCReversiBoardView* _boardView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set the various background images
    self.backgroundImage.image = [UIImage imageNamed: @"Reversi.png"];
    self.gameOverImage.image = [UIImage imageNamed: @"GameOver.png"];
    self.gameOverImage.hidden = YES;
    
    _board = [[SHCReversiBoard alloc]init];
    [_board setToInitialState];
    
    CGRect boardFrame = CGRectMake(34, 83, 253, 338);
    
    _boardView = [[SHCReversiBoardView alloc]initWithFrame:boardFrame andBoard:_board];
    
    [self.view addSubview:_boardView];
    
    [self gameStateChanged];
    [_board.reversiBoardDelegate addDelegate:self];
    
    // add a tap recognizer
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(restartGame:)];
    
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)gameStateChanged
{
    _whiteScore.text = [NSString stringWithFormat:@"%d", (int)_board.whiteScore];
    _blackScore.text = [NSString stringWithFormat:@"%d", (int)_board.blackScore];
    _gameOverImage.hidden = !_board.gameHasFinished;
}

- (void)restartGame:(UITapGestureRecognizer*)recognizer
{
    if (_board.gameHasFinished)
    {
        [_board setToInitialState];
        [self gameStateChanged];
    }
}

@end
