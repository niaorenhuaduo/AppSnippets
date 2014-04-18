#import "AMRatingControlViewController.h"
#import "AMRatingControl.h"


@interface AMRatingControlViewController (Private)

- (void)updateRating:(id)sender;
- (void)updateEndRating:(id)sender;

@end


@implementation AMRatingControlViewController


/**************************************************************************************************/
#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Create a simple instance, initing with :
    // - a CGPoint (the position in your view from which it will be drawn)
    // - and max rating
	AMRatingControl *simpleRatingControl = [[AMRatingControl alloc] initWithLocation:CGPointMake(110, 50)
                                                                  andMaxRating:5];
    
    // Customize the current rating if needed
    [simpleRatingControl setRating:3];
    
    // Listen to control events
	[simpleRatingControl addTarget:self action:@selector(updateRating:) forControlEvents:UIControlEventEditingChanged];
    [simpleRatingControl addTarget:self action:@selector(updateEndRating:) forControlEvents:UIControlEventEditingDidEnd];

    
    // Create an instance with images, initing with :
    // - a CGPoint (the position in your view from which it will be drawn)
    // - a custom empty image and solid image if you wish (pass nil if you want to use the default).
    // - and max rating
	UIImage *dot, *star;
	dot = [UIImage imageNamed:@"dot.png"];
	star = [UIImage imageNamed:@"star.png"];
	AMRatingControl *imagesRatingControl = [[AMRatingControl alloc] initWithLocation:CGPointMake(110, 250)
                                                                      emptyImage:dot
                                                                      solidImage:star
                                                                    andMaxRating:5];
    
    // Create an instance with custom color, initing with :
    // - a CGPoint (the position in your view from which it will be drawn)
    // - a custom empty image and solid image if you wish (pass nil if you want to use the default).
    // - and max rating
	AMRatingControl *coloredRatingControl = [[AMRatingControl alloc] initWithLocation:CGPointMake(110, 370)
                                                                           emptyColor:[UIColor yellowColor]
                                                                           solidColor:[UIColor redColor]
                                                                         andMaxRating:5];
                                                                        
    
    
    
    // Add the control(s) as a subview of your view
	[self.view addSubview:simpleRatingControl];
    [self.view addSubview:imagesRatingControl];
    [self.view addSubview:coloredRatingControl];
}


/**************************************************************************************************/
#pragma mark - Private Methods

- (void)updateRating:(id)sender
{
	NSLog(@"Rating: %d", [(AMRatingControl *)sender rating]);
	[label setText:[NSString stringWithFormat:@"%d", [(AMRatingControl *)sender rating]]];
}

- (void)updateEndRating:(id)sender
{
    NSLog(@"End Rating: %d", [(AMRatingControl *)sender rating]);
	[endLabel setText:[NSString stringWithFormat:@"%d", [(AMRatingControl *)sender rating]]];
}


@end
