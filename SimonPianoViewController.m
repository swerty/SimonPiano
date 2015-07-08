//
//  SimonPianoViewController.m
//  SimonPiano
//
//  Created by Sean Wertheim on 7/3/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import "UIColor+SimonPianoColors.h"

#import "SimonPianoViewController.h"
#import "SimonPiano.h"

@interface SimonPianoViewController () <SimonPianoDelegate, SimonPianoDataSource>

@property (strong, nonatomic) NSArray *keyColors;
@property (strong, nonatomic) SimonPiano *piano;

@end

static int const SimonPianoControllerNumberOfKeys = 6;

@implementation SimonPianoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.keyColors = @[[UIColor simonBlue],
                       [UIColor simonGreen],
                       [UIColor simonOrange],
                       [UIColor simonRed],
                       [UIColor simonPurple],
                       [UIColor simonBrown]];
    
    self.piano = [[SimonPiano alloc] initWithFrame:CGRectZero];
    self.piano.dataSource = self;
    self.piano.delegate = self;
    [self.view addSubview:self.piano];
    [self.piano reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark SimonPianoDataSource Methods

- (UIColor *)colorForKeyHalfCircleAtIndex:(NSInteger)index {
    return self.keyColors[index];
}

- (int)numberOfKeysInPiano {
    
    return SimonPianoControllerNumberOfKeys;
}

#pragma mark SimonPianoDelegate Methods

- (void)simonPiano:(SimonPiano *)simonPiano didPressKeyAtIndex:(NSInteger)index {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
