//
//  ViewController.m
//  GameOfLife
//
//  Created by zhuxi on 2016/12/23.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "ViewController.h"
#import "GOLGameManager.h"

@interface ViewController ()

@property (nonatomic, strong) GOLGameManager *gameManager;
@property (weak, nonatomic) IBOutlet GOLGrid *gridView;

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;

- (IBAction)startButtonTapped:(id)sender;
- (IBAction)resetGame:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gridView.length = 20;
    self.gameManager = [GOLGameManager manager];
    self.gameManager.grid = self.gridView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)startButtonTapped:(id)sender
{
    if ([self.startButton.titleLabel.text isEqualToString:@"Start"]) {
        [self.startButton setTitle:@"Stop" forState:UIControlStateNormal];
    } else {
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    }
    
    [self.gameManager startOrPause];
}

- (IBAction)resetGame:(id)sender
{
    [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    [self.gameManager resetState];
}
@end
