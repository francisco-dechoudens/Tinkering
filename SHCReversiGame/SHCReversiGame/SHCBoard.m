//
//  SHCBoard.m
//  SHCReversiGame
//
//  Created by Frankie on 12/1/14.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "SHCBoard.h"
#import "SHCBoardDelegate.h"

@implementation SHCBoard
{
    //2D arrays, old-school C-style arrays.
    NSUInteger _board[8][8];
    
    id<SHCBoardDelegate> _delegate;
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

- (void)setCellState:(BoardCellState)state forColumn:(NSInteger)column andRow:(NSInteger)row
{
    [self checkBoundsForColumn:column andRow:row];
    _board[column][row] = state;
    [self informDelegateOfStateChanged:state forColumn:column andRow:row];
}


-(void) clearBoard{
    
    /*Mi implementacion
    for (int i = 0 ; i <= 8 ; i++) {
         for (int y = 0 ; y <= 8 ; y++) {
             _board[i][y] = BoardCellStateEmpty;
         }
    }*/
    
    //Set each byte of the block of memory occupied by this array to zero. 
    memset(_board, 0, sizeof(NSUInteger) * 8 * 8);
     [self informDelegateOfStateChanged:BoardCellStateEmpty forColumn:-1 andRow:-1];
}

- (void)checkBoundsForColumn:(NSInteger)column andRow:(NSInteger)row
{
    if (column < 0 || column > 7 || row < 0 || row > 7)
        [NSException raise:NSRangeException format:@"row or column out of bounds"];
}

- (NSUInteger) countCellsWithState:(BoardCellState)state
{
    int count = 0;
    for (int row = 0; row < 8; row++)
    {
        for (int col = 0; col < 8; col++)
        {
            if ([self cellStateAtColumn:col andRow:row] == state)
            {
                count++;
            }
        }
    }
    return count;
}

-(void)informDelegateOfStateChanged:(BoardCellState) state forColumn:(NSInteger)column andRow:(NSInteger) row
{
    if ([_delegate respondsToSelector:@selector(cellStateChanged:forColumn:andRow:)]) {
        [_delegate cellStateChanged:state forColumn:(int)column andRow:(int)row];
    }
}



@end
