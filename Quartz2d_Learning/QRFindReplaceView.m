//
//  QRFindReplaceView.m
//  Quartz2d_Learning
//
//  Created by yangzexin on 13-2-26.
//
//

#import "QRFindReplaceView.h"

@interface QRFindReplaceView ()

@property(nonatomic, retain)UILabel *matchingCountLabel;
@property(nonatomic, retain)UITextField *findTextField;
@property(nonatomic, retain)UISegmentedControl *selectMatchingSegmentedControl;
@property(nonatomic, retain)UITextField *replaceTextField;
@property(nonatomic, retain)UISegmentedControl *replaceSegmentedControl;

@end

@implementation QRFindReplaceView

- (void)dealloc
{
    self.matchingCountLabel = nil;
    self.findTextField = nil;
    self.selectMatchingSegmentedControl = nil;
    self.replaceTextField = nil;
    self.replaceSegmentedControl = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    CGFloat labelWidth = 30.0f;
    CGFloat segmentedControlWidth = 60;
    CGFloat spacing = 2.0f;
    CGFloat textFieldHeight = 35.0f;
    
    self.matchingCountLabel = [[UILabel new] autorelease];
    self.matchingCountLabel.backgroundColor = [UIColor clearColor];
    self.matchingCountLabel.font = [UIFont systemFontOfSize:14.0f];
    self.matchingCountLabel.frame = CGRectMake(spacing, 0, labelWidth, frame.size.height);
    self.matchingCountLabel.text = @"100";
    self.matchingCountLabel.textAlignment = UITextAlignmentCenter;
    [self addSubview:self.matchingCountLabel];
    
    self.findTextField = [self createTextField];
    self.findTextField.frame = CGRectMake(self.matchingCountLabel.frame.size.width + self.matchingCountLabel.frame.origin.x + spacing,
                                          (frame.size.height - textFieldHeight) / 2,
                                          (frame.size.width - labelWidth - 2 * segmentedControlWidth - 6 * spacing) / 2,
                                          textFieldHeight);
    self.selectMatchingSegmentedControl = [self createSegmentedControlWithFirstTitle:@"<-" secondTitle:@"->"];
    self.selectMatchingSegmentedControl.frame = CGRectMake(self.findTextField.frame.origin.x + self.findTextField.frame.size.width + spacing,
                                                           self.findTextField.frame.origin.y,
                                                           segmentedControlWidth,
                                                           self.findTextField.frame.size.height);
    self.replaceTextField = [self createTextField];
    self.replaceTextField.frame = CGRectMake(self.selectMatchingSegmentedControl.frame.origin.x + self.selectMatchingSegmentedControl.frame.size.width + spacing,
                                             self.findTextField.frame.origin.y,
                                             self.findTextField.frame.size.width,
                                             self.findTextField.frame.size.height);
    self.replaceSegmentedControl = [self createSegmentedControlWithFirstTitle:@"R" secondTitle:@"RA"];
    self.replaceSegmentedControl.frame = CGRectMake(self.replaceTextField.frame.origin.x + self.replaceTextField.frame.size.width + spacing,
                                                    self.selectMatchingSegmentedControl.frame.origin.y,
                                                    segmentedControlWidth,
                                                    self.selectMatchingSegmentedControl.frame.size.height);
    
    return self;
}

- (UITextField *)createTextField
{
    UITextField *textField = [[UITextField new] autorelease];
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:textField];
    
    return textField;
}

- (UISegmentedControl *)createSegmentedControlWithFirstTitle:(NSString *)firstTitle secondTitle:(NSString *)secondTitle
{
    UISegmentedControl *segControl = [[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:firstTitle, secondTitle, nil]] autorelease];
    segControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    segControl.momentary = YES;
    [self addSubview:segControl];
    
    return segControl;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
