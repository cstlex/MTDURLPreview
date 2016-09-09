//
//  MTDURLPreview.h
//  MTDURLPreview
//
//  Created by Matthias Tretter on 09.07.13.
//  Copyright (c) 2013 @myell0w. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MTDURLPreviewView.h"


@class MTDURLPreview;


typedef void(^mtd_url_preview_block)(MTDURLPreview *preview, NSError *error);


@interface MTDURLPreview : NSObject

@property (nonatomic, readonly) NSString *url;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *domain;
@property (nonatomic, readonly) NSURL *imageURL;
@property (nonatomic, readonly) NSString *content;

- (instancetype)initWithTitle:(NSString *)title
                       domain:(NSString *)domain
                     imageURL:(NSURL *)imageURL
                      content:(NSString *)content;
- (instancetype)initWithTitle:(NSString *)title
                       domain:(NSString *)domain
                     imageURL:(NSURL *)imageURL
                      content:(NSString *)content
                          url:(NSString *)url;

+ (void)loadPreviewWithURL:(NSURL *)URL completion:(mtd_url_preview_block)completion;
+ (void)cancelLoadOfPreviewWithURL:(NSURL *)URL;

@end
