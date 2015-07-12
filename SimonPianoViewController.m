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
#import "MusicalScore.h"
#import "ScorePlayer.h"
#import "CorrectnessJudger.h"
#import "PhraseGenerator.h"
#import "MusicalPhrase.h" //<<<<<<<<<<<<<<<<<<<<<<<<<
#import "SongControlView.h"

@interface SimonPianoViewController () <SimonPianoDelegate, SimonPianoDataSource, ScorePlayerDelegate, PhraseGeneratorDelegate, SongControlDelegate>

@property (assign, nonatomic) int indexOfCurrentPhrase;

@property (strong, nonatomic) SongControlView *songControlView;

@property (assign, nonatomic) int numberOfKeys;
@property (strong, nonatomic) NSArray *keyColors;
@property (strong, nonatomic) SimonPiano *piano;

@property (strong, nonatomic) MusicalScore *score;
@property (strong, nonatomic) ScorePlayer *scorePlayer;
@property (strong, nonatomic) CorrectnessJudger *judger;
@property (strong, nonatomic) PhraseGenerator *phraseGenerator;

@end

static int const SimonPianoControllerNumberOfKeys = 6;
static float const SimonPianoControllerDefaultBPM = 90.0;

@implementation SimonPianoViewController

- (instancetype)initWithSong:(MusicalScore *)score {
    self = [super init];
    if (self) {
        self.indexOfCurrentPhrase = 0;
        self.score = score;
        self.scorePlayer = [[ScorePlayer alloc] initWithScore:score BPM:SimonPianoControllerDefaultBPM];
        self.scorePlayer.delegate = self;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.songControlView = [[SongControlView alloc] init];
    [self.view addSubview:self.songControlView];
    
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
    [self.piano reloadData]; //so that delegate/datasource methods are called
}

#pragma SongControlDelegate Methods

- (void)songControlDidSelectSongAtIndex:(int)index {
    
}

- (void)playSongAtIndex:(int)index {
    [self.piano setUserInteractionEnabled:NO];
    self.indexOfCurrentPhrase = 0;
    [self.scorePlayer playPhraseAtIndex:self.indexOfCurrentPhrase];
}

#pragma mark SimonPianoDataSource Methods

- (UIColor *)colorForKeyHalfCircleAtIndex:(NSInteger)index {
    return self.keyColors[index];
}

- (int)numberOfKeysInPiano {
    
    return SimonPianoControllerNumberOfKeys;
}

#pragma mark SimonPianoDelegate Methods

- (void)simonPiano:(SimonPiano *)simonPiano didPressKeyAtIndex:(int)index {
    [self.piano animateKeyHighlightAtIndex:index];
    
    int noteValue = index + 1; //keys are 0-indexed but notes are [1...6]
    [self.phraseGenerator addNoteWithValue:noteValue];
}

#pragma mark ScorePlayerDelegate Methods

- (void)scorePlayerDidFinishPlayingPhrase:(MusicalPhrase *)phrase {
    self.judger = [[CorrectnessJudger alloc] initWithCorrectPhrase:phrase];
    self.phraseGenerator = [[PhraseGenerator alloc] initWithPhraseLength:phrase.length];
    self.phraseGenerator.delegate = self;
    [self.piano setUserInteractionEnabled:YES];
}

- (void)scorePlayerDidPlayNoteWithValue:(int)value {
    int keyIndex = value - 1; //keys are 0-indexed
    [self.piano animateKeyHighlightAtIndex:keyIndex];
}

#pragma mark PhraseGeneratorDelegate Methods

- (void)phraseGeneratorDidGeneratePhrase:(MusicalPhrase *)phrase {
    self.judger.playedPhrase = phrase;
    
    if ([self.judger verify]) {
        self.indexOfCurrentPhrase++;
    }
    
    if (self.indexOfCurrentPhrase >= self.score.numberOfPhrases) {
        return;
    }
    
    [self.piano setUserInteractionEnabled:NO];
    [self.scorePlayer playPhraseAtIndex:self.indexOfCurrentPhrase];
}

@end
