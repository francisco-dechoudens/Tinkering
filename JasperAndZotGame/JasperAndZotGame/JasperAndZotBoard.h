//
//  JasperAndZotBoard.h
//  JasperAndZotGame
//
//  Created by Frankie on 12/3/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "Board.h"

@interface JasperAndZotBoard : Board

// the Jasper player's score
@property (readonly) NSInteger jasperScore;

// the Zot payer's score
@property (readonly) NSInteger zotScore;

// sets the board to the opening positions for Jasper And Zot Game
- (void) setToInitialState;

// indicates the player who makes the next move
@property (readonly) BoardCellState turnPlayer;

// Returns whether the player who's turn it is can make the given move
- (BOOL) isValidMoveToColumn:(NSInteger)column andRow:(NSInteger) row;

// Makes the given move for the player who is currently taking their turn
- (void) makeMoveToColumn:(NSInteger) column andRow:(NSInteger)row;

// wait jasper action
- (void) waitAction;

// shot jasper action
-(void)makeShot;

@end
