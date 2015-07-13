//
//  SimonPianoViewController.m
//  SimonPiano
//
//  Created by Sean Wertheim on 7/3/15.
//  Copyright (c) 2015 Sean Wertheim. All rights reserved.
//

#import "UIColor+SimonPianoColors.h"
#import <NSTimer+BlocksKit.h>
#import "SimonPianoViewController.h"
#import "SimonPiano.h"
#import "MusicalScore.h"
#import "ScorePlayer.h"
#import "NotePlayer.h"
#import "CorrectnessJudger.h"
#import "PhraseGenerator.h"
#import "MusicalPhrase.h" //<<<<<<<<<<<<<<<<<<<<<<<<<
#import "SongControlView.h"
#import "ScorePlayer+WinJingle.h"

@interface SimonPianoViewController () <SimonPianoDelegate, SimonPianoDataSource, ScorePlayerDelegate, PhraseGeneratorDelegate, SongControlDelegate>

@property (strong, nonatomic) SongControlView *songControlView;

@property (assign, nonatomic) int numberOfKeys;
@property (strong, nonatomic) NSArray *keyColors;
@property (strong, nonatomic) SimonPiano *piano;
@property (strong, nonatomic) NotePlayer *notePlayer;
@property (strong, nonatomic) ScorePlayer *winJinglePlayer;

@property (assign, nonatomic) int indexOfCurrentPhrase;
@property (assign, nonatomic) int indexOfCurrentSong;

@property (strong, nonatomic) NSArray *songs;
@property (strong, nonatomic) ScorePlayer *scorePlayer;
@property (strong, nonatomic) CorrectnessJudger *judger;
@property (strong, nonatomic) PhraseGenerator *phraseGenerator;

@end

static int const SimonPianoControllerNumberOfKeys = 6;
static float const SimonPianoControllerDefaultBPM = 90.0;

@implementation SimonPianoViewController

- (instancetype)initWithSongs:(NSArray *)songs {
    self = [super init];
    if (self) {
        self.indexOfCurrentPhrase = 0;
        self.songs = songs;
        self.winJinglePlayer = [ScorePlayer playerForWinJingle];
        self.winJinglePlayer.delegate = self;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.songControlView = [[SongControlView alloc] initWithSongs:self.songs];
    self.songControlView.delegate = self;
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
    
    self.notePlayer = [[NotePlayer alloc] initWithMinNoteValue:1 maxNoteValue:6]; //min/max would be dynamic for more song options with more notes
}

#pragma SongControlDelegate Methods

- (void)songControlDidPressStartForSongAtIndex:(int)index {
    self.indexOfCurrentSong = index;
    [self playSong];
    [self.songControlView hideSelectSongButton];// cannot select a song while one is playing
}

- (void)playSong{
    [self.piano setUserInteractionEnabled:NO];
    MusicalScore *score = self.songs[self.indexOfCurrentSong];
    self.scorePlayer = [[ScorePlayer alloc] initWithScore:score BPM:SimonPianoControllerDefaultBPM];
    self.scorePlayer.delegate = self;
    [self.scorePlayer playPhraseAtIndex:self.indexOfCurrentPhrase];
}

- (void)songControlDidRequestStop {
    [self resetGame];
}

- (void)resetGame {
    self.indexOfCurrentPhrase = 0;
    self.scorePlayer = nil;
    self.judger = nil;
    self.phraseGenerator = nil;
    [self.songControlView showSelectSongButton];
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
    [self.notePlayer playNoteWithValue:noteValue];
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
    
    MusicalScore *currentlyPlayingSong = self.songs[self.indexOfCurrentSong];
    if (self.indexOfCurrentPhrase >= currentlyPlayingSong.numberOfPhrases) { //indicates a win
        [self.winJinglePlayer playPhraseAtIndex:0 afterDelay:1.0];
        [self resetGame];
        return;
    }
    
    [self.piano setUserInteractionEnabled:NO];
    [self.scorePlayer playPhraseAtIndex:self.indexOfCurrentPhrase];
}

@end
