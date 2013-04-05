//
//  PHViewController.m
//  ExecuteTheExecutor
//
//  Created by StopBitingMe on 3/7/13.
//  Copyright (c) 2013 StopBitingMe. All rights reserved.
//

//
//TODO
//Make PHGameData a singleton
//Abstract methods in PHGameRules
//Parse out spaces before adding underscores in hiddenSong
//Display lyrics
//Add high score for consecquetive wins - points based on a mix between letters and its place in the top 100
//


#import "PHViewController.h"
#import "PHRules.h"
#import "PHGameData.h"
#import "PHConnectionAPI.h"

@interface PHViewController ()
{
    int searchStartingLocation;
    NSRange rangeOfNewWord;
    
    IBOutlet UITextField *textFieldOutlet;
    IBOutlet UILabel *wrongGuessesOutlet;
    IBOutlet UILabel *songLabelOutlet;
    IBOutlet UIImageView *UIImageViewOutlet;
    IBOutlet UIWebView *webViewOutlet;
}

@property (strong, nonatomic) PHGameData *gameData;
@property (strong, nonatomic) PHRules *gameRules;
@property (strong, nonatomic) PHConnectionAPI *startConnection;
@property (strong, nonatomic) NSDictionary *songDictionary;


@end

@implementation PHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Allocate all the objects!
    self.startConnection = [[PHConnectionAPI alloc]init];
    self.gameData = [[PHGameData alloc]init];
    self.gameRules = [[PHRules alloc]init];
    self.songDictionary = [[NSDictionary alloc]init];
    self.gameData.resultArray = [[NSArray alloc]init];
    self.gameData.wronglyGuessedLetters = [[NSMutableArray alloc]init];
    self.gameData.marcelineArray = [[NSMutableArray alloc]init];
    
    self.gameData.guessedLetters = [[NSMutableArray alloc]init];
    self.gameData.numberOfWrongGuesses = 5;
    songLabelOutlet.text = @" ";
    
    UIImageViewOutlet.image = [UIImage imageNamed:@"marcelineHappy.png"];
    [self.gameData.marcelineArray addObject:@"marcelineGameOver.png"];
    [self.gameData.marcelineArray addObject:@"marcelineSad.png"];
    [self.gameData.marcelineArray addObject:@"marcelineGettingSad.png"];
    [self.gameData.marcelineArray addObject:@"marcelineStillHappyButNot.png"];
    [self.gameData.marcelineArray addObject:@"marcelineLostAString.png"];
    [self.gameData.marcelineArray addObject:@"marcelineHappy.png"];
    
   //Make API Connection
    self.startConnection.bitch = self;
    [self.startConnection makeConnection];
}


-(void)hasData:(NSDictionary *)songToUse
{
    //Launch a new game from here
    self.songDictionary = songToUse;
    self.gameData.winningSong = [self.songDictionary valueForKey:@"song"];
    self.gameData.winningSongURL = [self.songDictionary valueForKey:@"url"];
    self.gameData.lengthOfCharacters = self.gameData.winningSong.length;
    //self.gameData.hiddenSong = [self.gameData obscureSongName:self.gameData.winningSong];
    self.gameData.winningSongWords = [self.gameData parseSpacesOutOfSong:self.gameData.winningSong];
    self.gameData.hiddenSong = [self.gameData obscureWordsIndividually:self.gameData.winningSongWords];
    songLabelOutlet.text = self.gameData.hiddenSong;
    
    //Delete - doesnt work yet
    NSURLRequest *newRequest = [self.gameRules createURLRequestFromString:self.gameData.winningSongURL];
    [webViewOutlet loadRequest:newRequest];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    //A new guess occurs when a new letter is entered
    
    //If too many characters, clear textField and exit out of method
    if (textFieldOutlet.text.length>1) {
        textFieldOutlet.text = @"";
        NSLog(@"Too Many Characters!");
        return YES;
    }
    self.gameData.oldHiddenSong = self.gameData.hiddenSong;
    self.gameData.guessedLetter = textFieldOutlet.text;
    self.gameData.hiddenSong = [self.gameRules compareGuessTo:self.gameData.winningSong
                                                   andCompare:self.gameData.guessedLetter
                                             andVerifyGuesses:self.gameData.numberOfWrongGuesses
                                          andAdjustHiddenSong:self.gameData.hiddenSong];
    //GRRR, get this logic outta here!
    if (self.gameData.hiddenSong == self.gameData.winningSong) {
        UIAlertView *winnerAlert = [[UIAlertView alloc] initWithTitle:@"You've Won"
                                                                message:@"Marceline can jam out now!"
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"New Song?", nil];
        [winnerAlert show];
        //doesn't work yet
        NSURLRequest *newRequest = [self.gameRules createURLRequestFromString:self.gameData.winningSongURL];
        [webViewOutlet loadRequest:newRequest];
        NSLog(@"You Won!");
    }
    if (self.gameData.oldHiddenSong == self.gameData.hiddenSong && self.gameData.numberOfWrongGuesses>1)
    {
        [self.gameData.wronglyGuessedLetters addObject:self.gameData.guessedLetter];
        wrongGuessesOutlet.text = [self.gameData.wronglyGuessedLetters componentsJoinedByString:@", "];
        --self.gameData.numberOfWrongGuesses;
        UIImageViewOutlet.image = [UIImage imageNamed:[self.gameData.marcelineArray objectAtIndex:self.gameData.numberOfWrongGuesses]];
        NSLog(@"%i guesses left!", self.gameData.numberOfWrongGuesses);
    }
    else if (self.gameData.oldHiddenSong == self.gameData.hiddenSong && self.gameData.numberOfWrongGuesses>0)
    {
        //Game Ends Here!
        UIImageViewOutlet.image = [UIImage imageNamed:[self.gameData.marcelineArray objectAtIndex:0]];
        self.gameData.hiddenSong = self.gameData.winningSong;
        UIAlertView *gameOverAlert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                               message:@"Marceline broke her guitar, she looks mad"
                                                              delegate:self
                                                     cancelButtonTitle:nil
                                                      otherButtonTitles:@"Try Again?", nil];
        [gameOverAlert show];
        //doesn't work yet
        NSURLRequest *newRequest = [self.gameRules createURLRequestFromString:self.gameData.winningSongURL];
        [webViewOutlet loadRequest:newRequest];
        NSLog(@"GAME OVER!!");
    }
    songLabelOutlet.text = self.gameData.hiddenSong;
    textFieldOutlet.text = @"";
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
