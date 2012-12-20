//
//  ViewController.m
//  Pentago
//
//  Created by Mike on 10/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"

@implementation ViewController

- (IBAction)newGameSelected:(id)sender{
    NSLog(@"new game");
}
- (IBAction)setMoveSelected:(id)sender{
    NSLog(@"set move");

}
- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor blueColor]];
    [self getSize];
    [self setup];
    [self createButtons];
    //[self createBoard];
    [self resetBoard];
}
- (void)getSize{
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    
    if(width > height){
        CGFloat tmp = width;
        width = height;
        height = tmp;
    }
}

- (void)setup{
    int base = [self scale:830];
    int b2 = base/2;
    int side = [self scale:300];
    
    UIView *board1 = [[UIView alloc]initWithFrame:CGRectMake(width/2.0-side-1, b2-side-1, side, side)];
    UIView *board2 = [[UIView alloc]initWithFrame:CGRectMake(width/2.0+1, b2-side-1, side, side)];
    UIView *board3 = [[UIView alloc]initWithFrame:CGRectMake(width/2.0-side-1, b2+1, side, side)];
    UIView *board4 = [[UIView alloc]initWithFrame:CGRectMake(width/2.0+1, b2+1, side, side)];
    
    boardViews = [[NSArray alloc]initWithObjects:board1,board2,board3,board4, nil];

    [self setupSubboard:board1];
    [self setupSubboard:board2];
    [self setupSubboard:board3];
    [self setupSubboard:board4];
}

- (int)scale:(int)num{
    return num * height/1004.0;
}

- (void) setupSubboard:(UIView *)subboard{
    CGFloat size = subboard.bounds.size.width;
    CGFloat imagesize = size/3.0;
    
    for(int i = 0; i<3; i++){
        for( int j = 0; j<3;j++){
            CGRect imagerect = CGRectMake(imagesize*j, imagesize*i, imagesize-1, imagesize-1);
            UIImageView *place = [[UIImageView alloc]initWithFrame:imagerect];
            place.image = [UIImage imageNamed:@"sq-bar.jpg"];
            place.layer.cornerRadius = imagesize/2.0;
            [place.layer setMasksToBounds:YES];
            [subboard addSubview:place];
        }
    }
    subboard.backgroundColor = [UIColor brownColor];
    [self.view addSubview:subboard];
}

- (void)createButtons{
    int h = [self scale:85];
    int w = [self scale:200];
    int y = [self scale:830];
    resetGameButton = [self newButton:width/2.0 - (w+h):y:w:h:
                            @"New Game":
                            @selector(newGameSelected:)];
    setMoveButton = [self newButton:width/2.0 + h:y:w:h:
                            @"Set Move":
                            @selector(setMoveSelected:)];
}

//768x1004 iPad dimensions
//position and size based on iPad locations, adjusts for actual size
- (UIButton *)newButton:(CGFloat)x: (CGFloat)y: (CGFloat)ww: (CGFloat)hh:
                        (NSString*)title:(SEL) select {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:select
                forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    
    button.frame = CGRectMake(x, y, ww, hh);
    [self.view addSubview:button];
    return button;
}

- (void)resetBoard{
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

@end
