//
//  MSMovieBrowser.h
//  MSMovieBrowser
//
//  Created by mrscorpion on 16/7/5.
//  Copyright © 2016年 mrscorpion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSMovie.h"

#define kMovieBrowserHeight 125.0

@class MSMovieBrowser;
@protocol MSMovieBrowserDelegate <NSObject>

@optional
- (void)movieBrowser:(MSMovieBrowser *)movieBrowser didSelectItemAtIndex:(NSInteger)index;
- (void)movieBrowser:(MSMovieBrowser *)movieBrowser didEndScrollingAtIndex:(NSInteger)index;
- (void)movieBrowser:(MSMovieBrowser *)movieBrowser didChangeItemAtIndex:(NSInteger)index;

@end

@interface MSMovieBrowser : UIView

@property (nonatomic, assign, readwrite) id<MSMovieBrowserDelegate> delegate;
@property (nonatomic, assign, readonly)  NSInteger currentIndex;

- (instancetype)initWithFrame:(CGRect)frame movies:(NSArray *)movies;
- (instancetype)initWithFrame:(CGRect)frame movies:(NSArray *)movies currentIndex:(NSInteger)index;
- (void)setCurrentMovieIndex:(NSInteger)index;

@end
