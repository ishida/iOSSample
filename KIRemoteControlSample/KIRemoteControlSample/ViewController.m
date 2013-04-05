//
//  ViewController.m
//  KIRemoteControlSample
//
//  Created by Katsunobu Ishida on 2013/04/05.
//  Copyright (c) 2013 Katsunobu Ishida. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()
@property MPMoviePlayerController *moviePlayer;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializePlayer];
    [self initializeBackgroundPlayback];// this is needed to show playback icon on statusbar
    [self initializeRemoteControl];     // this is needed to show playback icon on statusbar
    [self play];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - Player

- (void)initializePlayer
{
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:
                        [NSURL fileURLWithPath:
                         [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"mp3"]]];
    self.moviePlayer.view.frame = self.playerView.frame;
    [self.view addSubview:self.moviePlayer.view];
}

- (void)play
{
    [self.moviePlayer play];
    
    [self updateNowPlayingInfo];
}

- (void)pause
{
    [self.moviePlayer pause];
}

- (void)stop
{
    [self.moviePlayer stop];
}

- (void)playOrPause
{
    if (self.moviePlayer.playbackState == MPMoviePlaybackStatePlaying)
    {
        [self pause];
    }
    else
    {
        [self play];
    }
}

- (void)initializeBackgroundPlayback
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *e = nil;
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:&e];
    if (e)
    {
        // error handling
    }
    e = nil;
    [audioSession setActive:YES error:&e];
    if (e)
    {
        // error handling
    }
    //    self.moviePlayer.useApplicationAudioSession = YES;
}

#pragma mark - Remote Control

- (void)initializeRemoteControl
{
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

- (void)finalizeRemoteControl
{
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)receivedEvent
{
    if (receivedEvent.type != UIEventTypeRemoteControl) return;
    
    switch (receivedEvent.subtype)
    {
        case UIEventSubtypeRemoteControlPlay:
            self.eventLabel.text = @"Play";
            [self play];
            break;
        case UIEventSubtypeRemoteControlPause:
            self.eventLabel.text = @"Pause";
            [self pause];
            break;
        case UIEventSubtypeRemoteControlStop:
            self.eventLabel.text = @"Stop";
            [self stop];
            break;
        case UIEventSubtypeRemoteControlTogglePlayPause:
            self.eventLabel.text = @"TogglePlayPause";
            [self playOrPause];
            break;
        case UIEventSubtypeRemoteControlNextTrack:
            self.eventLabel.text = @"NextTrack";
            break;
        case UIEventSubtypeRemoteControlPreviousTrack:
            self.eventLabel.text = @"PreviousTrack";
            break;
        case UIEventSubtypeRemoteControlBeginSeekingBackward:
            self.eventLabel.text = @"BeginSeekingBackward";
            break;
        case UIEventSubtypeRemoteControlEndSeekingBackward:
            self.eventLabel.text = @"EndSeekingBackward";
            break;
        case UIEventSubtypeRemoteControlBeginSeekingForward:
            self.eventLabel.text = @"BeginSeekingForward";
            break;
        case UIEventSubtypeRemoteControlEndSeekingForward:
            self.eventLabel.text = @"EndSeekingForward";
            break;
        default:
            break;
    }
}

- (void)updateNowPlayingInfo
{
    Class c = NSClassFromString(@"MPNowPlayingInfoCenter");
    if (!c) return;
    
    NSDictionary *info = @{MPMediaItemPropertyTitle: @"Sample Title",
                           MPMediaItemPropertyArtist: @"Sample Artist",
                           MPMediaItemPropertyAlbumTitle: @"Sample Album Title"};
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:info];
}

@end
