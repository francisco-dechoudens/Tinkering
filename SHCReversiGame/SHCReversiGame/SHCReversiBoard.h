//
//  SHCReversiBoard.h
//  SHCReversiGame
//
//  Created by Frankie on 12/1/14.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "SHCBoard.h"

@interface SHCReversiBoard : SHCBoard

// the white player's score
@property (readonly) NSInteger whiteScore;

// the black payer's score
@property (readonly) NSInteger blackScore;

// indicates the player who makes the next move
@property (readonly) BoardCellState nextMove;

// sets the board to the opening positions for Reversi
- (void) setToInitialState;

// Returns whether the player who's turn it is can make the given move
- (BOOL) isValidMoveToColumn:(NSInteger)column andRow:(NSInteger) row;

// Makes the given move for the player who is currently taking their turn
- (void) makeMoveToColumn:(NSInteger) column andRow:(NSInteger)row;

// indicates whether the game has finished
@property (readonly) BOOL gameHasFinished;

// multicasts game state changes
@property (readonly) SHCMulticastDelegate* reversiBoardDelegate;

@end
