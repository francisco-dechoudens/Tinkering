//
//  BoardCellState.h
//  JasperAndZotGame
//
//  Created by Frankie on 12/3/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#ifndef JasperAndZotGame_BoardCellState_h
#define JasperAndZotGame_BoardCellState_h

typedef NS_ENUM(NSUInteger, BoardCellState) {
    BoardCellStateEmpty = 0,
    BoardCellStateZombiePiece = 1,
    BoardCellStateFireZombiePiece = 2,
    BoardCellStateFlowerPiece = 3,
    BoardCellStateBombPiece = 4,
    BoardCellStateMultiplierPiece = 5,
    BoardCellStatePumpkinPiece = 6,
    BoardCellStateJasperPiece = 7,
    BoardCellStateJasperEmptyPiece = 8,
    BoardCellStateDiceField = 9
};

#endif
