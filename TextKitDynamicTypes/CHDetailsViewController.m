//
//  CHDetailsViewController.m
//  TextKitDynamicTypes
//
//  Created by David Bonnet on 28/11/2013.
//  Copyright (c) 2013 David Bonnet. All rights reserved.
//

#import "CHDetailsViewController.h"

@interface CHDetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextField;

@property (nonatomic, strong) NSString *articleTitle;
@property (nonatomic, strong) NSString *content;

@end

@implementation CHDetailsViewController

- (id)initWithTitle:(NSString*)title content:(NSString*)content
{
    self = [self initWithNibName:@"CHDetailsViewController" bundle:nil];
    if (self) {
        // Custom initialization
        self.articleTitle   = title;
        self.content        = content;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Détails";
    
    self.titleLabel.text = self.articleTitle;
    self.contentTextField.text = self.content;
    
    [self configureSizes];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(configureSizes)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureSizes
{
    UIFontDescriptor *headlineDescriptor        = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleHeadline];
    CGFloat           headlineSize              = [headlineDescriptor.fontAttributes[UIFontDescriptorSizeAttribute] floatValue];
    
    self.titleLabel.font       = [UIFont fontWithName:@"Zapfino" size:headlineSize];
    
    UIFontDescriptor *bodyDescriptor            = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleBody];
    UIFontDescriptor *italicBodyDescriptor      = [bodyDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitItalic];
    CGFloat           bodySize                  = [bodyDescriptor.fontAttributes[UIFontDescriptorSizeAttribute] floatValue];
    
    self.contentTextField.font = [UIFont fontWithDescriptor:italicBodyDescriptor size:bodySize];
}

@end
