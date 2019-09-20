#import "MTDURLPreviewView.h"
#import "MTDURLPreview.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/message.h>


#define kMTDPadding                 10.f
#define kMTDImageDimension          60.f
#define kMTDTitleLineBreakMode      NSLineBreakByTruncatingTail | NSLineBreakByWordWrapping


static UIFont *titleFont = nil;
static UIFont *domainFont = nil;


@implementation MTDURLPreviewView

@synthesize imageView = _imageView;

////////////////////////////////////////////////////////////////////////
#pragma mark - Lifecycle
////////////////////////////////////////////////////////////////////////

+ (void)initialize {
    if (self == [MTDURLPreviewView class]) {
        titleFont = [UIFont boldSystemFontOfSize:13.5f];
        domainFont = [UIFont systemFontOfSize:12.f];
    }
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        if (@available(iOS 13, *)){
            if ([[self traitCollection] userInterfaceStyle] == UIUserInterfaceStyleDark){
                self.backgroundColor = [UIColor colorWithRed:0.259f green:0.282f blue:0.302f alpha:1.0f];
                _textColor = [UIColor whiteColor];
                _subtitleColor = [UIColor colorWithRed:0.757f green:0.761f blue:0.804f alpha:1.0f];
                _borderColor = [[UIColor clearColor] colorWithAlphaComponent:0.0f];
            } else {
                self.backgroundColor = [UIColor colorWithRed:0.965f green:0.965f blue:0.965f alpha:1.0f];
                _textColor = [UIColor colorWithRed:0.243f green:0.259f blue:0.318f alpha:1.0f];
                _subtitleColor = [UIColor colorWithRed:0.243f green:0.259f blue:0.318f alpha:1.0f];
                _borderColor = [UIColor colorWithRed:0.820f green:0.820f blue:0.820f alpha:1.0f];
            }
        } else {
            self.backgroundColor = [UIColor colorWithRed:0.965f green:0.965f blue:0.965f alpha:1.0f];
            _textColor = [UIColor colorWithRed:0.243f green:0.259f blue:0.318f alpha:1.0f];
            _subtitleColor = [UIColor colorWithRed:0.243f green:0.259f blue:0.318f alpha:1.0f];
            _borderColor = [UIColor colorWithRed:0.820f green:0.820f blue:0.820f alpha:1.0f];
        }

        _titleLabel = [self labelWithFont:titleFont
                                textColor:_textColor
                            numberOfLines:2
                            lineBreakMode:kMTDTitleLineBreakMode];
        [self addSubview:_titleLabel];

        _domainLabel = [self labelWithFont:domainFont
                                 textColor:_subtitleColor
                             numberOfLines:1
                             lineBreakMode:NSLineBreakByTruncatingTail];
        [self addSubview:_domainLabel];


        if (CGColorGetAlpha(_borderColor.CGColor) == 0.0f) {
            self.layer.borderWidth = 0.0f;
        } else {
            self.layer.borderWidth = 1.f / [UIScreen mainScreen].scale;
            self.layer.borderColor = _borderColor.CGColor;
        }
    }
    
    return self;
}

- (void)initialize {
    if (@available(iOS 13, *)){
        if ([[self traitCollection] userInterfaceStyle] == UIUserInterfaceStyleDark){
            self.backgroundColor = [UIColor colorWithRed:0.259f green:0.282f blue:0.302f alpha:1.0f];
            _textColor = [UIColor whiteColor];
            _subtitleColor = [UIColor colorWithRed:0.757f green:0.761f blue:0.804f alpha:1.0f];
            _borderColor = [[UIColor clearColor] colorWithAlphaComponent:0.0f];
        } else {
            self.backgroundColor = [UIColor colorWithRed:0.965f green:0.965f blue:0.965f alpha:1.0f];
            _textColor = [UIColor colorWithRed:0.243f green:0.259f blue:0.318f alpha:1.0f];
            _subtitleColor = [UIColor colorWithRed:0.243f green:0.259f blue:0.318f alpha:1.0f];
            _borderColor = [UIColor colorWithRed:0.820f green:0.820f blue:0.820f alpha:1.0f];
        }
    } else {
        self.backgroundColor = [UIColor colorWithRed:0.965f green:0.965f blue:0.965f alpha:1.0f];
        _textColor = [UIColor colorWithRed:0.243f green:0.259f blue:0.318f alpha:1.0f];
        _subtitleColor = [UIColor colorWithRed:0.243f green:0.259f blue:0.318f alpha:1.0f];
        _borderColor = [UIColor colorWithRed:0.820f green:0.820f blue:0.820f alpha:1.0f];
    }
    
    _titleLabel = [self labelWithFont:titleFont
                            textColor:_textColor
                        numberOfLines:2
                        lineBreakMode:kMTDTitleLineBreakMode];
    [self addSubview:_titleLabel];
    
    _domainLabel = [self labelWithFont:domainFont
                             textColor:_subtitleColor
                         numberOfLines:1
                         lineBreakMode:NSLineBreakByTruncatingTail];
    [self addSubview:_domainLabel];
    
    
    if (CGColorGetAlpha(_borderColor.CGColor) == 0.0f) {
        self.layer.borderWidth = 0.0f;
    } else {
        self.layer.borderWidth = 1.f / [UIScreen mainScreen].scale;
        self.layer.borderColor = _borderColor.CGColor;
    }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    
    if (@available(iOS 13, *)) {
        UIColor *tc;
        UIColor *stc;
        UIColor *bc;
        if ([[self traitCollection] userInterfaceStyle] == UIUserInterfaceStyleDark){
            self.backgroundColor = [UIColor colorWithRed:0.259f green:0.282f blue:0.302f alpha:1.0f];
            tc = [UIColor whiteColor];
            stc = [UIColor colorWithRed:0.757f green:0.761f blue:0.804f alpha:1.0f];
            stc = [[UIColor clearColor] colorWithAlphaComponent:0.0f];
        } else {
            self.backgroundColor = [UIColor colorWithRed:0.965f green:0.965f blue:0.965f alpha:1.0f];
            tc = [UIColor colorWithRed:0.243f green:0.259f blue:0.318f alpha:1.0f];
            stc = [UIColor colorWithRed:0.243f green:0.259f blue:0.318f alpha:1.0f];
            stc = [UIColor colorWithRed:0.820f green:0.820f blue:0.820f alpha:1.0f];
        }
        [self setTextColor:tc];
        [self setSubtitleColor:stc];
        [self setBorderColor:bc];
    }
}

- (void)dealloc {
    // Support for SDWebImage
    if ([_imageView respondsToSelector:@selector(sd_cancelCurrentImageLoad)]) {
        [_imageView performSelector:@selector(sd_cancelCurrentImageLoad)];
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Class Methods
////////////////////////////////////////////////////////////////////////

+ (CGFloat)neededHeightForTitle:(NSString *)title
                         domain:(NSString *)domain
                        content:(NSString *)content
                   imageVisible:(BOOL)imageVisible
             constrainedToWidth:(CGFloat)width {

    CGFloat textX = kMTDPadding;
    CGFloat minHeight = 0.f;

    if (imageVisible) {
        textX = kMTDPadding + kMTDImageDimension + kMTDPadding;
        minHeight = kMTDPadding + 3.f + kMTDImageDimension + kMTDPadding;
    }

    CGFloat textWidth = width - textX - kMTDPadding;
    CGFloat domainHeight = ceil(domainFont.lineHeight);
    CGFloat maxTitleHeight = titleFont.lineHeight * 3.f;
    CGSize constraint = CGSizeMake(textWidth, maxTitleHeight);
    CGSize sizeTitle = [title sizeWithFont:titleFont constrainedToSize:constraint lineBreakMode:kMTDTitleLineBreakMode];

    return MAX(minHeight, kMTDPadding + ceil(sizeTitle.height) + domainHeight + kMTDPadding);
}

+ (void)setTitleFont:(UIFont *)titleFont {
    titleFont = titleFont;
}

+ (void)setDomainFont:(UIFont *)domainFont {
    domainFont = domainFont;
}

////////////////////////////////////////////////////////////////////////
#pragma mark - UIView
////////////////////////////////////////////////////////////////////////

- (CGSize)sizeThatFits:(CGSize)size {
    return [self sizeOfContentsWithSize:size shouldLayout:NO];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self sizeOfContentsWithSize:self.bounds.size shouldLayout:YES];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    if (backgroundColor == nil){
        if (@available(iOS 13, *)){
            if ([[self traitCollection] userInterfaceStyle] == UIUserInterfaceStyleDark){
                backgroundColor = [UIColor colorWithRed:0.259f green:0.282f blue:0.302f alpha:1.0f];
            } else {
                backgroundColor = [UIColor colorWithRed:0.965f green:0.965f blue:0.965f alpha:1.0f];
                
            }
        } else {
            backgroundColor = [UIColor colorWithRed:0.965f green:0.965f blue:0.965f alpha:1.0f];
        }
    }
    [super setBackgroundColor:backgroundColor];

    self.titleLabel.backgroundColor = backgroundColor;
    self.domainLabel.backgroundColor = backgroundColor;
    self.contentLabel.backgroundColor = backgroundColor;
}

////////////////////////////////////////////////////////////////////////
#pragma mark - MTDURLPreviewView+MTDModelObject
////////////////////////////////////////////////////////////////////////

+ (CGFloat)neededHeightForURLPreview:(MTDURLPreview *)preview constrainedToWidth:(CGFloat)width {
    return [self neededHeightForTitle:preview.title
                               domain:preview.domain
                              content:preview.content
                         imageVisible:YES
                   constrainedToWidth:width];
}

- (void)setFromURLPreview:(MTDURLPreview *)preview {
    self.titleLabel.text = preview.title;
    self.domainLabel.text = preview.domain;
    self.contentLabel.text = preview.content;

    UIImage *placeholderImage = [UIImage imageNamed:@"MTDURLPreview.bundle/image-placeholder"];
    self.imageView.image = placeholderImage;
    if (preview.imageURL != nil) {
        // Support for SDWebImage
        if ([self.imageView respondsToSelector:@selector(sd_setImageWithURL:placeholderImage:)]) {
            [self.imageView performSelector:@selector(sd_setImageWithURL:placeholderImage:) withObject:preview.imageURL withObject:placeholderImage];
        }
    }

    [self sizeToFit];
    [self setNeedsLayout];
}

- (void)setTextColor:(UIColor *)textColor {
    if (textColor != _textColor) {
        _textColor = textColor;
        self.titleLabel.textColor = textColor;
        self.domainLabel.textColor = textColor;
        self.contentLabel.textColor = textColor;
    }
}

- (void)setBorderColor:(UIColor *)borderColor {
    if (borderColor != _borderColor) {
        _borderColor = borderColor;
        self.layer.borderColor = _borderColor.CGColor;
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Private
////////////////////////////////////////////////////////////////////////

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MTDURLPreview.bundle/image-placeholder"]];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self addSubview:_imageView];
    }

    return _imageView;
}

- (id)labelWithFont:(UIFont *)font
          textColor:(UIColor *)textColor
      numberOfLines:(NSUInteger)numberOfLines
      lineBreakMode:(NSLineBreakMode)lineBreakMode {
    UILabel *label =  [[UILabel alloc] initWithFrame:CGRectZero];

    label.opaque = YES;
    label.font = font;
    label.textColor = textColor;
    label.highlightedTextColor = textColor;
    label.lineBreakMode = lineBreakMode;
    label.numberOfLines = numberOfLines;

    return label;
}

- (CGSize)sizeOfContentsWithSize:(CGSize)size
                    shouldLayout:(BOOL)shouldLayout {
    CGFloat textX = kMTDPadding;
    CGFloat minHeight = 0.f;

    if (_imageView != nil) {
        textX = kMTDPadding + kMTDImageDimension + kMTDPadding;
        minHeight = kMTDPadding + 3.f + kMTDImageDimension + kMTDPadding;
    }

    CGFloat textWidth = size.width - textX - kMTDPadding;
    CGFloat domainHeight = ceil(self.domainLabel.font.lineHeight);
    CGFloat maxTitleHeight = self.titleLabel.font.lineHeight * 3.f;
    CGSize constraint = CGSizeMake(textWidth, maxTitleHeight);
    CGSize sizeTitle = [self.titleLabel.text sizeWithFont:self.titleLabel.font constrainedToSize:constraint lineBreakMode:self.titleLabel.lineBreakMode];
    sizeTitle = CGSizeMake(ceil(sizeTitle.width), ceil(sizeTitle.height));

    if (shouldLayout) {
        _imageView.frame = CGRectMake(kMTDPadding, kMTDPadding + 1.5f, kMTDImageDimension, kMTDImageDimension);
        self.titleLabel.frame = CGRectMake(textX, kMTDPadding + 5.0f, textWidth, ceil(self.titleLabel.font.lineHeight * 2));
        self.domainLabel.frame = CGRectMake(textX, CGRectGetMaxY(self.titleLabel.frame)+3.0f, textWidth, domainHeight);
    }

//    return CGSizeMake(size.width, MAX(minHeight, kMTDPadding + sizeTitle.height + domainHeight + kMTDPadding));
    return CGSizeMake(size.width, MAX(minHeight, kMTDPadding + 3.f + kMTDImageDimension + kMTDPadding));
}

@end
