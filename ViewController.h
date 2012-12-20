//
//  ViewController.h
//  Pentago
//
//  Created by Mike on 10/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ViewController : UIViewController{
    UIButton *resetGameButton;
    UIButton *setMoveButton;
    UIButton *rotateCButton;
    UIButton *switchButton;
    UIButton *rotateCCButton;


    NSArray *boardViews;
    NSArray *subBoardArrays;
    
    float rotations[4];
    int subIndex;
    
    CGFloat height;
    CGFloat width;
    
    CATransform3D clockwise;
    CATransform3D counterClock;
}

@end
