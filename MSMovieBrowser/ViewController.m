//
//  ViewController.m
//  MSMovieBrowser
//
//  Created by mrscorpion on 16/7/5.
//  Copyright © 2016年 mrscorpion. All rights reserved.
//

#import "ViewController.h"
#import "MSMovieBrowser.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController () <MSMovieBrowserDelegate>

@property (nonatomic, strong, readwrite) MSMovieBrowser *movieBrowser;
@property (nonatomic, strong, readwrite) UILabel *titileLabel;
@property (nonatomic, strong, readwrite) NSMutableArray *movies;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"朝阳剧场";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    
    [self setupSubviews];
}

- (void)setupSubviews
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"movies" ofType:@"plist"];
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:filePath];
    
    NSMutableArray *movies = [NSMutableArray array];
    for (NSDictionary *dict in dictArray) {
        MSMovie *movie = [[MSMovie alloc] init];
        movie.name = dict[@"name"];
        movie.coverUrl = dict[@"coverUrl"];
        [movies addObject:movie];
    }
    self.movies = movies;
    
    MSMovieBrowser *movieBrowser = [[MSMovieBrowser alloc] initWithFrame:CGRectMake(0, 200, kScreenWidth, kMovieBrowserHeight) movies:self.movies currentIndex:1];
    movieBrowser.delegate = self;
    [self.view addSubview:movieBrowser];
    self.movieBrowser = movieBrowser;
    
    UILabel *titileLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 330, kScreenWidth, 50)];
    titileLabel.textAlignment = NSTextAlignmentCenter;
    titileLabel.textColor = [UIColor blackColor];
    titileLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:titileLabel];
    self.titileLabel = titileLabel;
}

#pragma mark - MSMovieBrowserDelegate

- (void)movieBrowser:(MSMovieBrowser *)movieBrowser didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"跳转详情页---%@", ((MSMovie *)self.movies[index]).name);
    
    UIViewController *movieDetailVc = [[UIViewController alloc] init];
    movieDetailVc.view.backgroundColor = [UIColor whiteColor];
    movieDetailVc.title = ((MSMovie *)self.movies[index]).name;
    [self.navigationController pushViewController:movieDetailVc animated:YES];
}

- (void)movieBrowser:(MSMovieBrowser *)movieBrowser didChangeItemAtIndex:(NSInteger)index
{
    NSLog(@"index: %ld", index);
    
    self.titileLabel.text = ((MSMovie *)self.movies[index]).name;
}

static NSInteger _lastIndex = -1;
- (void)movieBrowser:(MSMovieBrowser *)movieBrowser didEndScrollingAtIndex:(NSInteger)index
{
    if (_lastIndex != index) {
        NSLog(@"刷新---%@", ((MSMovie *)self.movies[index]).name);
    }
    _lastIndex = index;
}

@end

