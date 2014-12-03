//
//  JasperAndZotBoardView.m
//  JasperAndZotGame
//
//  Created by Frankie on 12/3/14.
//  Copyright (c) 2014 Francisco L. De Choudens Ortiz. All rights reserved.
//

#import "JasperAndZotBoardView.h"
#import "BoardSquare.h"

@implementation JasperAndZotBoardView

- (id)initWithFrame:(CGRect)frame andBoard:(JasperAndZotBoard *)board
{
    if (self = [super initWithFrame:frame])
    {
        float rowHeight = frame.size.height / 11.0;
        float columnWidth = frame.size.width / 6.0;
        
        // create the 11x6 cells for this board
        for (int row = 0; row < 11; row++)
        {
            for (int col = 0; col < 6; col++)
            {
                BoardSquare* square = [[BoardSquare alloc] initWithFrame:CGRectMake(col*columnWidth, row*rowHeight, columnWidth, rowHeight) column:col row:row board:board];
                [self addSubview:square];
            }
        }
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
