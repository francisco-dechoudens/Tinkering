//
//  BoardSquare.m
//  JasperAndZotGame
//
//  Created by Frankie on 12/3/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "BoardSquare.h"

@implementation BoardSquare
{
    int _row;
    int _column;
    JasperAndZotBoard* _board;
    UIImageView* _wizardView;
    UIImageView* _zombieView;
    UIImageView* _zombieFireView;
    UIImageView* _flowerView;
    UIImageView* _pumkinView;
    UIImageView* _bombView;
    UIImageView* _x2View;
    UIImageView* _diceFieldView;
    UIImageView* _jasperPosiblePositionView;
}

- (id)initWithFrame:(CGRect)frame column:(NSInteger)column row:(NSInteger)row board:(JasperAndZotBoard *)board
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _row = row;
        _column = column;
        _board = board;
        
        // create the views for the playing piece graphics
        UIImage* wizardImage = [UIImage imageNamed: @"wizard.png"];
        _wizardView = [[UIImageView alloc] initWithImage: wizardImage];
        _wizardView.alpha = 0.0;
        [self addSubview:_wizardView];
        
        UIImage* zombieImage = [UIImage imageNamed: @"zombie.png"];
        _zombieView = [[UIImageView alloc] initWithImage: zombieImage];
        _zombieView.alpha = 0.0;
        [self addSubview:_zombieView];
        
        UIImage* zombieFireImage = [UIImage imageNamed: @"zombieFire.png"];
        _zombieFireView = [[UIImageView alloc] initWithImage: zombieFireImage];
        _zombieFireView.alpha = 0.0;
        [self addSubview:_zombieFireView];
        
        UIImage* flowerImage = [UIImage imageNamed: @"flower2.png"];
        _flowerView = [[UIImageView alloc] initWithImage: flowerImage];
        _flowerView.alpha = 0.0;
        [self addSubview:_flowerView];
        
        UIImage* pumkinImage = [UIImage imageNamed: @"pumking.png"];
        _pumkinView = [[UIImageView alloc] initWithImage: pumkinImage];
        _pumkinView.alpha = 0.0;
        [self addSubview:_pumkinView];
        
        UIImage* bombImage = [UIImage imageNamed: @"bomb.png"];
        _bombView = [[UIImageView alloc] initWithImage: bombImage];
        _bombView.alpha = 0.0;
        [self addSubview:_bombView];
        
        UIImage* x2Image = [UIImage imageNamed: @"x2.png"];
        _x2View = [[UIImageView alloc] initWithImage: x2Image];
        _x2View.alpha = 0.0;
        [self addSubview:_x2View];
        
        UIImage* diceFieldImage = [UIImage imageNamed: @"diceFieldSelect.png"];
        _diceFieldView = [[UIImageView alloc] initWithImage: diceFieldImage];
        _diceFieldView.alpha = 0.0;
        [self addSubview:_diceFieldView];
        
        UIImage* jasperPosiblePositionImage = [UIImage imageNamed: @"jasperPosiblePosition"];
        _jasperPosiblePositionView = [[UIImageView alloc] initWithImage: jasperPosiblePositionImage];
        _jasperPosiblePositionView.alpha = 0.0;
        [self addSubview:_jasperPosiblePositionView];
        
        self.backgroundColor = [UIColor clearColor];
        
        [self update];
        
        [_board.boardDelegate addDelegate:self];
        
        // add a tap recognizer
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                                 initWithTarget:self action:@selector(cellTapped:)];
        [self addGestureRecognizer:tapRecognizer];
    }
    return self;
}

// updates the UI state
- (void)update
{
    // show / hide the images based on the cell state
    BoardCellState state = [_board cellStateAtColumn:_column andRow:_row];
    
    
    _zombieView.alpha = state == BoardCellStateZombiePiece ? 1.0 : 0.0;;
    _zombieFireView.alpha = state == BoardCellStateFireZombiePiece ? 1.0 : 0.0;;
    _flowerView.alpha = state == BoardCellStateFlowerPiece? 1.0 : 0.0;;
    _pumkinView.alpha = state == BoardCellStatePumpkinPiece ? 1.0 : 0.0;;
    _bombView.alpha = state == BoardCellStateBombPiece ? 1.0 : 0.0;;
    _x2View.alpha = state == BoardCellStateMultiplierPiece ? 1.0 : 0.0;;
    
    _wizardView.alpha = state == BoardCellStateJasperPiece ? 1.0 : 0.0;
    
    _diceFieldView.alpha = state == BoardCellStateDiceField ? 1.0 : 0.0;
    _jasperPosiblePositionView.alpha = state == BoardCellStateJasperPosiblePosition ? 1.0 : 0.0;
   
}

- (void)cellTapped:(UITapGestureRecognizer*)recognizer
{
    if ([_board isValidMoveToColumn:_column andRow:_row])
    {
        [_board makeMoveToColumn:_column andRow:_row];
    }
}

#pragma mark - Delegate Method

- (void)cellStateChanged:(BoardCellState)state forColumn:(NSInteger)column andRow:(NSInteger)row
{
    if ((column == _column && row == _row) ||
        (column == -1 && row == -1))
    {
        [self update];
    }
}
@end
