//
//  PHGameData.h
//  ExecuteTheExecutor
//
//  Created by StopBitingMe on 3/9/13.
//  Copyright (c) 2013 StopBitingMe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PHGameData : NSObject
{

}

@property (strong, nonatomic) NSString *winningSong;
@property (strong, nonatomic) NSArray *winningSongWords;
@property (strong, nonatomic) NSString *winningSongURL;
@property (strong, nonatomic) NSString *obscuredWord;
@property (strong, nonatomic) NSString *hiddenSong;
@property (strong, nonatomic) NSString *oldHiddenSong;
@property (assign, nonatomic) NSRange guessedRange;
@property (strong, nonatomic) NSString *guessedLetter;
@property (strong, nonatomic) NSMutableArray *guessedLetters;
@property (assign, nonatomic) int lengthOfCharacters;
@property (strong, nonatomic) NSString *hiddenWinningSong;
@property (strong, nonatomic) NSMutableArray *wronglyGuessedLetters;
@property (assign, nonatomic) int numberOfWrongGuesses;
@property (strong, nonatomic) NSArray *resultArray;
@property (strong, nonatomic) NSMutableArray *marcelineArray;



-(NSArray*)parseSpacesOutOfSong:(NSString*)winningSong;
-(NSString*)obscureWordsIndividually:(NSArray*)separatedWords;
-(NSString*)convertWordToUnderscore:(NSString*)obscuredWord;

@end
