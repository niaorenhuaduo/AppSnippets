/*
     File: HazardMapViewController.m 
 Abstract: Main view controller for the application.  Implements MKMapViewDelegate to manage adding
 a HazardMap overlay to a MKMapView and to manage display of a HazardMapView on the MKMapView. 
  Version: 1.1 
  
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple 
 Inc. ("Apple") in consideration of your agreement to the following 
 terms, and your use, installation, modification or redistribution of 
 this Apple software constitutes acceptance of these terms.  If you do 
 not agree with these terms, please do not use, install, modify or 
 redistribute this Apple software. 
  
 In consideration of your agreement to abide by the following terms, and 
 subject to these terms, Apple grants you a personal, non-exclusive 
 license, under Apple's copyrights in this original Apple software (the 
 "Apple Software"), to use, reproduce, modify and redistribute the Apple 
 Software, with or without modifications, in source and/or binary forms; 
 provided that if you redistribute the Apple Software in its entirety and 
 without modifications, you must retain this notice and the following 
 text and disclaimers in all such redistributions of the Apple Software. 
 Neither the name, trademarks, service marks or logos of Apple Inc. may 
 be used to endorse or promote products derived from the Apple Software 
 without specific prior written permission from Apple.  Except as 
 expressly stated in this notice, no other rights or licenses, express or 
 implied, are granted by Apple herein, including but not limited to any 
 patent rights that may be infringed by your derivative works or by other 
 works in which the Apple Software may be incorporated. 
  
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE 
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION 
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS 
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND 
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS. 
  
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL 
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, 
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED 
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE), 
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE 
 POSSIBILITY OF SUCH DAMAGE. 
  
 Copyright (C) 2010 Apple Inc. All Rights Reserved. 
  
 */

#import "HazardMapViewController.h"

#import "HazardMap.h"
#import "HazardMapView.h"

@implementation HazardMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Find and load the earthquake hazard grid from the application's bundle
    NSString *hazardPath = [[NSBundle mainBundle] pathForResource:@"UShazard.20081229.pga.5pc50"
                                                           ofType:@"bin"];
    HazardMap *hazards = [[HazardMap alloc] initWithHazardMapFile:hazardPath];
    
    // Position and zoom the map to just fit the grid loaded on screen
    [map setVisibleMapRect:[hazards boundingMapRect]];
    
    float locations[] = {100.22569199999998,26.876812,
        100.233836,26.876952,
        100.14611000000002,26.862355,
        100.23457800000006,26.883319,
        100.261212,27.097237}; 
    MKMapPoint* points = malloc(sizeof(CLLocationCoordinate2D) * 5);
    for (int i = 0; i < 5; i++) { 
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(locations[2*i+1], locations[2*i]);
        points[i] = MKMapPointForCoordinate(coord);
    }
    MKPolyline *line = [MKPolyline polylineWithPoints:points count:5];
    
    
    // Add the earthquake hazard map to the map view
    [map addOverlay:hazards];
    
    [map addOverlay:line];
    
    NSArray *overlays = [map overlays];
    NSLog(@"overlays: %i", [overlays count]);
    
    // Let the map view own the hazards model object now
    [hazards release];
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]) 
    {
        MKPolylineView *lineview = [[[MKPolylineView alloc] initWithOverlay:overlay] autorelease];
        lineview.fillColor = [UIColor redColor];
        lineview.strokeColor=[[UIColor redColor] colorWithAlphaComponent:0.5];
        lineview.lineWidth=2.0;
        return lineview;
    } else {
        HazardMapView *view = [[HazardMapView alloc] initWithOverlay:overlay];
        return [view autorelease];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

@end
