//
//  Board.m
//  JasperAndZotGame
//
//  Created by Frankie on 12/3/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "Board.h"
#import "BoardDelegate.h"

@implementation Board
{
    NSUInteger _board[6][11], _pastBoard[6][11];
    id<BoardDelegate> _delegate;
}

- (id)init
{
    if (self = [super init]){
        [self clearBoard];
        _boardDelegate = [[SHCMulticastDelegate alloc] init];
        _delegate = (id)_boardDelegate;
    }
    return self;
}

- (BoardCellState)cellStateAtColumn:(NSInteger)column andRow:(NSInteger)row
{
    [self checkBoundsForColumn:column andRow:row];
    return _board[column][row];
}

- (BoardCellState)cellLastStateAtColumn:(NSInteger)column andRow:(NSInteger)row
{
    [self checkBoundsForColumn:column andRow:row];
    return _pastBoard[column][row];
}

- (void)setCellState:(BoardCellState)state forColumn:(NSInteger)column andRow:(NSInteger)row
{
    [self checkBoundsForColumn:column andRow:row];
    _pastBoard[column][row] = _board[column][row];
    _board[column][row] = state;
    [self informDelegateOfStateChanged:state forColumn:column andRow:row];
}

- (void)clearBoard
{
    memset(_pastBoard, 0, sizeof(NSUInteger) * 11 * 6);
    memset(_board, 0, sizeof(NSUInteger) * 11 * 6);
    [self informDelegateOfStateChanged:BoardCellStateEmpty forColumn:-1 andRow:-1];
}

- (void)checkBoundsForColumn:(NSInteger)column andRow:(NSInteger)row
{
    if (column < 0 || column > 5 || row < 0 || row > 10)
        [NSException raise:NSRangeException format:@"row or column out of bounds"];
}

#pragma mark - delegate method

-(void)informDelegateOfStateChanged:(BoardCellState) state forColumn:(NSInteger)column andRow:(NSInteger) row
{
    if ([_delegate respondsToSelector:@selector(cellStateChanged:forColumn:andRow:)]) {
        [_delegate cellStateChanged:state forColumn:column andRow:row];
    }
}

@end
